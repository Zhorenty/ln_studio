import 'package:flutter/material.dart';
import 'package:ln_studio/src/common/assets/generated/assets.gen.dart';
import 'package:ln_studio/src/common/utils/extensions/context_extension.dart';

class InformationWidget extends StatelessWidget {
  const InformationWidget({
    Key? key,
    required this.imagePath,
    this.isNeedToShowImage = false,
    required this.title,
    required this.description,
    required this.reloadFunc,
  }) : super(key: key);

  InformationWidget.empty({
    Key? key,
    String? imagePath,
    this.isNeedToShowImage = false,
    this.title = 'Упс',
    String? description = 'Данные отсутствуют',
    this.reloadFunc,
  })  : imagePath = imagePath ?? Assets.images.placeholder.path, // emptyImage
        description = description ?? 'Данные отсутствуют',
        super(key: key);

  InformationWidget.error({
    Key? key,
    String? imagePath,
    this.isNeedToShowImage = false,
    this.title = 'Ошибка',
    String? description = 'Что-то пошло не так',
    required this.reloadFunc,
  })  : imagePath = imagePath ?? Assets.images.placeholder.path, // errorImage
        description = description ?? 'Что-то пошло не так',
        super(key: key);

  final String imagePath;
  final bool isNeedToShowImage;
  final String title;
  final String description;
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
          if (isNeedToShowImage)
            Padding(
              padding: const EdgeInsets.all(20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.asset(imagePath),
              ),
            ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              description,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          if (reloadFunc != null) ...[
            const SizedBox(height: 8),
            FilledButton(
              onPressed: reloadFunc,
              child: const Text('Попробовать снова'),
            ),
          ]
        ],
      ),
    );
  }
}
