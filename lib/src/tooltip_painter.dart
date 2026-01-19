import 'package:flutter/material.dart';
import 'package:tooltip_plus/src/tooltip_enums.dart';

class TooltipPainter extends CustomPainter {
  final Color color;
  final TooltipArrowDirection arrowDirection;
  final TooltipDirection tooltipDirection;
  final bool enableShadow;
  final Color shadowColor;
  final double shadowElevation;
  final double shadowBlurRadius;

  TooltipPainter({
    required this.color,
    required this.arrowDirection,
    required this.tooltipDirection,
    this.enableShadow = false,
    this.shadowColor = const Color(0x4D000000),
    this.shadowElevation = 4.0,
    this.shadowBlurRadius = 4.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final path = _buildPath(size);

    if (enableShadow) {
      final shadowPaint = Paint()
        ..color = shadowColor
        ..style = PaintingStyle.fill
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, shadowBlurRadius);

      canvas.save();
      canvas.translate(0, shadowElevation);
      canvas.drawPath(path, shadowPaint);
      canvas.restore();
    }

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, paint);
  }

  Path _buildPath(Size size) {
    final path = Path();
    const arrowHeight = 10.0;
    const arrowWidth = 12.0;
    const borderRadius = 5.0;

    double arrowPos;
    if (tooltipDirection == TooltipDirection.left ||
        tooltipDirection == TooltipDirection.right) {
      switch (arrowDirection) {
        case TooltipArrowDirection.left:
          arrowPos = size.height * 0.2;
          break;
        case TooltipArrowDirection.right:
          arrowPos = size.height * 0.8;
          break;
        case TooltipArrowDirection.center:
          arrowPos = size.height * 0.5;
          break;
        case TooltipArrowDirection.none:
          arrowPos = 0;
          break;
      }
    } else {
      switch (arrowDirection) {
        case TooltipArrowDirection.left:
          arrowPos = size.width * 0.2;
          break;
        case TooltipArrowDirection.right:
          arrowPos = size.width * 0.8;
          break;
        case TooltipArrowDirection.center:
          arrowPos = size.width * 0.5;
          break;
        case TooltipArrowDirection.none:
          arrowPos = 0;
          break;
      }
    }

    if (arrowDirection == TooltipArrowDirection.none) {
      final bodyRect = Rect.fromLTWH(0, 0, size.width, size.height);
      path.addRRect(
        RRect.fromRectAndRadius(bodyRect, Radius.circular(borderRadius)),
      );
      return path;
    }

    Rect bodyRect;
    switch (tooltipDirection) {
      case TooltipDirection.bottom:
        bodyRect = Rect.fromLTWH(
          0,
          arrowHeight,
          size.width,
          size.height - arrowHeight,
        );
        path.addRRect(
          RRect.fromRectAndRadius(bodyRect, Radius.circular(borderRadius)),
        );
        path.moveTo(arrowPos - arrowWidth / 2, arrowHeight);
        path.lineTo(arrowPos, 0);
        path.lineTo(arrowPos + arrowWidth / 2, arrowHeight);
        break;

      case TooltipDirection.top:
        bodyRect = Rect.fromLTWH(0, 0, size.width, size.height - arrowHeight);
        path.addRRect(
          RRect.fromRectAndRadius(bodyRect, Radius.circular(borderRadius)),
        );
        path.moveTo(arrowPos - arrowWidth / 2, size.height - arrowHeight);
        path.lineTo(arrowPos, size.height);
        path.lineTo(arrowPos + arrowWidth / 2, size.height - arrowHeight);
        break;

      case TooltipDirection.right:
        bodyRect = Rect.fromLTWH(
          arrowHeight,
          0,
          size.width - arrowHeight,
          size.height,
        );
        path.addRRect(
          RRect.fromRectAndRadius(bodyRect, Radius.circular(borderRadius)),
        );
        path.moveTo(arrowHeight, arrowPos - arrowWidth / 2);
        path.lineTo(0, arrowPos);
        path.lineTo(arrowHeight, arrowPos + arrowWidth / 2);
        break;

      case TooltipDirection.left:
        bodyRect = Rect.fromLTWH(0, 0, size.width - arrowHeight, size.height);
        path.addRRect(
          RRect.fromRectAndRadius(bodyRect, Radius.circular(borderRadius)),
        );
        path.moveTo(size.width - arrowHeight, arrowPos - arrowWidth / 2);
        path.lineTo(size.width, arrowPos);
        path.lineTo(size.width - arrowHeight, arrowPos + arrowWidth / 2);
        break;
    }

    return path;
  }

  @override
  bool shouldRepaint(covariant TooltipPainter oldDelegate) =>
      color != oldDelegate.color ||
      arrowDirection != oldDelegate.arrowDirection ||
      tooltipDirection != oldDelegate.tooltipDirection ||
      enableShadow != oldDelegate.enableShadow ||
      shadowColor != oldDelegate.shadowColor ||
      shadowElevation != oldDelegate.shadowElevation ||
      shadowBlurRadius != oldDelegate.shadowBlurRadius;
}
