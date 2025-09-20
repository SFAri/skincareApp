import 'package:flutter/material.dart';
import 'package:skincare_app/common/widgets/cbutton.dart';
import 'package:skincare_app/common/widgets/ctextformfield.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Profile")),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(16.0),
        child: Column(
          spacing: 12,
          children: [
            CTextFormField(
              labelText: 'Full Name',
              prefixIcon: Icon(Icons.person),
            ),
            CTextFormField(
              labelText: 'Email',
              prefixIcon: Icon(Icons.mail),
              isEmail: true,
            ),
            CTextFormField(
              labelText: 'Phone number',
              prefixIcon: Icon(Icons.person),
            ),
            CButton(
              text: 'Save changes',
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
