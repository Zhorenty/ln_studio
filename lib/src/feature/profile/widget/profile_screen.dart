import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ln_studio/src/common/widget/animated_button.dart';
import 'package:ln_studio/src/common/widget/overlay/modal_popup.dart';
import 'package:ln_studio/src/feature/auth/widget/auth_scope.dart';
import 'package:url_launcher/url_launcher.dart';

import '/src/common/assets/generated/assets.gen.dart';
import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/utils/extensions/context_extension.dart';
import '/src/common/widget/custom_divider.dart';
import 'components/category_list_tile.dart';
import 'components/header_list_tile.dart';
import '/src/common/utils/extensions/string_extension.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final auth = AuthenticationScope.of(context);
    final user = auth.user;

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
              HeaderListTile(
                title: user?.fullName ?? 'Настройте профиль',
                subtitle: user?.phone?.formatPhoneNumber(),
                onPressed: () => context.goNamed('profile_edit'),
              ),
              const CustomDivider(),
              CategoryListTile(
                icon: Icons.history_rounded,
                title: 'Мои записи',
                size: 23,
                onTap: () => context.goNamed('booking_history'),
              ),
              const CustomDivider(),
              CategoryListTile(
                icon: Icons.notifications_rounded,
                title: 'Уведомления',
                onTap: () => context.goNamed('notifications'),
              ),
              const CustomDivider(),
              CategoryListTile(
                icon: Icons.loyalty_rounded,
                title: 'Персональные скидки',
                onTap: () => context.goNamed('discounts'),
              ),
              const CustomDivider(),
              CategoryListTile(
                icon: Icons.payment_rounded,
                title: 'Способы оплаты',
                size: 23,
                onTap: () => context.goNamed('payment'),
              ),
              const CustomDivider(),
              CategoryListTile(
                onTap: _launchWhatsApp,
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
              CategoryListTile(
                onTap: () => showExit(context, auth.signOut),
                icon: Icons.exit_to_app,
                title: 'Выйти',
                size: 23,
              ),
              const CustomDivider(),
              SizedBox(
                height: MediaQuery.sizeOf(context).height / 6.25,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RedirectIcon(
                      onPressed: _launchVk,
                      child: Assets.images.vkIcon.image(
                        scale: 20,
                        color: context.colorScheme.secondary,
                      ),
                    ),
                    RedirectIcon(
                      onPressed: _launchWhatsApp,
                      child: Assets.images.whatsappIcon.image(
                        scale: 20,
                        color: context.colorScheme.secondary,
                      ),
                    ),
                    RedirectIcon(
                      onPressed: _launchTelegram,
                      child: Assets.images.telegramIcon.image(
                        scale: 25,
                        color: context.colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<dynamic> showExit(
    BuildContext context,
    void Function()? onPressed,
  ) =>
      ModalPopup.show(
        context: context,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Уже уходите?',
              style: context.textTheme.titleLarge?.copyWith(
                fontFamily: FontFamily.geologica,
              ),
            ),
            const SizedBox(height: 16),
            Assets.images.exit.image(scale: 8),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.pop(),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                fixedSize: Size(MediaQuery.sizeOf(context).width - 50, 50),
                backgroundColor: context.colorScheme.primary,
              ),
              child: Text(
                'Я остаюсь',
                style: context.textTheme.bodyLarge?.copyWith(
                  fontFamily: FontFamily.geologica,
                  color: context.colorScheme.onBackground,
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                fixedSize: Size(MediaQuery.sizeOf(context).width - 50, 50),
                backgroundColor: context.colorScheme.onBackground,
              ),
              child: Text(
                'Выйти',
                style: context.textTheme.bodyLarge?.copyWith(
                  fontFamily: FontFamily.geologica,
                ),
              ),
            ),
          ],
        ),
      );

  void _launchVk() async {
    final url = Uri.parse('https://vk.com/salonokolashes');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _launchWhatsApp() async {
    final url = Uri.parse('https://wa.me/79604875329');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _launchTelegram() async {
    final url = Uri.parse('https://t.me/oko_lashes_keasnodar');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

///
class RedirectIcon extends StatelessWidget {
  const RedirectIcon({super.key, this.onPressed, this.child});

  ///
  final void Function()? onPressed;

  ///
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return AnimatedButton(
      onPressed: onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: context.colorScheme.onBackground,
          border: Border.all(color: const Color(0xFF202020)),
        ),
        child: child,
      ),
    );
  }
}
