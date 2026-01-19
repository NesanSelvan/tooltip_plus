import 'package:flutter/material.dart';
import 'package:tooltip_plus/src/tooltip_config.dart';
import 'package:tooltip_plus/src/tooltip_controller.dart';
import 'package:tooltip_plus/src/tooltip_enums.dart';
import 'package:tooltip_plus/src/tooltip_size.dart';

class TooltipTarget extends StatefulWidget {
  final Widget child;
  final TooltipDirection direction;
  final TooltipArrowDirection arrowDirection;
  final Duration? autoDismiss;
  final double tooltipHeight;
  final double tooltipWidth;
  final double spacing;
  final VoidCallback? onPressed;
  final Color? tooltipColor;
  final TooltipShadowConfig shadow;
  final TooltipBlurConfig blur;

  const TooltipTarget({
    super.key,
    required this.child,
    this.direction = TooltipDirection.top,
    this.arrowDirection = TooltipArrowDirection.center,
    this.autoDismiss = const Duration(seconds: 3),
    this.tooltipHeight = 50,
    this.tooltipWidth = 50,
    this.spacing = 10,
    this.onPressed,
    this.tooltipColor,
    this.shadow = const TooltipShadowConfig(),
    this.blur = const TooltipBlurConfig(),
  });

  @override
  State<TooltipTarget> createState() => _TooltipTargetState();
}

class _TooltipTargetState extends State<TooltipTarget> {
  final GlobalKey _targetKey = GlobalKey();
  late final TooltipController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TooltipController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showTooltip() {
    _controller.show(
      context: context,
      targetKey: _targetKey,
      direction: widget.direction,
      arrowDirection: widget.arrowDirection,
      autoDismiss: widget.autoDismiss,
      tooltipColor: widget.tooltipColor,
      enableShadow: widget.shadow.enabled,
      shadowColor: widget.shadow.color,
      shadowElevation: widget.shadow.elevation,
      shadowBlurRadius: widget.shadow.blurRadius,
      blurBackground: widget.blur.enabled,
      blurSigma: widget.blur.sigma,
      blurColor: widget.blur.color,
      excludeChildFromBlur: !widget.blur.includeChild,
      childWidget: widget.child,
      tooltipSize: TooltipSize(
        height: widget.tooltipHeight,
        width: widget.tooltipWidth,
        spacing: widget.spacing,
      ),
    );
    widget.onPressed?.call();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: _targetKey,
      onTap: _showTooltip,
      child: widget.child,
    );
  }
}
