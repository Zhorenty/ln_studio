import 'package:flutter/material.dart';
import 'package:ln_studio/src/common/utils/extensions/context_extension.dart';
import 'package:ln_studio/src/feature/home/model/news.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key, required this.news});

  final NewsModel news;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.onBackground,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(news.title),
          )
        ],
      ),
    );
  }
}
