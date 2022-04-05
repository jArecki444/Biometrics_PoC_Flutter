import 'package:flutter/material.dart';

class NumberButton extends StatelessWidget {
  const NumberButton({Key? key, required this.num, this.onPressed})
      : super(key: key);

  final String num;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: FloatingActionButton.extended(
        heroTag: num,
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 231, 231, 231),
        onPressed: onPressed,
        label: Text(
          num,
          style: const TextStyle(color: Color(0xFF687ea1)),
        ),
      ),
    );
  }
}
