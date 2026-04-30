import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.content,
    this.onPressed,
    this.backgroundColor = Colors.blueAccent,
  });

  final String content;
  final VoidCallback? onPressed;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(right: 5),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(backgroundColor),
            foregroundColor: WidgetStateProperty.all(Colors.white),
            padding: WidgetStateProperty.all(const EdgeInsets.symmetric(vertical: 16)),
          ),
          child: Text(content, style: TextStyle(fontSize: 18)),
        ),
      ),
    );
  }
}
