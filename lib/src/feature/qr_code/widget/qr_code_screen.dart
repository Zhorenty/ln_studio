import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/src/common/utils/extensions/context_extension.dart';
import '/src/common/widget/animated_button.dart';
import '/src/common/widget/custom_app_bar.dart';
import '/src/common/widget/pop_up_button.dart';
import '/src/common/widget/shimmer.dart';
import '/src/feature/salon/bloc/salon_bloc.dart';
import '/src/feature/salon/bloc/salon_state.dart';
import '/src/feature/salon/widget/current_salon_screen.dart';

import 'components/qr_code_widget.dart';

/// {@template qr_code_screen}
/// QRCodeScreen widget.
/// {@endtemplate}
class QRCodeScreen extends StatelessWidget {
  /// {@macro qr_code_screen}
  const QRCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        CustomSliverAppBar(
          title: 'Данные карты',
          actions: [
            AnimatedButton(
              padding: const EdgeInsets.only(right: 8 + 4, top: 2),
              child: Icon(
                Icons.share_rounded,
                color: context.colorScheme.secondary,
              ),
              onPressed: () {},
            ),
          ],
          bottomChild: BlocBuilder<SalonBLoC, SalonState>(
            builder: (context, state) => PopupButton(
              label: state.currentSalon != null
                  ? Text(state.currentSalon!.address)
                  : Shimmer(backgroundColor: context.colorScheme.onBackground),
              child: CurrentSalonScreen(currentSalon: state.currentSalon),
            ),
          ),
        ),
        const SliverPadding(
          padding: EdgeInsets.all(16),
          sliver: SliverToBoxAdapter(
            child: QRCodeWidget(),
          ),
        ),
      ],
    );
  }
}
