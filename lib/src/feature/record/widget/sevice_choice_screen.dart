import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ln_studio/src/common/assets/generated/fonts.gen.dart';
import 'package:ln_studio/src/common/utils/extensions/context_extension.dart';
import 'package:ln_studio/src/common/widget/animated_button.dart';
import 'package:ln_studio/src/feature/record/bloc/category/category_bloc.dart';
import 'package:ln_studio/src/feature/record/bloc/category/category_state.dart';

class ServiceChoiceScreen extends StatefulWidget {
  const ServiceChoiceScreen({super.key});

  @override
  State<ServiceChoiceScreen> createState() => _ServiceChoiceScreenState();
}

class _ServiceChoiceScreenState extends State<ServiceChoiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.background,
      body: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: context.colorScheme.background,
                pinned: true,
                title: Text(
                  'Выбор услуги',
                  style: context.textTheme.titleLarge!.copyWith(
                    fontFamily: FontFamily.geologica,
                  ),
                ),
                leading: AnimatedButton(
                  child: const Icon(Icons.arrow_back_ios_new_rounded),
                  onPressed: () => context.pop(),
                ),
              ),
              SliverList.builder(
                itemCount: state.categoryWithServices.length,
                itemBuilder: (context, index) {
                  return ExpansionTile(
                    backgroundColor: context.colorScheme.onBackground,
                    collapsedBackgroundColor: context.colorScheme.background,
                    title: Text(
                      state.categoryWithServices[index].name,
                      style: context.textTheme.bodyLarge?.copyWith(
                        fontFamily: FontFamily.geologica,
                      ),
                    ),
                    children: [
                      ...state.categoryWithServices[index].service.map(
                        (service) => ServiceCard(
                          title: service.name,
                          subtitle: (
                            'Стоимость: ',
                            '${service.price.toString()} ₽',
                          ),
                          description: service.description,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

///
class ServiceCard extends StatefulWidget {
  const ServiceCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.description,
  });

  ///
  final String title;

  ///
  final (String, String) subtitle;

  ///
  final String description;

  @override
  State<ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        padding: const EdgeInsets.all(8),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: context.colorScheme.background,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.radio_button_off),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${widget.title} / Maniqouir',
                    style: context.textTheme.titleMedium?.copyWith(
                      fontFamily: FontFamily.geologica,
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: widget.subtitle.$1,
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: context.colorScheme.primaryContainer,
                            fontFamily: FontFamily.geologica,
                          ),
                        ),
                        TextSpan(
                          text: widget.subtitle.$2,
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: context.colorScheme.secondary,
                            fontFamily: FontFamily.geologica,
                          ),
                        ),
                      ],
                    ),
                  ),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    child: expanded
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              widget.description,
                              style: context.textTheme.bodyMedium!.copyWith(
                                fontFamily: FontFamily.geologica,
                                color: context.colorScheme.primaryContainer,
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
            AnimatedButton(
              padding: const EdgeInsets.only(left: 8),
              onPressed: () => setState(() => expanded = !expanded),
              child: const Icon(Icons.info_outline, size: 18),
            ),
          ],
        ),
      ),
    );
  }
}
