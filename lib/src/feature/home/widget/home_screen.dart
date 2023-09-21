import 'package:flutter/material.dart';
import 'package:ln_studio/src/common/assets/generated/fonts.gen.dart';

import '/src/common/utils/extensions/context_extension.dart';

/// {@template Home_screen}
/// Home screen.
/// {@endtemplate}
class HomeScreen extends StatelessWidget {
  /// {@macro Home_screen}
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.background,
      appBar: AppBar(
        backgroundColor: context.colorScheme.onBackground,
        title: Align(
          alignment: Alignment.bottomLeft,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 2, top: 8),
                child: Text(
                  'ул. Степана Разина, д. 72',
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.primary,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(right: 4, top: 8),
                child: Icon(Icons.arrow_forward_ios, size: 12),
              )
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: CircleAvatar(
              backgroundColor: context.colorScheme.primary,
              child: Icon(
                Icons.person,
                color: context.colorScheme.onBackground,
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Text(
          context.stringOf().wardrobeEmpty,
          style: context.textTheme.titleMedium?.copyWith(
            fontFamily: FontFamily.playfair,
            color: context.colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
