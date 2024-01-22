import 'package:flutter/material.dart';

import 'package:ln_studio/src/common/assets/generated/fonts.gen.dart';
import 'package:ln_studio/src/common/utils/extensions/context_extension.dart';

class DiscountsScreen extends StatelessWidget {
  const DiscountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(
              'Скидки',
              style: context.textTheme.titleMedium?.copyWith(
                fontSize: 19,
                fontFamily: FontFamily.geologica,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverFillRemaining(
              child: Center(
                child: Text(
                  'У вас нет персональных скидок',
                  style: context.textTheme.titleMedium?.copyWith(
                    fontFamily: FontFamily.geologica,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
