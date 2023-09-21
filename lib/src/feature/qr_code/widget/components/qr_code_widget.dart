import 'package:flutter/material.dart';
import 'package:ln_studio/src/common/assets/generated/fonts.gen.dart';

import 'package:ln_studio/src/common/utils/extensions/context_extension.dart';

class QRCodeWidget extends StatelessWidget {
  const QRCodeWidget({super.key});

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
              child: Image.asset('assets/images/qr_code.png'),
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
