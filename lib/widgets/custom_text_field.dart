import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
      {super.key, this.hintText, this.onChanged, this.validate,this.obscureText =false});
  String? hintText;
      
      
    bool?  obscureText;
  
  Function(String)? onChanged;
  String? Function(String?)? validate;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText!,
        validator: validate,
        onChanged: onChanged,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.white)));
  }
}
