import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ln_studio/src/common/widget/custom_app_bar.dart';
import 'package:ln_studio/src/common/widget/information_widget.dart';
import 'package:ln_studio/src/common/widget/pop_up_button.dart';
import 'package:ln_studio/src/common/widget/shimmer.dart';
import 'package:ln_studio/src/feature/salon/bloc/salon_bloc.dart';
import 'package:ln_studio/src/feature/salon/bloc/salon_state.dart';
import 'package:ln_studio/src/feature/salon/widget/current_salon_screen.dart';

/// {@template store_screen}
/// StoreScreen widget.
/// {@endtemplate}
class StoreScreen extends StatelessWidget {
  /// {@macro store_screen}
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) => CustomScrollView(
        slivers: [
          CustomSliverAppBar(
            title: 'Магазин',
            bottomChild: BlocBuilder<SalonBLoC, SalonState>(
              builder: (context, state) => PopupButton(
                smoothAnimate: false,
                label: state.currentSalon != null
                    ? Text(state.currentSalon!.address)
                    : const Shimmer(),
                child: CurrentSalonScreen(
                  pathName: 'store',
                  currentSalon: state.currentSalon,
                ),
              ),
            ),
          ),
          const SliverPadding(
            padding: EdgeInsets.all(16),
            sliver: SliverToBoxAdapter(
              child: InformationWidget(
                  title: 'В разработке',
                  description: 'Магазин пока нахоится в разработке'),
            ),
          ),
        ],
      );
}
