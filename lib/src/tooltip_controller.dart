import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:tooltip_plus/src/tooltip_content.dart';
import 'package:tooltip_plus/src/tooltip_enums.dart';
import 'package:tooltip_plus/src/tooltip_size.dart';

class TooltipController {
  OverlayEntry? _backgroundEntry;
  OverlayEntry? _childEntry;
  OverlayEntry? _overlayEntry;
  VoidCallback? _onDismiss;

  bool get isVisible => _overlayEntry != null;

  TooltipController();

  void show({
    required BuildContext context,
    required GlobalKey targetKey,
    TooltipDirection direction = TooltipDirection.top,
    TooltipArrowDirection arrowDirection = TooltipArrowDirection.center,
    Color? tooltipColor,
    bool enableShadow = false,
    Color? shadowColor,
    double shadowElevation = 2.0,
    double shadowBlurRadius = 4.0,
    bool blurBackground = false,
    double blurSigma = 5.0,
    Color? blurColor,
    bool excludeChildFromBlur = true,
    Widget? childWidget,
    Duration? autoDismiss = const Duration(seconds: 3),
    TooltipSize tooltipSize = const TooltipSize(),
    VoidCallback? onDismiss,
  }) {
    hide();
    _onDismiss = onDismiss;

    final RenderBox? renderBox =
        targetKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final position = renderBox.localToGlobal(Offset.zero);
    final targetSize = renderBox.size;

    final centerPosition = Offset(
      position.dx + targetSize.width / 2,
      position.dy + targetSize.height / 2,
    );

    final tooltipPosition = _calculatePosition(
      centerPosition,
      direction,
      tooltipSize,
    );

    if (blurBackground) {
      _backgroundEntry = OverlayEntry(
        builder: (context) => Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
            child: Container(
              color: blurColor ?? Colors.black.withValues(alpha: 0.1),
            ),
          ),
        ),
      );
      Overlay.of(context).insert(_backgroundEntry!);

      if (excludeChildFromBlur && childWidget != null) {
        _childEntry = OverlayEntry(
          builder: (context) => Positioned(
            left: position.dx,
            top: position.dy,
            width: targetSize.width,
            height: targetSize.height,
            child: childWidget,
          ),
        );
        Overlay.of(context).insert(_childEntry!);
      }
    }

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: tooltipPosition.dx,
        top: tooltipPosition.dy,
        child: TooltipContent(
          tooltipColor: tooltipColor,
          arrowDirection: arrowDirection,
          height: tooltipSize.height,
          width: tooltipSize.width,
          direction: direction,
          enableShadow: enableShadow,
          shadowColor: shadowColor,
          shadowElevation: shadowElevation,
          shadowBlurRadius: shadowBlurRadius,
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);

    if (autoDismiss != null) {
      Future.delayed(autoDismiss, () {
        hide();
      });
    }
  }

  void hide() {
    _backgroundEntry?.remove();
    _backgroundEntry = null;
    _childEntry?.remove();
    _childEntry = null;
    _overlayEntry?.remove();
    _overlayEntry = null;
    _onDismiss?.call();
    _onDismiss = null;
  }

  Offset _calculatePosition(
    Offset targetCenter,
    TooltipDirection direction,
    TooltipSize size,
  ) {
    switch (direction) {
      case TooltipDirection.top:
        return Offset(
          targetCenter.dx - size.width / 2,
          targetCenter.dy - size.height - size.spacing,
        );
      case TooltipDirection.bottom:
        return Offset(
          targetCenter.dx - size.width / 2,
          targetCenter.dy + size.spacing,
        );
      case TooltipDirection.left:
        return Offset(
          targetCenter.dx - size.width - size.spacing,
          targetCenter.dy - size.height / 2,
        );
      case TooltipDirection.right:
        return Offset(
          targetCenter.dx + size.spacing,
          targetCenter.dy - size.height / 2,
        );
    }
  }

  void dispose() {
    hide();
  }
}
