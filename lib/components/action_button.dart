import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isSignInButton;

  const ActionButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isSignInButton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(12.0),
        backgroundColor: isSignInButton ? Colors.blue : Colors.green,
        textStyle: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 19,
          fontFamily: 'Montserrat' ,
        ),
      ),
      child: Text(text.toUpperCase()),
    );
  }
}
