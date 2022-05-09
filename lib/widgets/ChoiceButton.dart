import 'package:aawani/resource/Colors.dart';
import 'package:flutter/material.dart';

class ChoiceButton extends StatelessWidget {
  final double width;
  final double height;
  final double size;
  final IconData icon;
  final bool help;

  final Color color;

  const ChoiceButton(
      {Key? key,
      required this.color,
      required this.height,
      required this.width,
      this.help = false,
      required this.size,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: help ? primaryColor : Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withAlpha(50),
              spreadRadius: 4,
              blurRadius: 4,
              offset: Offset(3, 3))
        ],
      ),
      child: Icon(
        icon,
        color: color,
        size: size,
      ),
    );
  }
}
