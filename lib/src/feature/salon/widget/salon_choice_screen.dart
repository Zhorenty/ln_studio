import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ln_studio/src/common/assets/generated/fonts.gen.dart';
import 'package:ln_studio/src/common/utils/extensions/string_extension.dart';

import '/src/common/utils/extensions/context_extension.dart';
import '/src/common/widget/shimmer.dart';
import '/src/feature/salon/bloc/salon_bloc.dart';
import '/src/feature/salon/bloc/salon_event.dart';
import '/src/feature/salon/bloc/salon_state.dart';
import '/src/feature/salon/models/salon.dart';

/// {@template salon_choice_screen}
/// SalonChoiceScreen widget.
/// {@endtemplate}
class SalonChoiceScreen extends StatefulWidget {
  /// {@macro salon_choice_screen}
  const SalonChoiceScreen({
    super.key,
    required this.currentSalon,
    this.onChanged,
  });

  /// Currently selected salon.
  final Salon? currentSalon;

  /// Callback, called when salon selection changes.
  final void Function(Salon?)? onChanged;

  @override
  State<SalonChoiceScreen> createState() => _SalonChoiceScreenState();
}

/// State for widget SalonChoiceScreen.
class _SalonChoiceScreenState extends State<SalonChoiceScreen> {
  late final SalonBLoC salonBloc;

  /* #region Lifecycle */
  @override
  void initState() {
    super.initState();
    salonBloc = context.read<SalonBLoC>()..add(const SalonEvent.fetchAll());
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<SalonBLoC, SalonState>(
        builder: (context, state) {
          return salonBloc.state.hasData
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ListView(
                        children: [
                          ...salonBloc.state.data!.map(
                            (salon) => _SalonChoiceRow(
                              salon: salon,
                              currentSalon: widget.currentSalon,
                              onChanged: (salon) {
                                if (widget.onChanged == null) {
                                  salonBloc.add(SalonEvent.saveCurrent(salon!));
                                } else {
                                  setState(() => widget.onChanged!(salon));
                                }
                                context.pop();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : const Shimmer();
        },
      );
}

/// {@template salon_choice_row}
/// _SalonChoiceRow widget.
/// {@endtemplate}
class _SalonChoiceRow extends StatelessWidget {
  /// {@macro salon_choice_row}
  const _SalonChoiceRow({
    required this.salon,
    this.currentSalon,
    this.onChanged,
  });

  /// Salon with the provided attributes.
  final Salon salon;

  /// Salon that represents the currently selected salon.
  final Salon? currentSalon;

  /// Callback, called when the [Salon] selection changes.
  final void Function(Salon?)? onChanged;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => onChanged?.call(salon),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          padding: const EdgeInsets.all(4).add(const EdgeInsets.only(left: 12)),
          decoration: BoxDecoration(
            color: context.colorScheme.onBackground,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFF272727)),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: salon.name,
                          style: context.textTheme.bodyLarge?.copyWith(
                            fontFamily: FontFamily.geologica,
                          ),
                        ),
                        TextSpan(
                          text: "\n${salon.address}",
                          style: context.textTheme.bodySmall?.copyWith(
                            color: Colors.grey,
                            fontFamily: FontFamily.geologica,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Radio<Salon>(
                    value: salon,
                    groupValue: currentSalon,
                    onChanged: onChanged,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8, bottom: 8, top: 4),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset('assets/images/oko_lashes.png'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Время работы',
                            style: context.textTheme.bodyLarge?.copyWith(
                              fontFamily: FontFamily.geologica,
                            ),
                          ),
                          TextSpan(
                            text: "\nпн.-вс.: 10:00 - 21:00",
                            style: context.textTheme.bodySmall?.copyWith(
                              color: Colors.grey,
                              fontFamily: FontFamily.geologica,
                            ),
                          ),
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Телефон',
                            style: context.textTheme.bodyLarge?.copyWith(
                              fontFamily: FontFamily.geologica,
                            ),
                          ),
                          TextSpan(
                            text: "\n${salon.phone.formatPhoneNumber()}",
                            style: context.textTheme.bodySmall?.copyWith(
                              color: Colors.grey,
                              fontFamily: FontFamily.geologica,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}