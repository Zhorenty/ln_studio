import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ln_studio/src/common/assets/generated/fonts.gen.dart';
import 'package:ln_studio/src/common/utils/extensions/context_extension.dart';

const _maxLength = 4;

class VerificationCodeField extends StatefulWidget {
  /// Code length
  ///
  /// Default value is 4
  final int length;

  /// Function to be called when fields are filled
  final VoidCallback? onSubmit;

  /// Will be called each time value of field changes
  final Function(String value)? onChange;

  /// Whether automatically focus on field or not
  ///
  /// Default value is true
  final bool autofocus;

  /// Custom header widget
  ///
  /// Will be placed above the [VerificationCodeField]
  final Widget? header;

  /// Whether field is enabled ot not
  ///
  /// Default value is [true]
  final bool? enabled;

  final List<String>? autofillHints;

  /// Whether to show the indicator or not
  ///
  /// Default value is [true]
  final bool showFocusIndicator;

  /// Whether to blink the indicator or not
  ///
  /// [showFocusIndicator] should be [true]
  /// Default value is [true]
  final bool blinkFocusIndicator;

  /// Decides what type of keyboard should be displayed
  ///
  /// Default value is [TextInputType.number]
  final TextInputType? keyboardType;

  /// A [FocusNode] for managing focus on field
  final FocusNode? focusNode;

  final TextEditingController? controller;

  const VerificationCodeField({
    super.key,
    this.length = _maxLength,
    this.onSubmit,
    this.onChange,
    this.autofocus = true,
    this.enabled = true,
    this.keyboardType = TextInputType.number,
    this.focusNode,
    this.header,
    this.showFocusIndicator = true,
    this.blinkFocusIndicator = true,
    this.autofillHints,
    this.controller,
  });

  @override
  State<VerificationCodeField> createState() => _VerificationCodeFieldState();
}

class _VerificationCodeFieldState extends State<VerificationCodeField> {
  List<String> code = [];

  late final FocusNode _focusNode;

  void onCodeChanged(String value) {
    setState(() => code = value.split(''));
    if (widget.onChange != null) widget.onChange!(value);
    if (value.length == widget.length) {
      FocusScope.of(context).unfocus();
      if (widget.onSubmit != null) widget.onSubmit!();
    }
  }

  @override
  void initState() {
    _focusNode = widget.focusNode ?? FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        // Hide text field
        Visibility(
          visible: false,
          maintainState: true,
          maintainInteractivity: true,
          maintainSize: true,
          maintainAnimation: true,
          maintainSemantics: true,
          child: TextField(
            controller: widget.controller,
            autofocus: widget.autofocus,
            enabled: widget.enabled,
            keyboardType: widget.keyboardType,
            maxLength: widget.length,
            focusNode: _focusNode,
            onChanged: onCodeChanged,
            autofillHints: widget.autofillHints,
            onTapOutside: (_) =>
                _focusNode.hasFocus ? _focusNode.unfocus() : null,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.header != null) widget.header!,
            GestureDetector(
              onTap: _focusNode.requestFocus,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List<Widget>.generate(
                  widget.length,
                  buildCell,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildCell(int index) {
    final isFocused = index == code.length && _focusNode.hasFocus;
    return Cell(
      key: UniqueKey(),
      isFocused: isFocused,
      showFocusIndicator: widget.showFocusIndicator && isFocused,
      blinkFocusIndicator: widget.blinkFocusIndicator,
      // prevent access of a non existent list member
      value: index < code.length ? code[index] : null,
    );
  }
}

/// Single cell in [CodeVerificationField] group of cells
class Cell extends StatelessWidget {
  /// Is this is a currently focused cell
  final bool isFocused;

  /// Value of each cell
  final String? value;

  /// Whether to show a focus indicator or not
  final bool showFocusIndicator;

  /// Whether to blink focus Indicator or not
  final bool blinkFocusIndicator;

  const Cell({
    super.key,
    required this.isFocused,
    required this.value,
    required this.showFocusIndicator,
    required this.blinkFocusIndicator,
  });

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF272727);
    final backgroundColor = context.colorScheme.background;
    const height = 70.0;
    const width = 70.0;
    const borderWidth = 1.0;
    const borderColor = primaryColor;
    const borderRadius = 16.0;

    final textStyle = context.textTheme.titleLarge?.copyWith(
      fontFamily: FontFamily.geologica,
      color: context.colorScheme.secondary,
      fontWeight: FontWeight.bold,
    );

    return Container(
      width: width,
      height: height,
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: borderColor,
          width: borderWidth,
        ),
        color: backgroundColor,
      ),
      child: showFocusIndicator && value == null
          ? Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Blinker(
                color: context.colorScheme.secondary,
                blink: blinkFocusIndicator,
              ),
            )
          : Center(
              child: Text(
                value ?? ' ',
                style: textStyle,
              ),
            ),
    );
  }
}

class Blinker extends StatefulWidget {
  const Blinker({super.key, required this.color, this.blink = true});

  final Color color;
  final bool blink;

  @override
  State<Blinker> createState() => _BlinkerState();
}

class _BlinkerState extends State<Blinker> {
  bool visible = true;
  Timer? timer;

  @override
  void initState() {
    // Do not add timer if blink is false
    if (widget.blink) {
      timer = Timer.periodic(const Duration(milliseconds: 500), (_) {
        setState(() => visible = !visible);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: SizedBox(
        height: 2,
        width: 20,
        child: ColoredBox(color: widget.color),
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
