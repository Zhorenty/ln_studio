import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ln_studio/src/common/assets/generated/fonts.gen.dart';
import 'package:ln_studio/src/common/widget/animated_button.dart';
import 'package:ln_studio/src/common/widget/custom_app_bar.dart';
import 'package:ln_studio/src/common/widget/pop_up_button.dart';
import 'package:ln_studio/src/common/widget/shimmer.dart';
import 'package:ln_studio/src/feature/salon/bloc/salon_bloc.dart';
import 'package:ln_studio/src/feature/salon/bloc/salon_state.dart';
import 'package:ln_studio/src/feature/salon/widget/salon_choice_screen.dart';

import '/src/common/utils/extensions/context_extension.dart';

/// {@template Home_screen}
/// Home screen.
/// {@endtemplate}
class HomeScreen extends StatelessWidget {
  /// {@macro Home_screen}
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        CustomSliverAppBar(
          title: context.stringOf().employees,
          actions: [
            AnimatedButton(
              padding: const EdgeInsets.only(right: 8 + 2, top: 2),
              child: Icon(
                Icons.notifications_rounded,
                color: context.colorScheme.primary,
              ),
              onPressed: () {},
            ),
          ],
          bottomChild: BlocBuilder<SalonBLoC, SalonState>(
            builder: (context, state) => PopupButton(
              label: state.currentSalon != null
                  ? Text(state.currentSalon!.name)
                  : Shimmer(
                      backgroundColor: context.colorScheme.onBackground,
                    ),
              child: SalonChoiceScreen(currentSalon: state.currentSalon),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Text(
            context.stringOf().employees,
            style: context.textTheme.titleMedium?.copyWith(
              fontFamily: FontFamily.geologica,
              color: context.colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}
