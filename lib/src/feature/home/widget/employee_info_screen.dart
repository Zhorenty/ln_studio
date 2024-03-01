import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:ln_studio/src/common/assets/generated/fonts.gen.dart';
import 'package:ln_studio/src/common/utils/extensions/context_extension.dart';
import 'package:ln_studio/src/common/widget/avatar_widget.dart';
import 'package:ln_studio/src/common/widget/star_rating.dart';
import 'package:ln_studio/src/feature/home/bloc/employee/employee_detail_bloc.dart';
import 'package:ln_studio/src/feature/home/bloc/employee/employee_detail_event.dart';
import 'package:ln_studio/src/feature/home/bloc/employee/employee_detail_state.dart';
import 'package:ln_studio/src/feature/home/widget/components/expanded_app_bar.dart';
import 'package:ln_studio/src/feature/initialization/widget/dependencies_scope.dart';
import 'package:ln_studio/src/feature/record/model/employee.dart';

import '../../../common/widget/information_widget.dart';

///
class EmployeeInfoScreen extends StatefulWidget {
  const EmployeeInfoScreen({super.key, required this.employee});

  ///
  final EmployeeModel employee;

  @override
  State<EmployeeInfoScreen> createState() => _EmployeeInfoScreenState();
}

class _EmployeeInfoScreenState extends State<EmployeeInfoScreen> {
  late final EmployeeDetailBLoC employeeDetailBLoC;

  @override
  void initState() {
    super.initState();
    employeeDetailBLoC = EmployeeDetailBLoC(
        repository: DependenciesScope.of(context).homeRepository)
      ..add(
        EmployeeDetailEvent.fetchReviews(widget.employee.id),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.background,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              ExpandedAppBar(
                onExit: context.pop,
                title: widget.employee.fullName,
                subtitle: widget.employee.jobModel.name,
                bottom: Text(
                  widget.employee.fullName,
                  style: context.textTheme.titleLarge!.copyWith(
                    fontFamily: FontFamily.geologica,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  decoration: BoxDecoration(
                    color: context.colorScheme.onBackground,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Рейтинг',
                            style: context.textTheme.titleLarge?.copyWith(
                              fontFamily: FontFamily.geologica,
                            ),
                          ),
                          StarRating(initialRating: widget.employee.stars),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.employee.description ??
                            '${widget.employee.userModel.firstName} является компетентным и опытным специалистом в области красоты и ухода за внешностью. Он обладает разносторонними знаниями и навыками, которые позволяют ему предоставить высококачественные услуги для клиентов.'
                                '\nИмеет богатый опыт работы с различными типами кожи, волос и ногтей, и способен справиться с любыми проблемами, связанными с уходом за ними.',
                        style: context.textTheme.bodyMedium?.copyWith(
                          fontFamily: FontFamily.geologica,
                          color: context.colorScheme.primaryContainer,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Отзывы',
                        style: context.textTheme.titleLarge?.copyWith(
                          fontFamily: FontFamily.geologica,
                        ),
                      ),
                      const SizedBox(height: 8),
                      BlocBuilder<EmployeeDetailBLoC, EmployeeDetailState>(
                        bloc: employeeDetailBLoC,
                        builder: (context, state) => state.reviews.isEmpty
                            ? InformationWidget.empty(
                                description: 'Отзывов пока нет',
                              )
                            : ListView.separated(
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.reviews.length,
                                itemBuilder: (context, index) {
                                  final review =
                                      employeeDetailBLoC.state.reviews[index];
                                  return ReviewContainer(
                                    title: 'Алевтина',
                                    createdAt: review.createdAt,
                                    text: review.text,
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 8),
                              ),
                      ),
                      const SizedBox(height: 8)
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 25,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: ElevatedButton(
                onPressed: () => context.goNamed(
                  'record',
                  extra: {'employeePreset': widget.employee},
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text(
                  'Записаться',
                  style: context.textTheme.bodyLarge?.copyWith(
                    fontFamily: FontFamily.geologica,
                    color: context.colorScheme.background,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

///
class ReviewContainer extends StatelessWidget {
  const ReviewContainer({
    super.key,
    required this.title,
    required this.createdAt,
    required this.text,
  });

  ///
  final String title;

  ///
  final String createdAt;

  ///
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.colorScheme.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF272727)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AvatarWidget(title: title),
              const SizedBox(width: 16),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '$title\n',
                      style: context.textTheme.bodyLarge?.copyWith(
                        fontFamily: FontFamily.geologica,
                      ),
                    ),
                    TextSpan(
                      text: createdAt,
                      style: context.textTheme.bodySmall?.copyWith(
                        fontFamily: FontFamily.geologica,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            text,
            style: context.textTheme.bodyMedium?.copyWith(
              fontFamily: FontFamily.geologica,
            ),
          ),
        ],
      ),
    );
  }
}
