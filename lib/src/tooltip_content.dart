import 'package:flutter/material.dart';
import 'package:tooltip_plus/src/tooltip_enums.dart';
import 'package:tooltip_plus/src/tooltip_painter.dart';

class TooltipContent extends StatelessWidget {
  final double height;
  final double width;
  final TooltipArrowDirection arrowDirection;
  final TooltipDirection direction;
  final Color? tooltipColor;
  final bool enableShadow;
  final Color? shadowColor;
  final double shadowElevation;
  final double shadowBlurRadius;

  const TooltipContent({
    super.key,
    required this.height,
    required this.width,
    this.arrowDirection = TooltipArrowDirection.left,
    this.direction = TooltipDirection.top,
    this.tooltipColor,
    this.enableShadow = false,
    this.shadowColor,
    this.shadowElevation = 2.0,
    this.shadowBlurRadius = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveColor = tooltipColor ?? Colors.black.withValues(alpha: 0.8);
    final effectiveShadowColor =
        shadowColor ?? Colors.black.withValues(alpha: 0.5);

    EdgeInsets padding;
    switch (direction) {
      case TooltipDirection.top:
        padding = const EdgeInsets.only(bottom: 10);
        break;
      case TooltipDirection.bottom:
        padding = const EdgeInsets.only(top: 10);
        break;
      case TooltipDirection.left:
        padding = const EdgeInsets.only(right: 10);
        break;
      case TooltipDirection.right:
        padding = const EdgeInsets.only(left: 10);
        break;
    }

    return CustomPaint(
      painter: TooltipPainter(
        color: effectiveColor,
        arrowDirection: arrowDirection,
        tooltipDirection: direction,
        enableShadow: enableShadow,
        shadowColor: effectiveShadowColor,
        shadowElevation: shadowElevation,
        shadowBlurRadius: shadowBlurRadius,
      ),
      child: Container(height: height, width: width, padding: padding),
    );
  }
}
