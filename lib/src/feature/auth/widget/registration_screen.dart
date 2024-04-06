import 'package:flutter/material.dart';
import 'package:ln_studio/src/feature/auth/model/user.dart';

import '/src/common/assets/generated/fonts.gen.dart';
import '/src/common/utils/extensions/context_extension.dart';
import '/src/common/widget/custom_text_field.dart';
import '/src/common/widget/date_picker_field.dart';
import 'auth_scope.dart';

///
class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  /// [FormState] for validating.
  final _formKey = GlobalKey<FormState>();

  ///
  DateTime birthDate = DateTime.now();

  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _birthDateController;

  late final FocusNode _firstNameFocusNode;
  late final FocusNode _lastNameFocusNode;
  late final FocusNode _emailFocusNode;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _birthDateController = TextEditingController();

    _firstNameFocusNode = FocusNode();
    _lastNameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _birthDateController.dispose();

    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    _emailFocusNode.dispose();
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
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
          child: ElevatedButton(
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
                      textInputAction: TextInputAction.next,
                      controller: _firstNameController,
                      focusNode: _firstNameFocusNode,
                      label: 'Имя',
                      labelStyle: labelStyle,
                      validator: _emptyValidator,
                      onTapOutside: (_) => _firstNameFocusNode.hasFocus
                          ? _firstNameFocusNode.unfocus()
                          : null,
                    ),
                    CustomTextField(
                      textInputAction: TextInputAction.next,
                      controller: _lastNameController,
                      focusNode: _lastNameFocusNode,
                      label: 'Фамилия',
                      labelStyle: labelStyle,
                      validator: _emptyValidator,
                      onTapOutside: (_) => _lastNameFocusNode.hasFocus
                          ? _lastNameFocusNode.unfocus()
                          : null,
                    ),
                    CustomTextField(
                      textInputAction: TextInputAction.done,
                      controller: _emailController,
                      focusNode: _emailFocusNode,
                      label: 'Электронная почта',
                      labelStyle: labelStyle,
                      validator: _emailValidator,
                      onTapOutside: (_) => _emailFocusNode.hasFocus
                          ? _emailFocusNode.unfocus()
                          : null,
                    ),
                    DatePickerField(
                      controller: _birthDateController,
                      initialDate: birthDate,
                      label: 'Дата рождения',
                      suffix: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: context.colorScheme.primary,
                      ),
                      onDateSelected: (day) => birthDate = day,
                      validator: _emptyValidator,
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

  /// Empty value validator.
  String? _emptyValidator(String? value) {
    if (value!.isEmpty) {
      return 'Обязательное поле';
    } else {
      return null;
    }
  }

  /// Validate email address.
  String? _emailValidator(String? value) {
    final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    if (value!.isEmpty) {
      return 'Обязательное поле';
    } else if (!emailRegExp.hasMatch(value)) {
      return 'Введите корректный e-mail';
    } else {
      return null;
    }
  }
}
