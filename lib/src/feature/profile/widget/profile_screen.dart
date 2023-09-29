import 'package:flutter/material.dart';
import 'package:ln_studio/src/common/assets/generated/assets.gen.dart';
import 'package:ln_studio/src/common/assets/generated/fonts.gen.dart';
import 'package:ln_studio/src/common/utils/extensions/context_extension.dart';
import 'package:ln_studio/src/common/widget/custom_divider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            title: Text(
              'Профиль',
              style: context.textTheme.titleLarge?.copyWith(
                fontSize: 20,
                fontFamily: FontFamily.geologica,
                color: context.colorScheme.secondary,
              ),
            ),
          ),
          SliverList.list(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                padding: const EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 12,
                ),
                decoration: BoxDecoration(
                  color: context.colorScheme.onBackground,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    'Евгений Логинов',
                    style: context.textTheme.headlineSmall?.copyWith(
                      fontFamily: FontFamily.geologica,
                      color: context.colorScheme.secondary,
                    ),
                  ),
                  subtitle: Text(
                    '+7 (960) 487-53-29',
                    style: context.textTheme.titleSmall?.copyWith(
                      fontFamily: FontFamily.geologica,
                      color: context.colorScheme.primary,
                    ),
                  ),
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 12,
                    ),
                    decoration: ShapeDecoration(
                      shape: const CircleBorder(),
                      color: context.colorScheme.primary,
                    ),
                    child: Icon(
                      Icons.edit,
                      color: context.colorScheme.onBackground,
                      size: 20,
                    ),
                  ),
                ),
              ),
              const CustomDivider(),
              const CategoryListTile(title: 'История записей'),
              const CustomDivider(),
              const CategoryListTile(title: 'Настройки'),
              const CustomDivider(),
              const CategoryListTile(title: 'Поддержка'),
              const CustomDivider(),
              const CategoryListTile(title: 'Работать с нами'),
              const CustomDivider(),
              const CategoryListTile(title: 'Выйти'),
              const CustomDivider(),
              SizedBox(
                height: 150,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleWidget(
                      child: Assets.images.vkIcon.image(
                        scale: 20,
                        color: context.colorScheme.primary,
                      ),
                    ),
                    CircleWidget(
                      child: Assets.images.whatsappIcon.image(
                        scale: 20,
                        color: context.colorScheme.primary,
                      ),
                    ),
                    CircleWidget(
                      child: Assets.images.telegramIcon.image(
                        scale: 25,
                        color: context.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

///
class CircleWidget extends StatelessWidget {
  const CircleWidget({super.key, this.child});

  ///
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        shape: const CircleBorder(),
        color: context.colorScheme.onBackground,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.all(10),
      child: child,
    );
  }
}

///
class CategoryListTile extends StatelessWidget {
  const CategoryListTile({super.key, required this.title});

  ///
  final String title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: context.colorScheme.background,
      title: Text(
        title,
        style: context.textTheme.bodyLarge?.copyWith(
          fontFamily: FontFamily.geologica,
          color: context.colorScheme.secondary,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios_rounded,
        color: context.colorScheme.primaryContainer,
        size: 22,
      ),
    );
  }
}
