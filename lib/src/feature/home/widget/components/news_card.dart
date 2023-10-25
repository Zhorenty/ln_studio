import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:ln_studio/src/common/assets/generated/fonts.gen.dart';
import 'package:ln_studio/src/common/utils/extensions/context_extension.dart';
import 'package:ln_studio/src/common/widget/animated_button.dart';

///
class NewsCard extends StatelessWidget {
  const NewsCard({super.key, required this.asset, this.label});

  ///
  final Image? asset;

  ///
  final String? label;

  @override
  Widget build(BuildContext context) {
    ///
    const double width = 175;

    return AnimatedButton(
      onPressed: () => context.goNamed('news'),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        color: context.colorScheme.onBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Color(0xFF272727)),
        ),
        child: Stack(
          children: [
            SizedBox(
              width: width,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: asset,
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.3),
                      Colors.black.withOpacity(0.3),
                      Colors.black.withOpacity(0.3),
                    ],
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: width - 15,
                    child: Text(
                      label ?? '',
                      style: context.textTheme.bodySmall?.copyWith(
                        fontFamily: FontFamily.geologica,
                        color: context.colorScheme.secondary,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
