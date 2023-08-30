import 'package:flutter/material.dart';

import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/utils/extensions/context_extension.dart';

/// {@template wardrobe_screen}
/// Wardrobe screen.
/// {@endtemplate}
class WardrobeScreen extends StatelessWidget {
  /// {@macro wardrobe_screen}
  const WardrobeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9D9D9),
      appBar: AppBar(
        title: Text(
          context.stringOf().appTitle,
          style: context.fonts.headlineMedium?.copyWith(
            color: context.colors.onBackground,
            fontFamily: FontFamily.playfair,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(backgroundColor: context.colors.secondary),
          ),
        ],
      ),
      body: Center(
        child: Text(
          context.stringOf().wardrobeEmpty,
          style: context.fonts.titleMedium?.copyWith(
            fontFamily: FontFamily.playfair,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Записаться'),
        backgroundColor: context.colors.primary,
        onPressed: () {},
      ),
    );
  }
}
