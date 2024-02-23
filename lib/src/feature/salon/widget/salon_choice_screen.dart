import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ln_studio/src/common/assets/generated/assets.gen.dart';
import 'package:ln_studio/src/common/assets/generated/fonts.gen.dart';
import 'package:ln_studio/src/common/utils/extensions/string_extension.dart';
import 'package:ln_studio/src/common/widget/animated_button.dart';

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
    this.currentSalon,
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
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: context.colorScheme.onBackground,
        body: BlocConsumer<SalonBLoC, SalonState>(
          listener: (context, state) {
            if (state.currentSalon != null) {
              context.pop();
            }
          },
          listenWhen: (previous, current) {
            if (previous.currentSalon?.id != current.currentSalon?.id) {
              return true;
            }
            return false;
          },
          builder: (context, state) {
            return salonBloc.state.hasData
                ? CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        title: Text(
                          'Выберите салон',
                          style: context.textTheme.titleLarge!.copyWith(
                            color: context.colorScheme.secondary,
                            fontFamily: FontFamily.geologica,
                          ),
                        ),
                        leading: AnimatedButton(
                          padding: const EdgeInsets.only(right: 12),
                          child: const Icon(Icons.arrow_back_ios_new_rounded),
                          onPressed: () => state.currentSalon != null
                              ? context.pop()
                              : showAdaptiveDialog(
                                  context: context,
                                  // TODO: Вынести в CustomAlert
                                  builder: (context) => AlertDialog.adaptive(
                                    title: const Text('Выберите салон'),
                                    content: const Text(
                                      'Для использования приложения необходимо выбрать желаемый салон',
                                    ),
                                    actions: [
                                      Platform.isIOS
                                          ? CupertinoDialogAction(
                                              onPressed: context.pop,
                                              isDefaultAction: true,
                                              child: const Text('Окей'),
                                            )
                                          : TextButton(
                                              onPressed: context.pop,
                                              child: const Text('Окей'),
                                            ),
                                    ],
                                  ),
                                ),
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.all(8),
                        sliver: SliverList.builder(
                          itemCount: state.data?.length,
                          itemBuilder: (context, index) {
                            return _SalonChoiceRow(
                              salon: state.data![index],
                              currentSalon: widget.currentSalon,
                              onChanged: (salon) {
                                if (widget.onChanged == null) {
                                  salonBloc.add(
                                    SalonEvent.saveCurrent(salon!),
                                  );
                                } else {
                                  setState(() => widget.onChanged!(salon));
                                }
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  )
                : const Shimmer();
          },
        ),
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
            color: context.colorScheme.background,
            borderRadius: BorderRadius.circular(16),
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
                  child: Assets.images.okoLashes.image(),
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
