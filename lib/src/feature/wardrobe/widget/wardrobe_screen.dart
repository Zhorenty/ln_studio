import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/utils/extensions/context_extension.dart';
import '/src/feature/wardrobe/bloc/wardrobe_bloc.dart';
import '/src/feature/wardrobe/bloc/wardrobe_state.dart';

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
          style: context.fonts.headlineLarge?.copyWith(
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
      body: BlocBuilder<WardrobeBloc, WardrobeState>(
        builder: (context, state) => state.hasClothes
            ? CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.all(16),
                    sliver: SliverList.list(
                      children: const [],
                    ),
                  )
                ],
              )
            : Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 128),
                  child: Text(
                    context.stringOf().wardrobeEmpty,
                    style: context.fonts.headlineMedium?.copyWith(
                      fontFamily: FontFamily.playfair,
                    ),
                  ),
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: context.colors.primary,
        child: const Icon(Icons.add_outlined),
        onPressed: () {},
      ),
    );
  }
}
