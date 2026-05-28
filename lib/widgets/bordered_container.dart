import 'package:flutter/material.dart';
import 'package:scout_app/theme/app_colors.dart';

class BorderedContainer extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  final Color borderColor;
  final double borderWidth;
  final double borderRadius;
  final double elevation;
  final EdgeInsets padding;

  const BorderedContainer({
    super.key,
    required this.child,
    this.backgroundColor = AppColors.bgPrimary,
    this.borderColor = Colors.transparent,
    this.borderWidth = 0,
    this.borderRadius = 12,
    this.elevation = 5,
    this.padding = const EdgeInsets.all(0),
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation,
      borderRadius: BorderRadius.circular(borderRadius),
      color: Colors.transparent,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: borderColor,
            width: borderWidth,
          ),
        ),
        child: child,
      ),
    );
  }
}