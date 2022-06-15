import 'package:flutter/material.dart';

class LoginTitle extends StatelessWidget {
  final String titleText;

  const LoginTitle({Key? key, required this.titleText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        titleText,
        style: const TextStyle(fontSize: 36),
      ),
    );
  }
}
