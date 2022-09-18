import 'package:flutter/material.dart';

class LargeTextButtonDecoration extends StatelessWidget {
  const LargeTextButtonDecoration({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xffff5f6d),
            Color(0xffff5f6d),
            Color(0xffffc371),
          ],
        ),
      ),
      child: Container(
        alignment: Alignment.center,
        constraints:
            const BoxConstraints(maxWidth: double.infinity, minHeight: 50),
        child: Text(
          title,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
