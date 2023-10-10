import 'package:flutter/material.dart';
import 'package:ln_studio/src/common/widget/custom_text_field.dart';

// import 'auth_scope.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  ///
  late final FocusNode verificationCodeFocusNode;

  @override
  void initState() {
    super.initState();
    verificationCodeFocusNode = FocusNode();
  }

  @override
  void dispose() {
    verificationCodeFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final auth = AuthenticationScope.of(context);
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
            CustomTextField(
              keyboardType: TextInputType.number,
              maxLength: 4,
              hintText: 'Введите код из смс',
              onChanged: _checkVerificationCode,
              onTapOutside: (_) => verificationCodeFocusNode.hasFocus
                  ? verificationCodeFocusNode.unfocus()
                  : null,
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

  /// Phone number FocusNode condition.
  void _checkVerificationCode(String value) =>
      value.length == 4 ? verificationCodeFocusNode.unfocus() : null;
}
