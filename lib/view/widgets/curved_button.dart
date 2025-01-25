import 'package:flutter/material.dart';

class CurvedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final double height;
  final double width;
  final TextStyle? textStyle;
  final double borderRadius;

  CurvedButton({
    required this.text,
    required this.onPressed,
    this.color = Colors.blueGrey,
    this.height = 50.0,
    this.width = double.infinity,
    this.textStyle,
    this.borderRadius = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Center(
          child: Text(
            text,
            style: textStyle ??
                TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
          ),
        ),
      ),
    );
  }
}
