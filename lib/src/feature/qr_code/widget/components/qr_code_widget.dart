import 'package:flutter/material.dart';
import 'package:ln_studio/src/common/assets/generated/assets.gen.dart';

import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/utils/extensions/context_extension.dart';

/// {@template qr_code_widget}
/// QRCodeWidget.
/// {@endtemplate}
class QRCodeWidget extends StatefulWidget {
  /// {@macro qr_code_widget}
  const QRCodeWidget({super.key});

  @override
  State<QRCodeWidget> createState() => _QRCodeWidgetState();
}

class _QRCodeWidgetState extends State<QRCodeWidget> {
  late Image myImage;

  @override
  void initState() {
    super.initState();
    myImage = Assets.images.qrCode.image();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(myImage.image, context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: context.colorScheme.onBackground,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32 + 16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Assets.images.qrCode.image(),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Номер карты',
            style: context.textTheme.bodyLarge?.copyWith(
              color: context.colorScheme.primary,
              fontFamily: FontFamily.geologica,
            ),
          ),
          Text(
            '64237645237645274',
            style: context.textTheme.bodyMedium?.copyWith(
              fontFamily: FontFamily.geologica,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Статус',
                    style: context.textTheme.bodyLarge?.copyWith(
                      color: context.colorScheme.primary,
                      fontFamily: FontFamily.geologica,
                    ),
                  ),
                  Text(
                    'Принимается',
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontFamily: FontFamily.geologica,
                    ),
                  ),
                ],
              ),
              const Icon(Icons.star_rounded, size: 28),
            ],
          ),
        ],
      ),
    );
  }
}
