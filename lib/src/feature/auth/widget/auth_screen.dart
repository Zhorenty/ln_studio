import 'package:flutter/material.dart';
import 'package:ln_studio/src/common/utils/phone_input_formatter.dart';
import 'package:ln_studio/src/common/widget/whole_screen_loading_indicator.dart';

import '/src/common/assets/generated/assets.gen.dart';
import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/utils/extensions/context_extension.dart';
import '/src/common/widget/custom_text_field.dart';
import 'auth_scope.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  /// [FormState] for validating.
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController phoneController;

  ///
  late final FocusNode phoneFocusNode;

  bool visible = false;

  bool isAgree = false;

  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController();
    phoneFocusNode = FocusNode();
  }

  @override
  void dispose() {
    phoneController.dispose();
    phoneFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = AuthenticationScope.of(context);
    return Scaffold(
      backgroundColor: context.colorScheme.onBackground,
      body: WholeScreenLoadingIndicator(
        isLoading: auth.isProcessing,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 64),
                Assets.images.logoWhite.image(scale: 8),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Добро пожаловать',
                    style: context.textTheme.headlineMedium!.copyWith(
                      fontFamily: FontFamily.geologica,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: CustomTextField(
                    controller: phoneController,
                    focusNode: phoneFocusNode,
                    label: 'Укажите номер телефона',
                    labelStyle: context.textTheme.bodyMedium?.copyWith(
                      fontFamily: FontFamily.geologica,
                      color: context.colorScheme.primaryContainer,
                    ),
                    keyboardType: TextInputType.phone,
                    hintText: '8 (123) 456-78-90',
                    inputFormatters: [RuPhoneInputFormatter()],
                    validator: _phoneValidator,
                    onChanged: _checkPhoneNumber,
                  ),
                ),
                GestureDetector(
                  onTap: () => setState(() {
                    isAgree = !isAgree;
                    visible = !visible;
                  }),
                  child: Row(
                    children: [
                      Checkbox(
                        splashRadius: 0,
                        value: isAgree,
                        onChanged: (_) => setState(() {
                          isAgree = !isAgree;
                          visible = !visible;
                        }),
                      ),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(
                                text: 'Я соглашаюсь с ',
                              ),
                              TextSpan(
                                text: 'политикой конфиденциальности ',
                                style: context.textTheme.bodySmall?.copyWith(
                                  fontFamily: FontFamily.geologica,
                                  fontWeight: FontWeight.w300,
                                  shadows: [
                                    const Shadow(
                                      color: Colors.white,
                                      offset: Offset(0, -0.75),
                                    )
                                  ],
                                  color: Colors.transparent,
                                  decoration: TextDecoration.underline,
                                  decorationColor:
                                      context.colorScheme.secondary,
                                  decorationThickness: 1,
                                  decorationStyle: TextDecorationStyle.dashed,
                                ),
                              ),
                              const TextSpan(
                                text: 'и ',
                              ),
                              TextSpan(
                                text: 'условиями сервиса',
                                style: context.textTheme.bodySmall?.copyWith(
                                  fontFamily: FontFamily.geologica,
                                  fontWeight: FontWeight.w300,
                                  shadows: [
                                    const Shadow(
                                      color: Colors.white,
                                      offset: Offset(0, -0.75),
                                    )
                                  ],
                                  color: Colors.transparent,
                                  decoration: TextDecoration.underline,
                                  decorationColor:
                                      context.colorScheme.secondary,
                                  decorationThickness: 1,
                                  decorationStyle: TextDecorationStyle.dashed,
                                ),
                              ),
                            ],
                          ),
                          style: context.textTheme.bodySmall?.copyWith(
                            fontFamily: FontFamily.geologica,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Spacer(),
                AnimatedOpacity(
                  opacity: visible ? 1 : 0,
                  duration: const Duration(milliseconds: 300),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        fixedSize: Size(
                          MediaQuery.sizeOf(context).width - 50,
                          50,
                        ),
                        backgroundColor: context.colorScheme.primary,
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          auth.sendCode(phoneController.text);
                        }
                      },
                      child: Text(
                        'Продолжить',
                        style: context.textTheme.bodyLarge?.copyWith(
                          fontFamily: FontFamily.geologica,
                          color: context.colorScheme.onBackground,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Phone number [FocusNode] condition.
  void _checkPhoneNumber(String value) {
    if ((value.length == 18 && value.startsWith('+')) ||
        (value.length == 17 && value.startsWith('8'))) {
      phoneFocusNode.unfocus();
    }
  }

  /// Empty value validator.
  String? _phoneValidator(String? value) {
    if (value!.isEmpty) {
      return 'Обязательное поле';
    } else if ((value.length != 18 && value.startsWith('+')) ||
        (value.length != 17 && value.startsWith('8'))) {
      return 'Некорректный формат номера';
    }

    return null;
  }
}
