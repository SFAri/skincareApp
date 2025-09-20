import 'package:flutter/material.dart';
import 'package:skincare_app/common/widgets/cbutton.dart';
import 'package:skincare_app/common/widgets/cpasswordfield.dart';

class ChangePasswordPage extends StatefulWidget {
 ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _currentPsw = TextEditingController();
  final TextEditingController _newPsw = TextEditingController();
  final TextEditingController _confirmPsw = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Change password")),
      body: Container(
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
            ),
            CustomPasswordField(
              hintText: '', 
              label: 'New password',
              prefixIcon: Icon(Icons.password),
              controller: _newPsw,
            ),
            CustomPasswordField(
              hintText: '', 
              label: 'Confirm password',
              prefixIcon: Icon(Icons.password),
              controller: _confirmPsw,
            ),

            CButton(
              text: 'Change password',
              onPress: (){
                Navigator.pop(context);
              }
            )
          ],
        ),
      ),
    );
  }
}