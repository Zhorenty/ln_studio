import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/src/common/utils/extensions/context_extension.dart';
import '/src/common/utils/phone_input_formatter.dart';
import '/src/common/widget/custom_text_field.dart';
// import 'auth_scope.dart';

// final phoneFormatter = MaskTextInputFormatter(
//   mask: '+7 (###) ###-##-##',
//   filter: {"#": RegExp(r'[0-9]')},
//   type: MaskAutoCompletionType.lazy,
// );

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  /// [FormState] for validating.
  final _formKey = GlobalKey<FormState>();

  ///
  late final FocusNode phoneFocusNode;

  @override
  void initState() {
    super.initState();
    phoneFocusNode = FocusNode();
  }

  @override
  void dispose() {
    phoneFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final auth = AuthenticationScope.of(context);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Номер телефона',
                style: context.textTheme.headlineLarge,
              ),
              const SizedBox(height: 12),
              Text(
                'Укажите номер телефона',
                style: context.textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).hintColor,
                ),
              ),
              const SizedBox(height: 8),
              CustomTextField(
                focusNode: phoneFocusNode,
                keyboardType: TextInputType.phone,
                hintText: '+7 (123) 456-78-90',
                inputFormatters: [RuPhoneInputFormatter()],
                // TODO: Implement phone number validation
                validator: (text) {
                  return null;
                },
                onTapOutside: (_) =>
                    phoneFocusNode.hasFocus ? phoneFocusNode.unfocus() : null,
                onChanged: _checkPhoneNumber,
              ),
              const SizedBox(height: 16),
              FilledButton(
                child: const Text('Продолжить'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // TODO: Implement auth logic
                    context.goNamed('verify');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Phone number FocusNode condition.
  void _checkPhoneNumber(String value) {
    if ((value.length == 18 && value.startsWith('+')) ||
        (value.length == 17 && value.startsWith('8'))) {
      phoneFocusNode.unfocus();
    }
  }
}
