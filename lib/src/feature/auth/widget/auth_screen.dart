import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ln_studio/src/common/widget/custom_text_field.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

final phoneFormatter = MaskTextInputFormatter(
  mask: '+7 (###) ###-##-##',
  filter: {"#": RegExp(r'[0-9]')},
  type: MaskAutoCompletionType.lazy,
);

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Номер телефона',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 12),
              Text(
                'Укажите номер телефона',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).hintColor,
                    ),
              ),
              const SizedBox(height: 8),
              CustomTextField(
                keyboardType: TextInputType.phone,
                hintText: '+7 (000) 000-00-00',
                inputFormatters: [phoneFormatter],
                // TODO: Implement phone number validation
                validator: (text) {},
              ),
              const SizedBox(height: 16),
              FilledButton(
                child: const Text('Продолжить'),
                onPressed: () {
                  context.goNamed('verify');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
