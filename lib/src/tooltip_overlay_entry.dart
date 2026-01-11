import 'package:flutter/material.dart';
import 'package:tooltip_plus/src/tooltip_content.dart';
import 'package:tooltip_plus/src/tooltip_enums.dart';

class TooltipOverlayEntry {
  double height = 50;
  double width = 50;
  double spacing = 10;
  OverlayEntry? tooltip;

  void showTooltip(
    Offset position,
    BuildContext context, {
    TooltipDirection direction = TooltipDirection.top,
  }) {
    final positionTooltip = calculatePosition(
      position,
      spacing,
      context,
      direction,
    );

    tooltip = OverlayEntry(
      builder: (context) => Positioned(
        left: positionTooltip.dx,
        top: positionTooltip.dy,
        child: TooltipContent(
          height: height,
          width: width,
          direction: direction,
        ),
      ),
    );

    Overlay.of(context).insert(tooltip!);

    Future.delayed(Duration(seconds: 20000), () {
      tooltip?.remove();
      tooltip = null;
    });
  }

  Offset calculatePosition(
    Offset position,
    double spacing,
    BuildContext context,
    TooltipDirection direction,
  ) {
    switch (direction) {
      case TooltipDirection.top:
        // Center horizontally above touch point
        return Offset(position.dx - width / 2, position.dy - height - spacing);
      case TooltipDirection.bottom:
        // Center horizontally below touch point
        return Offset(position.dx - width / 2, position.dy + spacing);
      case TooltipDirection.left:
        // Center vertically to the left of touch point
        return Offset(position.dx - width - spacing, position.dy - height / 2);
      case TooltipDirection.right:
        // Center vertically to the right of touch point
        return Offset(position.dx + spacing, position.dy - height / 2);
    }
  }
}
