import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:ln_studio/src/common/assets/generated/fonts.gen.dart';
import 'package:ln_studio/src/common/utils/extensions/context_extension.dart';
import 'package:ln_studio/src/common/widget/avatar_widget.dart';
import 'package:ln_studio/src/common/widget/star_rating.dart';
import 'package:ln_studio/src/feature/home/widget/components/expanded_app_bar.dart';
import 'package:ln_studio/src/feature/record/model/employee.dart';

///
class EmployeeInfoScreen extends StatelessWidget {
  const EmployeeInfoScreen({super.key, required this.employee});

  ///
  final EmployeeModel employee;

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
                title: employee.fullName,
                subtitle: employee.jobModel.name,
                bottom: Text(
                  employee.fullName,
                  style: context.textTheme.titleLarge!.copyWith(
                    fontFamily: FontFamily.geologica,
                  ),
                ),
              ),
              CupertinoSliverRefreshControl(
                onRefresh: () async {
                  // TODO: Implement fetching by id.
                },
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
                          StarRating(initialRating: employee.stars),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${employee.userModel.firstName} является компетентным и опытным специалистом в области красоты и ухода за внешностью. Он обладает разносторонними знаниями и навыками, которые позволяют ему предоставить высококачественные услуги для клиентов.'
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
                      const ReviewContainer(title: 'Алевтина'),
                      const SizedBox(height: 8),
                      const ReviewContainer(title: 'Алексей'),
                      const SizedBox(height: 8),
                      const ReviewContainer(title: 'Ксения'),
                      const SizedBox(height: 8),
                      const ReviewContainer(title: 'Татьяна'),
                      SizedBox(height: MediaQuery.sizeOf(context).height / 10)
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
                  extra: employee,
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
  const ReviewContainer({super.key, required this.title});

  ///
  final String title;

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
                      text: 'Сегодня, 10:23',
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
            'Я очень довольна результатом работы с моими бровями! Они выглядят идеально – аккуратные, форма подходит идеально к моему лицу.',
            style: context.textTheme.bodyMedium?.copyWith(
              fontFamily: FontFamily.geologica,
            ),
          ),
        ],
      ),
    );
  }
}
