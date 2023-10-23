import 'package:flutter/material.dart';
import 'package:ln_studio/src/feature/auth/model/user.dart';

import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/utils/extensions/context_extension.dart';
import '/src/common/widget/custom_text_field.dart';
import '/src/common/widget/date_picker_field.dart';
import 'auth_scope.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  /// [FormState] for validating.
  final _formKey = GlobalKey<FormState>();

  ///
  bool isAgree = false;

  ///
  bool visible = false;

  ///
  DateTime birthDate = DateTime.now();

  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _birthDateController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _birthDateController = TextEditingController();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _birthDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = AuthenticationScope.of(context);

    final labelStyle = context.textTheme.bodyLarge!.copyWith(
      color: context.colorScheme.primaryContainer,
      fontFamily: FontFamily.geologica,
    );

    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: context.colorScheme.onBackground,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: visible
                ? ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        auth.signUp(
                          user: User(
                            phone: auth.phone!,
                            firstName: _firstNameController.text,
                            lastName: _lastNameController.text,
                            birthDate: birthDate,
                            email: _emailController.text,
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      backgroundColor: context.colorScheme.primary,
                      fixedSize: Size(
                        MediaQuery.sizeOf(context).width / 1.2,
                        50,
                      ),
                    ),
                    child: Text(
                      'Зарегистрироваться',
                      style: context.textTheme.bodyLarge?.copyWith(
                        fontFamily: FontFamily.geologica,
                        color: context.colorScheme.onBackground,
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              title: Text(
                'Регистрация',
                style: context.textTheme.titleLarge?.copyWith(
                  fontFamily: FontFamily.geologica,
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverFillRemaining(
                child: Column(
                  children: [
                    CustomTextField(
                      controller: _firstNameController,
                      label: 'Имя',
                      labelStyle: labelStyle,
                    ),
                    CustomTextField(
                      controller: _lastNameController,
                      label: 'Фамилия',
                      labelStyle: labelStyle,
                    ),
                    CustomTextField(
                      controller: _emailController,
                      label: 'Электронная почта',
                      labelStyle: labelStyle,
                    ),
                    DatePickerField(
                      controller: _birthDateController,
                      initialDate: birthDate,
                      label: 'Дата рождения',
                      suffix: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: context.colorScheme.primary,
                      ),
                      onDateSelected: (day) {
                        birthDate = day;
                      },
                    ),
                    GestureDetector(
                      onTap: () => setState(() {
                        isAgree = !isAgree;
                        visible = true;
                      }),
                      child: Row(
                        children: [
                          Checkbox(
                            splashRadius: 0,
                            value: isAgree,
                            onChanged: (_) {},
                          ),
                          Expanded(
                            child: Text(
                              'Я соглашаюсь с политикой конфиденциальности и условиями сервиса',
                              style: context.textTheme.bodySmall?.copyWith(
                                fontFamily: FontFamily.geologica,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
