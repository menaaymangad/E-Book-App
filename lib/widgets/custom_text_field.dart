// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_ebook_website/constants/color_constants.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {super.key,
      this.hint,
      this.function,
      this.obsecure = false,
      this.suffixIcon,
      this.prefixIcon});

  String? hint;
  bool? obsecure;
  IconButton? suffixIcon;
  IconData? prefixIcon;
  void Function(String?)? function;
  String errorMessage(String str) {
    switch (hint) {
      case 'Enter Your Name':
        str = 'Name is required';
      case 'Enter your email address':
        str = 'email is required';
      case 'Enter your password':
        str = 'password is required';
      default:
        str = 'value is required';
    }
    return str;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: TextFormField(
        cursorColor: kMainColor,
        obscureText: obsecure!,
        validator: (value) {
          if (value!.isEmpty) {
            return errorMessage(hint!);
          }
          return null;
        },
        onSaved: function,
        style: const TextStyle(
          color: Colors.black,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: kSecondaryColor,
          prefixIcon: Icon(
            prefixIcon,
            color: kMainColor,
          ),
          suffixIcon: suffixIcon,
          hintText: hint,
          hintStyle: const TextStyle(
            color: Colors.white,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 2,
              style: BorderStyle.solid,
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 2,
              style: BorderStyle.solid,
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 2,
              style: BorderStyle.solid,
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }
}
