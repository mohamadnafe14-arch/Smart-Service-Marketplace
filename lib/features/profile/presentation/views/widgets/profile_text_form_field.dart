import 'package:flutter/material.dart';

class ProfileTextFormField extends StatelessWidget {
  const ProfileTextFormField({
    super.key,
    required this.hintText,
    required this.validator,
    required this.onSaved,
    required this.onChanged,
    required this.icon,
    this.isPassword = false,
    required this.initialValue,
    this.keyboardType = TextInputType.text,
  });
  final String hintText;
  final String? Function(String?) validator;
  final void Function(String?)? onSaved;
  final void Function(String)? onChanged;
  final IconData icon;
  final bool isPassword ;
  final String initialValue ;
  final TextInputType? keyboardType ;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        border: _border(),
        enabledBorder: _border(),
        focusedBorder: _border(
           Colors.lightBlueAccent,
        ),
        errorBorder: _border(
          Colors.red,
        ),
        hintText: hintText,
      ),
      validator: validator,
      onSaved: onSaved,
      onChanged: onChanged,
      obscureText: isPassword,
      maxLines: null,
      keyboardType: keyboardType,
    );
  }
  OutlineInputBorder _border([Color color=Colors.grey]) {
    return OutlineInputBorder(
        borderSide: BorderSide(color: color),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      );
  }
}