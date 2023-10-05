import 'package:flutter/material.dart';
import 'package:ln_studio/src/common/utils/extensions/context_extension.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        color: context.colorScheme.onBackground,
        height: 200,
        width: 100,
      ),
    );
  }
}
