import 'package:flutter/material.dart';
import 'package:skincare_app/common/widgets/cbutton.dart';
import 'package:skincare_app/common/widgets/cpasswordfield.dart';
import 'package:skincare_app/features/authentication/data/auth_repository.dart';

class ChangePasswordPage extends StatefulWidget {
  ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _currentPsw = TextEditingController();
  final TextEditingController _newPsw = TextEditingController();
  final TextEditingController _confirmPsw = TextEditingController();
  final _formChangePsw = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    if (isLoading) return CircularProgressIndicator();
    return Scaffold(
      appBar: AppBar(title: Text("Change password")),
      body: Form(
        key: _formChangePsw,
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(16.0),
          child: Column(
            spacing: 12,
            children: [
              CustomPasswordField(
                hintText: '',
                label: 'Current password',
                prefixIcon: Icon(Icons.password),
                controller: _currentPsw,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter old password";
                  }
                  if (value.length < 6) {
                    return "Valid password contains more than 6 characters";
                  }
                  return null;
                },
              ),
              CustomPasswordField(
                hintText: '',
                label: 'New password',
                prefixIcon: Icon(Icons.password),
                controller: _newPsw,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter new password";
                  }
                  if (value.length < 6) {
                    return "Valid password contains more than 6 characters";
                  }
                  if (value != _newPsw.text) {
                    return "New password must be the same as confirm password";
                  }
                  return null;
                },
              ),
              CustomPasswordField(
                hintText: '',
                label: 'Confirm password',
                prefixIcon: Icon(Icons.password),
                controller: _confirmPsw,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter confirm password";
                  }
                  if (value.length < 6) {
                    return "Valid password contains more than 6 characters";
                  }
                  if (value != _newPsw.text) {
                    return "Confirm password must be the same as new password";
                  }
                  return null;
                },
              ),

              CButton(
                text: 'Change password',
                onPress: () async {
                  // Navigator.pop(context);
                  if (_formChangePsw.currentState!.validate()) {
                    setState(() => isLoading = true);
                    try {
                      final result = await AuthRepository().changePassword(
                        _currentPsw.text,
                        _newPsw.text,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            result.isSuccess
                                ? "Change password successfully!"
                                : result.error ?? "Error",
                          ),
                        ),
                      );
                    } finally {
                      setState(() {
                        _currentPsw.clear();
                        _newPsw.clear();
                        _confirmPsw.clear();
                        isLoading = false;
                      });
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
