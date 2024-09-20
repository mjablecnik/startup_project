import 'package:flutter/material.dart';
import 'package:design_package_template/design/design.theme.dart';

import 'simple_button.style.dart';

class SimpleButton extends StatelessWidget {
  const SimpleButton({
    super.key,
    required this.text,
    this.onTap,
    this.style,
  });

  final String text;
  final GestureTapCallback? onTap;
  final SimpleButtonStyle? style;

  @override
  Widget build(BuildContext context) {
    final currentStyle = style ?? context.designTheme.buttonsStyle.simpleButtonStyle;
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: 300,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: currentStyle.defaultColor,
          ),
          child: Center(
            child: Text(text, style: currentStyle.textStyle),
          ),
        ),
      ),
    );
  }
}
