import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ln_studio/src/common/assets/generated/assets.gen.dart';
import 'package:ln_studio/src/common/assets/generated/fonts.gen.dart';
import 'package:ln_studio/src/common/utils/extensions/context_extension.dart';
import 'package:ln_studio/src/feature/home/model/news.dart';
import 'package:ln_studio/src/feature/initialization/logic/initialization_steps.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key, required this.news});

  final NewsModel news;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.onBackground,
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              stretch: true,
              snap: true,
              floating: true,
              stretchTriggerOffset: 300.0,
              expandedHeight: 200.0,
              flexibleSpace: FlexibleSpaceBar(
                background: CachedNetworkImage(
                  imageUrl: '$kBaseUrl/${news.photo!}',
                  fit: BoxFit.cover,
                  placeholder: (_, __) => ColoredBox(
                    color: context.colorScheme.onBackground,
                    child: Assets.images.logoWhite.image(
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList.list(
                children: [
                  Text(
                    news.title,
                    style: context.textTheme.titleLarge?.copyWith(
                      fontFamily: FontFamily.geologica,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    news.description,
                    style: context.textTheme.bodyLarge?.copyWith(
                      fontFamily: FontFamily.geologica,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
