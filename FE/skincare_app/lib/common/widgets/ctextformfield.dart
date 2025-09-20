import 'package:flutter/material.dart';

class CTextFormField extends StatefulWidget {
  const CTextFormField({
    super.key, 
    this.hintText = '', 
    required this.labelText, 
    required this.prefixIcon,
    this.validator,
    this.isEmail = false,
    this.isPhone = false,
    this.controller
  });

  final String hintText;
  final String labelText;
  final Icon prefixIcon;
  final String? Function(String?)? validator;
  final bool isEmail;
  final bool isPhone;
  final TextEditingController? controller;

  @override
  State<CTextFormField> createState() => _CTextFormFieldState();
}

class _CTextFormFieldState extends State<CTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: (value) {
        // automatic rule
        if (widget.isEmail) {
          if (value == null || value.isEmpty) return 'Please enter your email';
          final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
          if (!emailRegex.hasMatch(value)) return 'Invalid email';
        }

        if (widget.isPhone) {
          if (value == null || value.isEmpty) return 'Please enter your phone number';
          final phoneRegex = RegExp(r'^[0-9]{10}$');
          if (!phoneRegex.hasMatch(value)) return 'Valid phone number must contain 10 digits';
        }

        // external validator
        if (widget.validator != null) {
          return widget.validator!(value);
        }

        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        prefixIcon: widget.prefixIcon,
        hintText: widget.hintText,
        label: Text(widget.labelText),
      ),
    );
  }
}
