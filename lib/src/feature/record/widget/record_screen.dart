import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:ln_studio/src/common/assets/generated/fonts.gen.dart';
import 'package:ln_studio/src/common/utils/extensions/context_extension.dart';
import 'package:ln_studio/src/common/utils/extensions/date_time_extension.dart';
import 'package:ln_studio/src/common/widget/animated_button.dart';
import 'package:ln_studio/src/common/widget/custom_snackbar.dart';
import 'package:ln_studio/src/common/widget/field_button.dart';
import 'package:ln_studio/src/feature/auth/widget/auth_scope.dart';
import 'package:ln_studio/src/feature/initialization/widget/dependencies_scope.dart';
import 'package:ln_studio/src/feature/record/bloc/record/record_bloc.dart';
import 'package:ln_studio/src/feature/record/bloc/record/record_event.dart';
import 'package:ln_studio/src/feature/record/bloc/record/record_state.dart';
import 'package:ln_studio/src/feature/record/model/category.dart';
import 'package:ln_studio/src/feature/record/model/employee.dart';
import 'package:ln_studio/src/feature/record/model/timetable.dart';
import 'package:ln_studio/src/feature/salon/bloc/salon_bloc.dart';
import 'package:ln_studio/src/feature/salon/models/salon.dart';

typedef TimeblockWithDate = (EmployeeTimeblock$Response, String);

///
class RecordScreen extends StatefulWidget {
  const RecordScreen({
    super.key,
    this.recordId,
    this.servicePreset,
    this.employeePreset,
    this.datePreset,
    this.needReentry = false,
  });

  ///
  final int? recordId;

  ///
  final ServiceModel? servicePreset;

  ///
  final EmployeeModel? employeePreset;

  ///
  final TimeblockWithDate? datePreset;

  final bool needReentry;

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  ///
  late final RecordBLoC recordBLoC;

  /// [FormState] for validating.
  final _formKey = GlobalKey<FormState>();

  ///
  late final TextEditingController _servicesController;
  late final TextEditingController _employeeController;
  late final TextEditingController _dateController;
  late final TextEditingController _salonController;
  late final TextEditingController commentController;

  ///
  late final FocusNode commentFocusNode;

  int? recordId;
  ServiceModel? currentService;
  EmployeeModel? currentEmployee;
  TimeblockWithDate? currentDate;
  Salon? currentSalon;

  @override
  void initState() {
    super.initState();
    recordBLoC = RecordBLoC(
      repository: DependenciesScope.of(context).recordRepository,
    );

    if (widget.needReentry) {
      recordBLoC.add(RecordEvent.fetchLastBooking());
    }
    recordId = widget.recordId;
    currentService = widget.servicePreset;
    currentEmployee = widget.employeePreset;
    currentDate = widget.datePreset;

    _servicesController = TextEditingController();
    _employeeController = TextEditingController();
    _dateController = TextEditingController();
    _salonController = TextEditingController();
    commentController = TextEditingController();

    commentFocusNode = FocusNode();

    currentSalon = context.read<SalonBLoC>().state.currentSalon;
    _salonController.text = currentSalon?.name ?? '';
  }

  @override
  void didUpdateWidget(covariant RecordScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.servicePreset != null) {
      currentService = widget.servicePreset;
    } else if (widget.employeePreset != null) {
      currentEmployee = widget.employeePreset;
    } else if (widget.datePreset != null) {
      currentDate = widget.datePreset;
    }
  }

  @override
  void dispose() {
    commentController.dispose();
    _servicesController.dispose();
    _employeeController.dispose();
    _dateController.dispose();
    _salonController.dispose();
    commentFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _employeeController.text = currentEmployee?.fullName ?? '';

    _servicesController.text = currentService?.name ?? '';

    _dateController.text = currentDate != null
        ? '${DateTime.parse(currentDate!.$2).defaultFormat()}, '
            '${currentDate?.$1.time.substring(0, currentDate!.$1.time.length - 3)}'
        : '';

    final auth = AuthenticationScope.of(context);

    return Scaffold(
      backgroundColor: context.colorScheme.onBackground,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            title: Text(
              'Запись на маникюр',
              style: context.textTheme.titleLarge?.copyWith(
                fontFamily: FontFamily.geologica,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverToBoxAdapter(
              child: DefaultTextStyle(
                style: context.textTheme.titleMedium!.copyWith(
                  fontFamily: FontFamily.geologica,
                ),
                child: BlocConsumer<RecordBLoC, RecordState>(
                  listener: (context, state) => state.mapOrNull(
                    successful: (state) => context.goNamed('congratulation'),
                    error: (state) => CustomSnackBar.showError(context),
                  ),
                  bloc: recordBLoC,
                  builder: (context, state) {
                    if (state.lastBooking != null && widget.needReentry) {
                      currentService = state.lastBooking?.service;
                      currentEmployee = state.lastBooking?.employee;
                      currentSalon = state.lastBooking?.salon;

                      _servicesController.text =
                          state.lastBooking?.service.name ?? '';
                      _employeeController.text =
                          state.lastBooking?.employee.fullName ?? '';
                      _salonController.text =
                          state.lastBooking?.salon.name ?? '';
                      commentController.text = state.lastBooking?.comment ?? '';
                    }

                    return Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Выберите услугу'),
                          FieldButton(
                            controller: _servicesController,
                            deletable: true,
                            hintText: 'Выберите услугу',
                            onSuffixPressed: () => setState(
                              () => currentService = null,
                            ),
                            onTap: () => context.goNamed(
                              'choice_service_from_record',
                              extra: currentService,
                              queryParameters: {
                                'salon_id': currentSalon!.id.toString(),
                                if (currentEmployee != null)
                                  'employee_id': currentEmployee?.id.toString(),
                                if (currentDate != null)
                                  'timeblock_id': currentDate?.$1.id.toString(),
                                if (currentDate != null)
                                  'date_at': currentDate!.$2.toString(),
                              },
                            ),
                            validator: _emptyServiceValidator,
                          ),
                          const Text('Выберите мастера'),
                          FieldButton(
                            controller: _employeeController,
                            deletable: true,
                            hintText: 'Выберите мастера',
                            onSuffixPressed: () => setState(
                              () => currentEmployee = null,
                            ),
                            onTap: () => context.goNamed(
                              'choice_employee_from_record',
                              extra: currentEmployee,
                              queryParameters: {
                                'salon_id': currentSalon!.id.toString(),
                                if (currentService != null)
                                  'service_id': currentService?.id.toString(),
                                if (currentDate != null)
                                  'timeblock_id': currentDate?.$1.id.toString(),
                                if (currentDate != null)
                                  'date_at': currentDate!.$2.toString(),
                              },
                            ),
                            validator: _emptyEmployeeValidator,
                          ),
                          const Text('Выберите дату и время'),
                          FieldButton(
                            controller: _dateController,
                            deletable: true,
                            hintText: 'Выберите дату и время',
                            onSuffixPressed: () => setState(
                              () => currentDate = null,
                            ),
                            onTap: () => context.goNamed(
                              'choice_date_from_record',
                              extra: currentDate,
                              queryParameters: {
                                'salon_id': currentSalon!.id.toString(),
                                if (currentService != null)
                                  'service_id': currentService?.id.toString(),
                                if (currentEmployee != null)
                                  'employee_id': currentEmployee?.id.toString(),
                              },
                            ),
                            validator: _emptyDateValidator,
                          ),
                          const Text('Филиал'),
                          FieldButton(
                            controller: _salonController,
                            hintText: 'Выберите филиал на главном экране',
                            validator: _emptySalonValidator,
                          ),
                          const Text('Комментарий к записи'),
                          HugeTextField(
                            controller: commentController,
                            focusNode: commentFocusNode,
                          ),
                          currentService?.price != null
                              ? Text('Стоимость: ${currentService?.price} ₽')
                              : const SizedBox.shrink(),
                          const SizedBox(height: 16),
                          AnimatedButton(
                            onPressed: () {
                              // TODO: Сделать валидацию
                              // TODO: Wait until asset in
                              //  CongratilationScreen was loaded.
                              if (_formKey.currentState!.validate()) {
                                // TODO: Временно, убрать после теста
                                recordBLoC.add(
                                  RecordEvent.create(
                                    recordId: recordId,
                                    dateAt: currentDate!.$2,
                                    salonId: currentSalon?.id ?? 1,
                                    clientId: auth.user?.id ?? 1,
                                    serviceId: currentService!.id,
                                    employeeId: currentEmployee!.id,
                                    timeblockId: currentDate!.$1.id,
                                    price: currentService!.price,
                                    comment: commentController.text,
                                  ),
                                );
                              }
                            },
                            child: Container(
                              height: 48,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 12,
                              ),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: context.colorScheme.primary,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(
                                'Записаться',
                                style: context.textTheme.bodyLarge?.copyWith(
                                  color: context.colorScheme.onBackground,
                                  fontFamily: FontFamily.geologica,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  /// Empty value validator.
  String? _emptyServiceValidator(String? value) =>
      value!.isEmpty ? 'Пожалуйста, выберите услугу' : null;

  /// Empty value validator.
  String? _emptyEmployeeValidator(String? value) =>
      value!.isEmpty ? 'Пожалуйста, выберите мастера' : null;

  /// Empty value validator.
  String? _emptyDateValidator(String? value) =>
      value!.isEmpty ? 'Пожалуйста, выберите дату' : null;

  /// Empty value validator.
  String? _emptySalonValidator(String? value) =>
      value!.isEmpty ? 'Выберите филиал на главном экране' : null;
}

/// Large text field for comments.
class HugeTextField extends StatelessWidget {
  const HugeTextField({super.key, this.controller, this.focusNode});

  ///
  final TextEditingController? controller;

  ///
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      alignment: Alignment.topCenter,
      duration: const Duration(milliseconds: 300),
      child: Container(
        margin: const EdgeInsets.only(top: 8, bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: context.colorScheme.background,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF272727)),
        ),
        child: TextFormField(
          onTapOutside: (_) =>
              focusNode!.hasFocus ? focusNode?.unfocus() : null,
          controller: controller,
          focusNode: focusNode,
          maxLines: null,
          keyboardType: TextInputType.multiline,
          style: context.textTheme.bodyLarge!.copyWith(
            fontFamily: FontFamily.geologica,
            letterSpacing: 0.5,
          ),
          decoration: InputDecoration(
            isDense: true,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: context.colorScheme.scrim,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: context.colorScheme.scrim),
            ),
          ),
        ),
      ),
    );
  }
}
