import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/src/common/utils/extensions/context_extension.dart';
import 'floating_snack_bar.dart';
import 'modal_popup.dart';

/// Helper to display a popup message in UI.
class MessagePopup {
  /// Shows an error popup with the provided argument.
  static Future<void> error(BuildContext context, dynamic e) async {
    var message = e.toString();

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ошибка'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('Хорошо'),
          )
        ],
      ),
    );
  }

  /// Shows a confirmation popup with the specified [title], [description],
  /// and [additional] widgets to put under the [description].
  static Future<bool?> bottomSheet(
    BuildContext context,
    String? title, {
    List<TextSpan> description = const [],
    List<Widget> additional = const [],
  }) {
    return ModalPopup.show(
      context: context,
      child: Builder(
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 4),
              ModalPopupHeader(text: title),
              const SizedBox(height: 13),
              Flexible(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    if (description.isNotEmpty)
                      Padding(
                        padding: ModalPopup.padding(context),
                        child: Center(
                          child: RichText(
                            text: TextSpan(
                              children: description,
                              style: context.textTheme.bodyLarge,
                            ),
                          ),
                        ),
                      ),
                    ...additional.map(
                      (e) => Padding(
                        padding: ModalPopup.padding(context),
                        child: e,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          );
        },
      ),
    );
  }

  /// Shows a [FloatingSnackBar] with the [title] message.
  static void success(
    BuildContext context,
    String title, {
    double bottom = 16,
  }) =>
      FloatingSnackBar.show(context, title, bottom: bottom);
}
