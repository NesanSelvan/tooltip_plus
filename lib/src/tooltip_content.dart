import 'package:flutter/material.dart';
import 'package:tooltip_plus/src/tooltip_enums.dart';
import 'package:tooltip_plus/src/tooltip_painter.dart';

class TooltipContent extends StatelessWidget {
  final double height;
  final double width;
  final TooltipArrowDirection arrowDirection;
  final TooltipDirection direction;

  TooltipContent({
    Key? key,
    required this.height,
    required this.width,
    this.arrowDirection = TooltipArrowDirection.left,
    this.direction = TooltipDirection.top,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        color: Colors.red,
        arrowDirection: arrowDirection,
        tooltipDirection: direction,
      ),
      child: Container(height: height, width: width, padding: padding),
    );
  }
}
