import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyTextField extends StatelessWidget {
  MyTextField(
      {super.key,
      required this.labelText,
      this.obscureText = false,
      required this.onchanged
      });

  final String labelText;
  bool obscureText = false;
  Function(String) onchanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade400,
            fontWeight: FontWeight.w600),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.red),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
      cursorColor: Colors.red,
      obscureText: obscureText,
      onChanged: onchanged,
    );
  }
}
