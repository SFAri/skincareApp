import 'package:flutter/material.dart';

class CTextTitle extends StatelessWidget {
  const CTextTitle({super.key, this.title = ''});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(title, style: TextStyle(fontSize: 36));
  }
}