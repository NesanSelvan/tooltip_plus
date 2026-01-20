import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tooltip_pro/tooltip_pro.dart';

void main() {
  test('TooltipPro creates successfully', () {
    // Basic smoke test
    expect(TooltipPro(child: Container()), isNotNull);
  });

  test('TooltipController creates successfully', () {
    final controller = TooltipController();
    expect(controller, isNotNull);
    expect(controller.isVisible, isFalse);
    controller.dispose();
  });
}
