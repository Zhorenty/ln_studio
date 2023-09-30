import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ln_studio/src/common/widget/animated_button.dart';

import '/src/common/assets/generated/assets.gen.dart';
import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/utils/extensions/context_extension.dart';
import '/src/common/widget/custom_divider.dart';
import 'components/category_list_tile.dart';
import 'components/header_list_tile.dart';

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
          const CupertinoSliverRefreshControl(),
          SliverList.list(
            children: [
              HeaderListTile(
                onPressed: () => context.pushNamed('profile_edit'),
              ),
              const CustomDivider(),
              CategoryListTile(
                icon: Icons.history_rounded,
                title: 'Мои записи',
                size: 23,
                onTap: () => context.pushNamed('booking_history'),
              ),
              const CustomDivider(),
              const CategoryListTile(
                icon: Icons.settings_rounded,
                title: 'Настройки',
              ),
              const CustomDivider(),
              const CategoryListTile(
                icon: Icons.loyalty_rounded,
                title: 'Персональные скидки',
              ),
              const CustomDivider(),
              const CategoryListTile(
                icon: Icons.payment_rounded,
                title: 'Способы оплаты',
                size: 23,
              ),
              const CustomDivider(),
              const CategoryListTile(
                icon: Icons.help_outline_rounded,
                title: 'Поддержка',
                size: 23.5,
              ),
              const CustomDivider(),
              const CategoryListTile(
                icon: Icons.work_rounded,
                title: 'Работать с нами',
              ),
              const CustomDivider(),
              const CategoryListTile(
                icon: Icons.exit_to_app,
                title: 'Выйти',
                size: 23,
              ),
              const CustomDivider(),
              SizedBox(
                height: 150,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedButton(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 21,
                          backgroundColor: context.colorScheme.onBackground,
                          child: Assets.images.vkIcon.image(
                            scale: 20,
                            color: context.colorScheme.secondary,
                          ),
                        ),
                      ),
                    ),
                    AnimatedButton(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 21,
                          backgroundColor: context.colorScheme.onBackground,
                          child: Assets.images.whatsappIcon.image(
                            scale: 20,
                            color: context.colorScheme.secondary,
                          ),
                        ),
                      ),
                    ),
                    AnimatedButton(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 21,
                          backgroundColor: context.colorScheme.onBackground,
                          child: Assets.images.telegramIcon.image(
                            scale: 25,
                            color: context.colorScheme.secondary,
                          ),
                        ),
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
