import 'package:flutter/material.dart';

class CustomServiceTextFormField extends StatelessWidget {
  const CustomServiceTextFormField({
    super.key,
    required this.hintText,
    required this.validator,
    required this.onSaved,
    required this.onChanged,
    required this.icon,
    required this.initailValue,
    required this.maxLines,
    this.keyboardType=TextInputType.text,
  });
  final String hintText;
  final String? Function(String?) validator;
  final void Function(String?)? onSaved;
  final void Function(String)? onChanged;
  final IconData icon;
  final String? initailValue;
  final int? maxLines;
  final TextInputType? keyboardType;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        border: _border(),
        enabledBorder: _border(),
        focusedBorder: _border(Colors.lightBlueAccent),
        errorBorder: _border(Colors.red),
        hintText: hintText,
      ),
      validator: validator,
      onSaved: onSaved,
      onChanged: onChanged,
      initialValue: initailValue,
      maxLines: maxLines,
      keyboardType:keyboardType ,
    );
  }

  OutlineInputBorder _border([Color color = Colors.grey]) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color),
      borderRadius: BorderRadius.all(Radius.circular(10)),
    );
  }
}
