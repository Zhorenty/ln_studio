import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:ln_studio/src/common/assets/generated/fonts.gen.dart';
import 'package:ln_studio/src/common/utils/extensions/context_extension.dart';
import 'package:ln_studio/src/common/utils/extensions/date_time_extension.dart';
import 'package:ln_studio/src/common/widget/custom_text_field.dart';
import 'package:ln_studio/src/common/widget/date_picker_field.dart';
import 'package:ln_studio/src/feature/profile/bloc/profile/profile_bloc.dart';
import 'package:ln_studio/src/feature/profile/bloc/profile/profile_event.dart';
import 'package:ln_studio/src/feature/profile/bloc/profile/profile_state.dart';
import 'package:ln_studio/src/feature/profile/model/profile.dart';

///
class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  /// [FormState] for validating.
  final _formKey = GlobalKey<FormState>();

  late final ProfileBloc profileBloc;

  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _birthDateController;
  late final TextEditingController _emailController;

  late DateTime birthDate;

  @override
  void initState() {
    super.initState();
    profileBloc = context.read<ProfileBloc>()..add(const ProfileEvent.fetch());
    final profile = profileBloc.state.profile;

    _firstNameController =
        TextEditingController(text: profile?.firstName ?? '');
    _lastNameController = TextEditingController(text: profile?.lastName ?? '');
    _birthDateController =
        TextEditingController(text: profile?.birthDate.defaultFormat() ?? '');
    _emailController = TextEditingController(text: profile?.email ?? '');

    birthDate = profile?.birthDate ?? DateTime.now();
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
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state.isSuccessful) {
          _firstNameController.text = state.profile!.firstName;
          _lastNameController.text = state.profile!.lastName;
          _birthDateController.text = state.profile!.birthDate.defaultFormat();
          _emailController.text = state.profile!.email;

          birthDate = state.profile?.birthDate ?? DateTime.now();
        }

        return Scaffold(
          backgroundColor: context.colorScheme.onBackground,
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: ElevatedButton(
                  onPressed: () => _formKey.currentState!.validate()
                      ? editProfile(context)
                      : null,
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    backgroundColor: context.colorScheme.primary,
                    fixedSize: Size(
                      MediaQuery.sizeOf(context).width / 1.2,
                      50,
                    ),
                  ),
                  child: Text(
                    'Сохранить',
                    style: context.textTheme.bodyLarge?.copyWith(
                      fontFamily: FontFamily.geologica,
                      color: context.colorScheme.onBackground,
                    ),
                  ),
                )),
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
                          ),
                          CustomTextField(
                            controller: _lastNameController,
                            hintText: 'Фамилия',
                            validator: _emptyValidator,
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
                            onDateSelected: (date) {
                              birthDate = date;
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
      },
    );
  }

  void editProfile(BuildContext context) {
    context.read<ProfileBloc>().add(
          ProfileEvent.edit(
            profile: ProfileModel(
              id: profileBloc.state.profile!.id,
              firstName: _firstNameController.text,
              lastName: _lastNameController.text,
              birthDate: birthDate,
              email: _emailController.text,
            ),
          ),
        );
    if (context.read<ProfileBloc>().state.isSuccessful) {
      context.pop();
    }
  }

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
          color: context.colorScheme.primaryContainer,
        ),
      ),
    );
  }
}
