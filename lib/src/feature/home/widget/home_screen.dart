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
      backgroundColor: context.colors.background,
      appBar: AppBar(
        backgroundColor: context.colors.onBackground,
        title: Text(
          context.stringOf().appTitle,
          style: context.fonts.headlineMedium?.copyWith(
            color: context.colors.secondary,
            fontFamily: FontFamily.playfair,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(backgroundColor: Color(0xFFD9D9D9)),
          ),
        ],
      ),
      body: Center(
        child: Text(
          context.stringOf().wardrobeEmpty,
          style: context.fonts.titleMedium?.copyWith(
            color: context.colors.secondary,
            fontFamily: FontFamily.playfair,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text(
          'Записаться',
          style: context.fonts.bodyLarge?.copyWith(
            color: context.colors.onBackground,
            fontFamily: FontFamily.playfair,
          ),
        ),
        backgroundColor: context.colors.primary,
        onPressed: () {},
      ),
    );
  }
}
