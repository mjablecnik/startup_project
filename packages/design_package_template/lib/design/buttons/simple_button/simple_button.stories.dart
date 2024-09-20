import 'package:flutter/widgets.dart';
import 'package:design_package_template/storybook.dart';
import 'package:design_package_template/core/colors.dart';
import 'package:storybook_toolkit/storybook_toolkit.dart';

import 'simple_button.dart';
import 'simple_button.style.dart';

String textKnob(BuildContext context) => context.knobs.text(label: 'Button text', initial: 'START!');

String textKnobOptions(BuildContext context) => context.knobs.options(
      label: 'Button text',
      initial: 'START!!!',
      options: [
        const Option(label: "Short text", value: "Short text"),
        const Option(label: "Long text", value: "sdfjo489sf ufwjisd wj fkjsdf"),
        const Option(
            label: "Very long text",
            value: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
                "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. "),
      ],
    );

onTap() => debugPrint("Test click.");

final simpleButtonStories = [
  Story(
    tags: const ['buttons'],
    name: 'Default',
    goldenPathBuilder: (c) => goldenTestPathBuilder(c),
    builder: (context) => SimpleButton(
      text: textKnobOptions(context),
      onTap: onTap,
    ),
  ),
  Story(
    tags: const ['buttons'],
    name: 'Customized',
    goldenPathBuilder: (c) => goldenTestPathBuilder(c),
    builder: (context) => SimpleButton(
      text: textKnobOptions(context),
      onTap: onTap,
      style: const SimpleButtonStyle(
        defaultColor: DesignColors.redLight,
        textStyle: TextStyle(
          color: DesignColors.blueDark,
          fontSize: 24,
        ),
      ),
    ),
  ),
];

void main() => runApp(storybook(simpleButtonStories));
