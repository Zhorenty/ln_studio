import 'package:flutter/material.dart';
import 'package:ln_studio/src/common/assets/generated/assets.gen.dart';
import 'package:ln_studio/src/common/utils/extensions/context_extension.dart';

class InformationWidget extends StatelessWidget {
  const InformationWidget({
    super.key,
    this.customImagePath,
    this.isNeedToShowImage = false,
    required this.title,
    required this.description,
    this.reloadFunc,
  });

  InformationWidget.empty({
    super.key,
    String? customImagePath,
    this.isNeedToShowImage = false,
    this.title = 'Упс',
    this.description = 'Данные отсутствуют',
    this.reloadFunc,
  }) : customImagePath = customImagePath ?? Assets.images.placeholder.path;

  InformationWidget.error({
    super.key,
    String? customImagePath,
    this.isNeedToShowImage = false,
    this.title = 'Ошибка',
    this.description = 'Что-то пошло не так',
    required this.reloadFunc,
  }) : customImagePath = customImagePath ?? Assets.images.placeholder.path;

  final String? customImagePath;
  final bool isNeedToShowImage;
  final String title;
  final String? description;
  final VoidCallback? reloadFunc;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: context.colorScheme.onBackground,
        borderRadius: BorderRadius.circular(25),
      ),
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isNeedToShowImage && customImagePath != null)
            Padding(
              padding: const EdgeInsets.all(20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.asset(customImagePath!),
              ),
            ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          if (description != null) ...[
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                description!,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
          if (reloadFunc != null) ...[
            const SizedBox(height: 8),
            FilledButton(
              onPressed: reloadFunc,
              child: const Text('Обновить'),
            ),
          ]
        ],
      ),
    );
  }
}
