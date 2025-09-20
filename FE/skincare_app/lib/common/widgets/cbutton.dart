import 'package:flutter/material.dart';

class CButton extends StatelessWidget {
  const CButton({super.key, this.text = '', required this.onPress});
  final String text;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromARGB(255, 210, 172, 142),
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 10)
        ),
        onPressed: () {
          onPress();
        },
        child: Text(text, style: TextStyle(fontSize: 18)),
      ),
    );
  }
}