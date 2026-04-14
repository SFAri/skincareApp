import 'package:flutter/material.dart';
import 'package:skincare_app/common/widgets/cdialogform.dart';
import 'package:skincare_app/common/widgets/cpasswordfield.dart';
import 'package:skincare_app/common/widgets/ctextformfield.dart';
import 'package:skincare_app/core/routes/app_router.dart';
import 'package:skincare_app/features/authentication/data/auth_repository.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final _formLogin = GlobalKey<FormState>();

  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _emailForgetController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _showDialog(
    BuildContext context,
    String title,
    Function acceptFunction,
  ) {
    final couponCodeController = TextEditingController();
    final discountController = TextEditingController();
    final usageController = TextEditingController();

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return DialogForm(
          title: title,
          widgets: SingleChildScrollView(
            child: Column(
              spacing: 10,
              children: [
                SizedBox(height: 8),
                Text(
                  'Enter your email, we will send you a link to reset your password',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey.shade700),
                ),
                CTextFormField(
                  controller: _emailForgetController,
                  labelText: 'Email',
                  hintText: 'Enter Your Email',
                  isEmail: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email to receive recovering password';
                    }
                    return null;
                  },
                  prefixIcon: Icon(Icons.email),
                ),
              ],
            ),
          ),
          acceptFunction: () {
            final updatedCoupon = {
              'code': couponCodeController.text,
              'discountAmount': double.tryParse(discountController.text) ?? 0.0,
              'usageLimit': double.tryParse(usageController.text) ?? 10,
              'isActive': true,
            };
            acceptFunction(updatedCoupon);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(color: Color.fromARGB(255, 253, 248, 244)),
          padding: EdgeInsets.all(10),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 10,
                children: [
                  Form(
                    key: _formLogin,
                    child: Column(
                      spacing: 10,
                      children: [
                        Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 60,
                            fontFamily: 'Dancing Script',
                          ),
                        ),
                        // SizedBox(height: 30),
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            prefixIcon: Icon(Icons.email),
                            hintText: 'Email or phone',
                            label: Text('Email or Phone number *'),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            final bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$",
                            ).hasMatch(value);
                            if (!emailValid) {
                              return 'Please enter valid email';
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                        CustomPasswordField(
                          controller: _passwordController,
                          label: 'Password',
                          hintText: 'Password',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter password';
                            }
                            if (value.length < 6) {
                              return 'Password must have at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () {
                                _showDialog(context, 'Forget password', (data) {
                                  // Handle adding the new variant data here
                                  // handleAddCoupon(context, data);
                                });
                              },
                              child: Text('Forgot password?'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, AppRouter.signup);
                              },
                              child: Text('Sign up?'),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(
                              double.infinity,
                              50,
                            ), // Set width to fill parent, and a fixed height
                            backgroundColor: Color.fromARGB(255, 210, 172, 142),
                          ),
                          onPressed: () async {
                            if (_formLogin.currentState!.validate()) {
                              final success = await AuthRepository().login(
                                _emailController.text,
                                _passwordController.text,
                              );

                              if (success.isSuccess) {
                                Navigator.pushReplacementNamed(
                                  context,
                                  AppRouter.home,
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(success.error ?? "Login failed, wrong password or email.")),
                                );
                              }
                            }
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 100,
                              height: 2,
                              child: Container(color: Colors.grey.shade300),
                            ),
                            Text(
                              'Or sign in with',
                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              width: 100,
                              height: 2,
                              child: Container(color: Colors.grey.shade300),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            side: BorderSide.none,
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(8),
                          ),
                          onPressed: () {},
                          child: Image.asset(
                            'assets/logos/google_logo.png',
                            width: 50,
                            // height: ,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
