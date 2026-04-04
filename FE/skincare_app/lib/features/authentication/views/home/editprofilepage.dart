import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:skincare_app/common/widgets/cbutton.dart';
import 'package:skincare_app/common/widgets/cdatetextformfield.dart';
import 'package:skincare_app/common/widgets/ctextformfield.dart';
import 'package:skincare_app/core/utils/date_formater.dart';
import 'package:skincare_app/features/authentication/data/auth_repository.dart';
import 'package:skincare_app/features/authentication/models/user.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formEdit = GlobalKey<FormState>();
  DateTime? selectedDate;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  User? user;
  bool isLoading = true;
  // Thieu cai de upload anh

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    final data = await AuthRepository().getMe();

    setState(() {
      user = data;
      _nameController.text = data.name!;
      _emailController.text = data.email;
      _phoneController.text = data.phone!;
      selectedDate = DateTime.parse(data.dob!);
      isLoading = false;
    });
  }

  Future<bool> _updateInfo(
    String name,
    String email,
    String phone,
    String dob,
    String imageUrl,
  ) async {
    final res = await AuthRepository().updateMe(
      name,
      email,
      phone,
      dob,
      imageUrl,
    );

    print('res: $res');

    if (res) {
      await _loadUserInfo();
      setState(() {});
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) return CircularProgressIndicator();
    return Scaffold(
      appBar: AppBar(title: Text("Edit Profile")),
      body: Form(
        key: _formEdit,
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(16.0),
          child: Column(
            spacing: 12,
            children: [
              CTextFormField(
                labelText: 'Full Name',
                prefixIcon: Icon(Icons.person),
                controller: _nameController,
              ),
              CTextFormField(
                labelText: 'Email',
                prefixIcon: Icon(Icons.mail),
                isEmail: true,
                controller: _emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email to receive recovering password';
                  }
                  final bool emailValid = RegExp(
                    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$",
                  ).hasMatch(value);
                  if (!emailValid) {
                    return 'Please enter valid email';
                  }
                  return null;
                },
              ),
              CTextFormField(
                labelText: 'Phone number',
                prefixIcon: Icon(Icons.person),
                controller: _phoneController,
                isPhone: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Enter your phone";
                  }
                  if (value.length != 10) {
                    return "Please enter valid phone number (10 number)";
                  }
                  return null;
                },
              ),
              CDateTimePickerFormField(
                label: "DOB",
                pickTime: false,
                initialValue: selectedDate,
                onChanged: (value) {
                  selectedDate = value;
                },
                validator: (value) {
                  if (value == null) return "Please choose your date of birth";
                  return null;
                },
              ),
              CButton(
                text: 'Save changes',
                onPress: () async {
                  // Navigator.pop(context);
                  
                  if (_formEdit.currentState!.validate()) {
                    setState(() => isLoading = true);
                    _formEdit.currentState!.save();
                    print(_nameController.text);
                    print(_emailController.text);
                    print(_phoneController.text);
                    print(formatDate(selectedDate!));
                    if (selectedDate == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Please choose your date of birth!"),
                        ),
                      );
                      return;
                    }
                    try {
                      final update = await _updateInfo(
                        _nameController.text,
                        _emailController.text,
                        _phoneController.text,
                        DateFormat('yyyy-MM-dd').format(selectedDate!).toString(),
                        '',
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            update
                                ? 'Update user information successfully!'
                                : 'Update user information failed!',
                            textAlign: TextAlign.center,
                          ),
                          duration: Duration(seconds: 3),
                        ),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Something went wrong, retry later!'),
                          duration: Duration(seconds: 3),
                        ),
                      );
                    } finally {
                      setState(() => isLoading = false);
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
