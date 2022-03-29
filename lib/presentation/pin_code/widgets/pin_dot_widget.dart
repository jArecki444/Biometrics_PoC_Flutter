import 'package:flutter/material.dart';

class PinDot extends StatelessWidget {
  final bool fillDotBackground;

  const PinDot({Key? key, required this.fillDotBackground}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        width: 15,
        height: 15,
        decoration: BoxDecoration(
          color: fillDotBackground ? Theme.of(context).primaryColor : null,
          border:
              Border.all(color: Colors.grey, width: 1),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
