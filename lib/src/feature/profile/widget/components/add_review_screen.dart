import 'package:flutter/material.dart';
import 'package:ln_studio/src/common/widget/huge_text_field.dart';

/// {@template add_review_screen}
/// AddReviewScreen widget.
/// {@endtemplate}
class AddReviewScreen extends StatefulWidget {
  /// {@macro add_review_screen}
  const AddReviewScreen({
    super.key,
    required this.onPressed,
  });

  final void Function(String text) onPressed;

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  late final TextEditingController textEditingController;
  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HugeTextField(
          controller: textEditingController,
          focusNode: primaryFocus,
        ),
        const SizedBox(height: 20),
        FilledButton(
          onPressed: () => widget.onPressed(textEditingController.text),
          child: const Text('Отправить'),
        ),
      ],
    );
  }
}
