import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:ln_studio/src/common/assets/generated/fonts.gen.dart';
import 'package:ln_studio/src/common/utils/extensions/context_extension.dart';
import 'package:ln_studio/src/common/widget/custom_text_field.dart';
import 'package:ln_studio/src/common/widget/date_picker_field.dart';

///
class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  /// [FormState] for validating.
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _birthDateController;
  late final TextEditingController _emailController;

  DateTime birthDate = DateTime.now();

  bool visible = false;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _birthDateController = TextEditingController();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _birthDateController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.onBackground,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: visible
              ? ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      /// TODO: implement bloc
                      // bloc.add.....
                      context.pop();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    backgroundColor: context.colorScheme.primary,
                    fixedSize: Size(MediaQuery.sizeOf(context).width / 1.2, 50),
                  ),
                  child: Text(
                    'Сохранить',
                    style: context.textTheme.bodyLarge?.copyWith(
                      fontFamily: FontFamily.geologica,
                      color: context.colorScheme.onBackground,
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                title: Text(
                  'О себе',
                  style: context.textTheme.titleLarge?.copyWith(
                    fontFamily: FontFamily.geologica,
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      const ProfileHeader(
                        title: 'Ваше имя и фамилия',
                        subtitle: 'Чтобы знать, как к Вам обращаться',
                      ),
                      CustomTextField(
                        controller: _firstNameController,
                        hintText: 'Имя',
                        validator: _emptyValidator,
                        onChanged: _onChanged,
                      ),
                      CustomTextField(
                        controller: _lastNameController,
                        hintText: 'Фамилия',
                        validator: _emptyValidator,
                        onChanged: _onChanged,
                      ),
                      const ProfileHeader(
                        title: 'Дата рождения',
                        subtitle: 'Чтобы предлагать Вам специальные скидки',
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
                          setState(() => visible = true);
                          birthDate = day;
                        },
                      ),
                      const ProfileHeader(
                        title: 'Почта',
                        subtitle:
                            'Чтобы присылать Вам информацию об акциях и скидках',
                      ),
                      CustomTextField(
                        controller: _emailController,
                        hintText: 'Электронная почта',
                        validator: _emailValidator,
                        onChanged: _onChanged,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///
  void _onChanged(String value) => setState(() => visible = true);

  /// Validate email address.
  String? _emailValidator(String? value) {
    final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    if (value!.isNotEmpty && !emailRegExp.hasMatch(value)) {
      return 'Введите корректный e-mail';
    } else {
      return null;
    }
  }

  /// Empty value validator.
  String? _emptyValidator(String? value) {
    if (value!.isEmpty) {
      return 'Обязательное поле';
    } else {
      return null;
    }
  }
}

///
class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key, required this.title, required this.subtitle});

  ///
  final String title;

  ///
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: context.textTheme.headlineSmall?.copyWith(
          fontSize: 25,
          fontFamily: FontFamily.geologica,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: context.textTheme.titleSmall?.copyWith(
            fontFamily: FontFamily.geologica,
            color: context.colorScheme.primaryContainer),
      ),
    );
  }
}
