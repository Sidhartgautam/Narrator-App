import 'package:flutter/material.dart';

import '../../resources/colors.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final double? height;
  final double? width;
  final Color? color;
  final Color? backgroundColor;
  final double? radius;
  final Color? labelColor;
  final FontWeight? labelWeight;
  final VoidCallback onPressed;
  final double? fontSize;
  final EdgeInsets? padding;

  const PrimaryButton({
    Key? key,
    required this.label,
    this.height,
    this.width,
    this.color,
    this.backgroundColor,
    this.radius,
    this.labelColor,
    this.labelWeight,
    required this.onPressed,
    this.fontSize,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(0),
        backgroundColor: Colors.blue,
        minimumSize: Size(width ?? double.maxFinite, height ?? 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(radius ?? 10)),
        ),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: Text(
          label,
          style: TextStyle(
            color: labelColor ?? Colors.white,
            fontSize: fontSize,
            fontWeight: labelWeight,
          ),
        ),
      ),
    );
  }
}
