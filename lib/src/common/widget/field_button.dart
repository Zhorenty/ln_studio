import 'package:flutter/material.dart';
import 'package:ln_studio/src/common/assets/generated/fonts.gen.dart';
import 'package:ln_studio/src/common/utils/extensions/context_extension.dart';
import 'package:ln_studio/src/common/widget/animated_button.dart';

import 'custom_text_field.dart';

class FieldButton extends StatefulWidget {
  const FieldButton({
    super.key,
    this.label,
    this.onTap,
    this.controller,
    this.validator,
    this.labelStyle,
    this.onSuffixPressed,
    this.hintText,
    this.deletable = false,
  });

  ///
  final TextEditingController? controller;

  ///
  final String? label;

  ///
  final TextStyle? labelStyle;

  ///
  final bool deletable;

  ///
  final void Function()? onSuffixPressed;

  ///
  final void Function()? onTap;

  ///
  final String? hintText;

  ///
  final String? Function(String?)? validator;

  @override
  State<FieldButton> createState() => _FieldButtonState();
}

class _FieldButtonState extends State<FieldButton> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: widget.onTap,
          child: CustomTextField(
            enabled: false,
            controller: widget.controller,
            hintText: widget.hintText,
            label: widget.label,
            labelStyle: widget.labelStyle,
            validator: widget.validator,
            errorStyle: widget.deletable
                ? context.textTheme.bodyLarge?.copyWith(fontSize: 0)
                : context.textTheme.bodyLarge?.copyWith(
                    fontFamily: FontFamily.geologica,
                  ),
          ),
        ),
        if (widget.controller!.text.isNotEmpty && widget.deletable == true)
          Positioned.fill(
            child: Align(
              alignment: Alignment.centerRight,
              child: AnimatedButton(
                padding: const EdgeInsets.only(right: 16),
                onPressed: widget.onSuffixPressed,
                enabled: widget.onSuffixPressed != null,
                child: Icon(
                  Icons.clear_rounded,
                  size: 25,
                  color: context.colorScheme.primaryContainer,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
