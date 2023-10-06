import 'package:flutter/material.dart';
import 'package:ln_studio/src/common/widget/custom_text_field.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Подтверждение',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 16),
            const CustomTextField(
              keyboardType: TextInputType.number,
              maxLength: 6,
              hintText: 'Введите код из смс',
            ),
            const SizedBox(height: 16),
            FilledButton(
              child: const Text('Далее'),
              onPressed: () {
                // TODO: Implement verification logic
              },
            ),
            const SizedBox(height: 16),
            TextButton(
              child: const Text('Получить новый код'),
              onPressed: () {
                /*
                TODO: Implement resend code logic
                Если нет аккаунта на сервере, то показываем показываем форму
                регистрации (имя, номер телефона, почта)
                */
              },
            ),
          ],
        ),
      ),
    );
  }
}
