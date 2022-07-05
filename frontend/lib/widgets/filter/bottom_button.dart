import 'package:flutter/material.dart';

import '../common/button.dart';

class BottomButton extends StatelessWidget {
  final VoidCallback onPressed;

  const BottomButton(this.onPressed, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: FractionalOffset.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Button(
            text: 'Show Result',
            onPressed: onPressed,
          ),
        ),
      ),
    );
  }
}
