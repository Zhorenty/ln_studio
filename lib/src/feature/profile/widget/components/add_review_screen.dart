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
  late final FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
    focusNode = FocusNode()..requestFocus();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Оставить отзыв', style: TextStyle(fontSize: 24)),
          const SizedBox(height: 20),
          HugeTextField(
            controller: textEditingController,
            focusNode: focusNode,
          ),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: () => widget.onPressed(textEditingController.text),
            child: const Text('Отправить'),
          ),
        ],
      ),
    );
  }
}
