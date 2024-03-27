// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({super.key, this.function, required this.buttonName});
  VoidCallback? function;
  final String buttonName;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.height * .15),
        child: Container(
          height: MediaQuery.of(context).size.height * .09,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24), color: Colors.black),
          child: Center(
            child: Text(
              buttonName,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
