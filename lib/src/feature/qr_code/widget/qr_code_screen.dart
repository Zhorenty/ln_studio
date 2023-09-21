import 'package:flutter/material.dart';

import 'package:ln_studio/src/common/utils/extensions/context_extension.dart';
import 'package:ln_studio/src/common/widget/animated_button.dart';
import 'package:ln_studio/src/common/widget/custom_app_bar.dart';
import 'package:ln_studio/src/common/widget/pop_up_button.dart';

import 'components/qr_code_widget.dart';

class QrCodeScreen extends StatelessWidget {
  const QrCodeScreen({super.key});

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
                color: context.colorScheme.primary,
              ),
              onPressed: () {},
            ),
          ],
          bottomChild: PopupButton(
            label: const Text('blabla'),
            child: ElevatedButton(
              onPressed: () {},
              child: const Text(''),
            ),
          ),
        ),
        const SliverPadding(
          padding: EdgeInsets.all(16),
          sliver: SliverToBoxAdapter(
            child: QrCodeWidget(),
          ),
        ),
      ],
    );
  }
}
