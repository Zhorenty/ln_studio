import 'package:flutter/material.dart';
import 'package:ln_studio/src/common/assets/generated/fonts.gen.dart';

import '/src/common/utils/extensions/context_extension.dart';
import 'components/verification_field.dart';
import 'auth_scope.dart';

///
class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  ///
  late final TextEditingController verificationController;

  ///
  late final FocusNode verificationCodeFocusNode;

  @override
  void initState() {
    super.initState();
    verificationController = TextEditingController();
    verificationCodeFocusNode = FocusNode();
  }

  @override
  void dispose() {
    verificationController.dispose();
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
          children: [
            Text(
              'Подтверждение',
              style: context.textTheme.headlineLarge?.copyWith(
                fontFamily: FontFamily.geologica,
              ),
            ),
            const SizedBox(height: 16),
            VerificationCodeField(
              length: 4,
              controller: verificationController,
              focusNode: verificationCodeFocusNode,
              onSubmit: () => auth.signInWithPhone(
                int.parse(verificationController.text),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                child: Text(
                  'Получить новый код',
                  style: context.textTheme.titleSmall?.copyWith(
                    color: context.colorScheme.primary,
                    fontFamily: FontFamily.geologica,
                  ),
                ),
                onPressed: () {
                  /*
                  TODO: Implement resend code logic
                  Если нет аккаунта на сервере, то показываем показываем форму
                  регистрации (имя, номер телефона, почта)
                  */
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
