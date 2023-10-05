import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ln_studio/src/common/assets/generated/fonts.gen.dart';
import 'package:ln_studio/src/common/utils/extensions/context_extension.dart';
import 'package:ln_studio/src/common/utils/extensions/string_extension.dart';
import 'package:ln_studio/src/common/widget/animated_button.dart';
import 'package:ln_studio/src/feature/salon/models/salon.dart';

class CurrentSalonScreen extends StatelessWidget {
  const CurrentSalonScreen({
    super.key,
    required this.currentSalon,
    required this.pathName,
  });

  /// Currently selected salon.
  final Salon? currentSalon;

  ///
  final String pathName;

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now().toLocal();
    final bool isClosed = now.hour > 21;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            currentSalon!.name,
            style: context.textTheme.titleLarge?.copyWith(
              fontSize: 20,
              fontFamily: FontFamily.geologica,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            currentSalon!.address,
            style: context.textTheme.titleSmall?.copyWith(
              fontFamily: FontFamily.geologica,
            ),
          ),
          Text(
            isClosed ? 'Закрыто до 10:00' : 'Открыто до 21:00',
            style: context.textTheme.bodySmall?.copyWith(
              fontFamily: FontFamily.geologica,
              color: context.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(right: 8, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Время работы',
                  style: context.textTheme.bodyLarge?.copyWith(
                    fontFamily: FontFamily.geologica,
                  ),
                ),
                Text(
                  'пн.-вс.: 10:00 - 21:00',
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontFamily: FontFamily.geologica,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Телефон',
                  style: context.textTheme.bodyLarge?.copyWith(
                    fontFamily: FontFamily.geologica,
                  ),
                ),
                Text(
                  currentSalon!.phone.formatPhoneNumber(),
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontFamily: FontFamily.geologica,
                    color: context.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: CustomButton(
              color: context.colorScheme.primary,
              child: Text(
                'Сменить филиал',
                style: context.textTheme.bodyLarge?.copyWith(
                  fontFamily: FontFamily.geologica,
                  color: context.colorScheme.onBackground,
                ),
              ),
              onPressed: () => context
                // Close ModalPopup.
                ..pop()
                ..goNamed('salon_choice_from_$pathName', extra: currentSalon),
            ),
          ),
        ],
      ),
    );
  }
}

///
class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.child,
    this.color,
    this.border,
    this.onPressed,
  });

  ///
  final Color? color;

  ///
  final Widget? child;

  ///
  final BoxBorder? border;

  ///
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return AnimatedButton(
      onPressed: onPressed,
      child: Container(
        width: 300,
        padding: const EdgeInsets.symmetric(vertical: 8),
        margin: const EdgeInsets.only(top: 12),
        decoration: BoxDecoration(
          color: color,
          border: border,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(child: child),
      ),
    );
  }
}
