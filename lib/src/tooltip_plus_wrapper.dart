import 'package:flutter/widgets.dart';
import 'package:tooltip_plus/src/tooltip_overlay_entry.dart';
import 'package:tooltip_plus/src/tooltip_enums.dart';

class TooltipWrapper extends StatefulWidget {
  final Widget child;
  TooltipWrapper({Key? key, required this.child}) : super(key: key);

  @override
  _TooltipWrapperState createState() => _TooltipWrapperState();
}

class _TooltipWrapperState extends State<TooltipWrapper> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        TooltipOverlayEntry().showTooltip(
          details.globalPosition,
          context,
          direction: TooltipDirection.left,
        );
      },
      child: widget.child,
    );
  }
}
