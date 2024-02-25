import 'package:flutter/material.dart';
import 'package:ln_studio/src/common/assets/generated/fonts.gen.dart';
import 'package:ln_studio/src/common/utils/extensions/context_extension.dart';

/// Large text field for comments.
class HugeTextField extends StatelessWidget {
  const HugeTextField({super.key, this.controller, this.focusNode});

  ///
  final TextEditingController? controller;

  ///
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      alignment: Alignment.topCenter,
      duration: const Duration(milliseconds: 300),
      child: Container(
        margin: const EdgeInsets.only(top: 8, bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: context.colorScheme.background,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF272727)),
        ),
        child: TextFormField(
          onTapOutside: (_) =>
              focusNode!.hasFocus ? focusNode?.unfocus() : null,
          controller: controller,
          focusNode: focusNode,
          maxLines: null,
          keyboardType: TextInputType.multiline,
          style: context.textTheme.bodyLarge!.copyWith(
            fontFamily: FontFamily.geologica,
            letterSpacing: 0.5,
          ),
          decoration: InputDecoration(
            isDense: true,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: context.colorScheme.scrim,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: context.colorScheme.scrim),
            ),
          ),
        ),
      ),
    );
  }
}
