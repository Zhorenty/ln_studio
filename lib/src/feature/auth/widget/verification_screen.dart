import 'package:flutter/material.dart';

import '/src/common/utils/extensions/context_extension.dart';
import 'auth_scope.dart';
import 'components/verification_field.dart';
// import 'auth_scope.dart';

///
class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  ///
  late final FocusNode verificationCodeFocusNode;
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    verificationCodeFocusNode = FocusNode();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    verificationCodeFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = AuthenticationScope.of(context);
    return Scaffold(
      backgroundColor: context.colorScheme.onBackground,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Подтверждение',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 16),
            VerificationCodeField(
              length: 4,
              onSubmit: () => print('Submitted'),
              controller: controller,
              onChange: (value) => _checkVerificationCode(value),
              focusNode: verificationCodeFocusNode,
            ),
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          auth.signInWithPhone(int.parse(controller.text));
        },
        label: const Text('Войти'),
      ),
    );
  }

  /// Phone number FocusNode condition.
  void _checkVerificationCode(String value) =>
      value.length == 4 ? verificationCodeFocusNode.unfocus() : null;
}
