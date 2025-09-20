import 'package:flutter/material.dart';
import 'package:skincare_app/common/widgets/cpasswordfield.dart';
import 'package:skincare_app/common/widgets/ctextformfield.dart';
import 'package:skincare_app/core/routes/app_router.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<StatefulWidget> createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();

  @override
  void initState() {
    super.initState();
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
                  Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 60,
                      fontFamily: 'Dancing Script',
                    ),
                  ),
                  SizedBox(height: 20),
                  CTextFormField(
                    hintText: 'User Name',
                    labelText: 'User Name *',
                    prefixIcon: Icon(Icons.person),
                  ),
                  CTextFormField(
                    hintText: 'Phone number',
                    labelText: 'Phone *',
                    prefixIcon: Icon(Icons.phone),
                    isPhone: true,
                  ),
                  CTextFormField(
                    hintText: 'Email',
                    labelText: 'Email *',
                    prefixIcon: Icon(Icons.email),
                    isEmail: true,
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
                  CustomPasswordField(
                    controller: _passwordConfirmController,
                    label: 'Password Confirm',
                    hintText: 'Password Confirm',
                    validator: (value) {
                      if (value != _passwordController.text) {
                        return 'Password not match';
                      }
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
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Have an account?'),
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
                    onPressed: () {
                      Navigator.pushNamed(context, AppRouter.home);
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 20, 
                        color: Colors.white,
                        // fontFamily: 'Dancing Script'
                      ),
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
                        'Or sign up with',
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 16
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
          ),
        ),
      ),
    );
  }
}
