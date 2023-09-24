import 'package:flutter/material.dart';
import 'package:ln_studio/src/common/widget/animated_button.dart';

import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/utils/extensions/context_extension.dart';

class RecordScreen extends StatelessWidget {
  const RecordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.onBackground,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            title: Text(
              'Запись на маникюр',
              style: context.textTheme.titleLarge?.copyWith(
                fontFamily: FontFamily.geologica,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverToBoxAdapter(
              child: DefaultTextStyle(
                style: context.textTheme.titleMedium!.copyWith(
                  fontFamily: FontFamily.geologica,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Выберите услугу'),
                    const CustomContainer(),
                    const Text('Выберите мастера'),
                    const CustomContainer(),
                    const Text('Выберите дату и время'),
                    const CustomContainer(),
                    const Text('Филиал'),
                    const CustomContainer(),
                    const Text('Комментарий к записи'),
                    const HugeTextField(),
                    const Text('Стоимость: 1 700 000 ₽'),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 32 + 16,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 12,
                        ),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: context.colorScheme.primary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'Записаться',
                          style: context.textTheme.bodyLarge?.copyWith(
                            color: context.colorScheme.onBackground,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

///
class CustomContainer extends StatelessWidget {
  const CustomContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      margin: const EdgeInsets.only(top: 10, bottom: 12),
      decoration: BoxDecoration(
        color: context.colorScheme.background,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF272727)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: 5,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
                color: context.colorScheme.primary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'sdkfamds',
              style: context.textTheme.bodyLarge?.copyWith(
                fontFamily: FontFamily.geologica,
              ),
            ),
          ),
          const AnimatedButton(
            padding: EdgeInsets.only(right: 4),
            child: Icon(Icons.close_rounded),
          ),
        ],
      ),
    );
  }
}

/// Large text field for comments.
class HugeTextField extends StatelessWidget {
  const HugeTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: const EdgeInsets.only(top: 8, bottom: 12),
      decoration: BoxDecoration(
        color: context.colorScheme.background,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF272727)),
      ),
    );
  }
}
