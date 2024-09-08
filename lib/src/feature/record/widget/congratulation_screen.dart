import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ln_studio/src/common/assets/generated/assets.gen.dart';
import 'package:ln_studio/src/common/assets/generated/fonts.gen.dart';
import 'package:ln_studio/src/common/utils/extensions/context_extension.dart';
import 'package:ln_studio/src/common/widget/animated_button.dart';
import 'package:ln_studio/src/common/widget/maps_sheet.dart';
import 'package:ln_studio/src/common/widget/overlay/modal_popup.dart';
import 'package:ln_studio/src/feature/salon/bloc/salon_bloc.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CongratulationScreen extends StatefulWidget {
  const CongratulationScreen({super.key, required this.url});

  final String url;

  @override
  State<CongratulationScreen> createState() => _CongratulationScreenState();
}

class _CongratulationScreenState extends State<CongratulationScreen> {
  late final WebViewController _controller;
  @override
  void initState() {
    super.initState();
    _controller = WebViewController()..loadRequest(Uri.parse(widget.url));

    Future.delayed(
      Duration.zero,
      () => ModalPopup.show(
        context: context,
        child: WebViewWidget(controller: _controller),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.onBackground,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.images.congrats.image(),
          Text(
            'Спасибо!',
            style: context.textTheme.titleMedium?.copyWith(
              fontFamily: FontFamily.geologica,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Запись создана! Проверяем вашу оплату.',
            style: context.textTheme.titleSmall?.copyWith(
              fontFamily: FontFamily.geologica,
            ),
          ),
          const SizedBox(height: 16),
          CustomButton(
            color: context.colorScheme.primary,
            child: Text(
              'Готово',
              style: context.textTheme.bodyLarge?.copyWith(
                fontFamily: FontFamily.geologica,
                color: context.colorScheme.onBackground,
              ),
            ),
            onPressed: () => context.goNamed('home'),
          ),
          GestureDetector(
            onTap: () => showMapsSheet(
              context: context,
              coords: Coords(45.019641, 39.025248),
              title: context.read<SalonBLoC>().state.currentSalon!.name,
            ),
            child: const InformationRow(
              title: 'Проложить маршрут',
              leading: Icons.location_on_outlined,
              size: 22,
            ),
          ),
          const SizedBox(height: 32 + 16)
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
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color,
          border: border,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(child: child),
      ),
    );
  }
}

///
class InformationRow extends StatelessWidget {
  const InformationRow({
    super.key,
    required this.leading,
    required this.title,
    this.size = 20,
  });

  ///
  final IconData leading;

  ///
  final String title;

  ///
  final double size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: ListTile(
        dense: true,
        leading: Icon(leading, size: size),
        title: Text(
          title,
          style: context.textTheme.bodyMedium?.copyWith(
            fontFamily: FontFamily.geologica,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 18),
      ),
    );
  }
}
