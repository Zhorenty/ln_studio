import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:ln_studio/src/common/assets/generated/fonts.gen.dart';
import 'package:ln_studio/src/common/utils/extensions/context_extension.dart';
import 'package:ln_studio/src/common/widget/animated_button.dart';
import 'package:ln_studio/src/common/widget/custom_snackbar.dart';
import 'package:ln_studio/src/common/widget/shimmer.dart';
import 'package:ln_studio/src/feature/initialization/widget/dependencies_scope.dart';
import 'package:ln_studio/src/feature/record/bloc/category/category_bloc.dart';
import 'package:ln_studio/src/feature/record/bloc/category/category_event.dart';
import 'package:ln_studio/src/feature/record/bloc/category/category_state.dart';
import 'package:ln_studio/src/feature/record/model/category.dart';
import 'package:ln_studio/src/feature/record/widget/components/continue_button.dart';
import 'package:ln_studio/src/feature/salon/bloc/salon_bloc.dart';

///
class ServiceChoiceScreen extends StatefulWidget {
  const ServiceChoiceScreen({
    super.key,
    this.servicePreset,
    this.salonId,
    this.employeeId,
    this.timetableItemId,
    this.dateAt,
  });

  final ServiceModel? servicePreset;
  final int? salonId;
  final int? employeeId;
  final int? timetableItemId;
  final String? dateAt;

  @override
  State<ServiceChoiceScreen> createState() => _ServiceChoiceScreenState();
}

class _ServiceChoiceScreenState extends State<ServiceChoiceScreen> {
  ///
  ServiceModel? selectedService;

  ///
  bool visible = false;

  late final CategoryBloc categoryBloc;

  @override
  void initState() {
    super.initState();
    selectedService = widget.servicePreset;
    categoryBloc = CategoryBloc(
      repository: DependenciesScope.of(context).recordRepository,
    );
    _fetchServices();
  }

  Future<void> _onRefresh() async {
    final stream = categoryBloc.stream.first;
    _fetchServices();
    await stream;
  }

  void _fetchServices() => categoryBloc.add(
        CategoryEvent.fetchServiceCategories(
          salonId: widget.salonId ??
              context.read<SalonBLoC>().state.currentSalon?.id ??
              1,
          employeeId: widget.employeeId,
          timetableItemId: widget.timetableItemId,
          dateAt: widget.dateAt,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => categoryBloc,
      child: Scaffold(
        backgroundColor: context.colorScheme.onBackground,
        body: BlocConsumer<CategoryBloc, CategoryState>(
          listener: (context, state) {
            if (state.hasError) {
              CustomSnackBar.showError(context, message: state.error);
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                RefreshIndicator.adaptive(
                  onRefresh: _onRefresh,
                  edgeOffset: 100,
                  child: CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        backgroundColor: context.colorScheme.onBackground,
                        pinned: true,
                        title: Text(
                          'Выбор услуги',
                          style: context.textTheme.titleLarge!.copyWith(
                            fontFamily: FontFamily.geologica,
                          ),
                        ),
                        leading: AnimatedButton(
                          child: const Icon(Icons.arrow_back_ios_new_rounded),
                          onPressed: () => context.pop(),
                        ),
                      ),
                      SliverAnimatedOpacity(
                        opacity: state.hasCategory ? 1 : .5,
                        duration: const Duration(milliseconds: 400),
                        sliver: state.hasCategory
                            ? SliverList.builder(
                                itemCount: state.categoryWithServices.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 8,
                                    ),
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                          color: Color(0xFF272727),
                                        ),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      clipBehavior: Clip.antiAlias,
                                      margin: EdgeInsets.zero,
                                      child: ExpansionTile(
                                        backgroundColor:
                                            context.colorScheme.background,
                                        collapsedBackgroundColor:
                                            context.colorScheme.background,
                                        title: Text(
                                          state
                                              .categoryWithServices[index].name,
                                          style: context.textTheme.bodyLarge
                                              ?.copyWith(
                                            fontFamily: FontFamily.geologica,
                                          ),
                                        ),
                                        children: [
                                          ...state.categoryWithServices[index]
                                              .service
                                              .map(
                                            (service) => ServiceCard(
                                              service: service,
                                              selectedService: selectedService,
                                              onTap: (cardService) => setState(
                                                () {
                                                  selectedService = cardService;
                                                  visible = true;
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              )
                            : SliverPadding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 16,
                                ),
                                sliver: SliverList.separated(
                                  itemCount: 5,
                                  itemBuilder: (context, index) =>
                                      const SkeletonServiceCard(),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(height: 16),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: MediaQuery.of(context).size.height / 20,
                  left: 0,
                  right: 0,
                  child: ContinueButton(
                    visible: visible,
                    onPressed: () => context.goNamed(
                      'record',
                      extra: {'servicePreset': selectedService},
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class SkeletonServiceCard extends StatelessWidget {
  const SkeletonServiceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF272727),
        ),
      ),
      child: const Shimmer(
        size: Size(double.infinity, 57),
        cornerRadius: 16,
      ),
    );
  }
}

///
class ServiceCard extends StatefulWidget {
  const ServiceCard({
    super.key,
    required this.service,
    required this.selectedService,
    required this.onTap,
  });

  ///
  final ServiceModel service;

  ///
  final ServiceModel? selectedService;

  ///
  final void Function(ServiceModel?) onTap;

  @override
  State<ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  ///
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onTap(widget.service),
      child: Container(
        decoration: BoxDecoration(color: context.colorScheme.background),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8).add(
          const EdgeInsets.only(right: 16),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Radio<ServiceModel>(
                  value: widget.service,
                  groupValue: widget.selectedService,
                  onChanged: widget.onTap,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.service.name,
                        style: context.textTheme.titleMedium?.copyWith(
                          fontFamily: FontFamily.geologica,
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Стоимость: ',
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: context.colorScheme.primaryContainer,
                                fontFamily: FontFamily.geologica,
                              ),
                            ),
                            TextSpan(
                              text: widget.service.price.toString(),
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: context.colorScheme.secondary,
                                fontFamily: FontFamily.geologica,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                AnimatedButton(
                  padding: const EdgeInsets.only(right: 4, top: 2),
                  onPressed: () => setState(() => expanded = !expanded),
                  child: const Icon(Icons.info_outline, size: 20),
                ),
              ],
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 750),
              curve: Curves.linearToEaseOut,
              alignment: Alignment.topCenter,
              clipBehavior: Clip.none,
              child: expanded
                  ? Padding(
                      padding: const EdgeInsets.only(top: 4, left: 10),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: widget.service.description,
                              style: context.textTheme.bodyMedium!.copyWith(
                                fontFamily: FontFamily.geologica,
                                // color: context.colorScheme.primaryContainer,
                              ),
                            ),
                            TextSpan(
                              text: '\nДлительность процедуры: '
                                  '${widget.service.duration} минут',
                              style: context.textTheme.bodyMedium!.copyWith(
                                fontFamily: FontFamily.geologica,
                                // color: context.colorScheme.primaryContainer,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
