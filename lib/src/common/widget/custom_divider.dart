import 'package:flutter/material.dart';
import 'package:ln_studio/src/common/utils/extensions/color_extension.dart';

import '/src/common/utils/extensions/context_extension.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key, this.height = 1});

  final double height;

  @override
  Widget build(BuildContext context) => Container(
        height: height,
        color: context.colorScheme.onBackground.lighten(0.02),
      );
}
