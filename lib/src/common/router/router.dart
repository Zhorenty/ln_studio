import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ln_studio/src/feature/auth/widget/auth_screen.dart';
import 'package:ln_studio/src/feature/auth/widget/registration_screen.dart';
import 'package:ln_studio/src/feature/auth/widget/verification_screen.dart';
import 'package:ln_studio/src/feature/home/model/news.dart';
import 'package:ln_studio/src/feature/home/widget/employee_info_screen.dart';
import 'package:ln_studio/src/feature/home/widget/news_screen.dart';
import 'package:ln_studio/src/feature/profile/widget/booking_history_screen.dart';
import 'package:ln_studio/src/feature/profile/widget/discounts_screen.dart';
import 'package:ln_studio/src/feature/profile/widget/edit_profile_screen.dart';
import 'package:ln_studio/src/feature/profile/widget/notifications_screen.dart';
import 'package:ln_studio/src/feature/profile/widget/payment_screen.dart';
import 'package:ln_studio/src/feature/record/model/category.dart';
import 'package:ln_studio/src/feature/record/model/employee.dart';
import 'package:ln_studio/src/feature/record/widget/congratulation_screen.dart';
import 'package:ln_studio/src/feature/record/widget/date_choice_screen.dart';
import 'package:ln_studio/src/feature/record/widget/employee_choice_screen.dart';
import 'package:ln_studio/src/feature/record/widget/record_screen.dart';
import 'package:ln_studio/src/feature/record/widget/sevice_choice_screen.dart';
import 'package:ln_studio/src/feature/salon/bloc/salon_bloc.dart';
import 'package:ln_studio/src/feature/salon/models/salon.dart';
import 'package:ln_studio/src/feature/salon/widget/salon_choice_screen.dart';
import 'package:ln_studio/src/feature/store/widget/store_screen.dart';

import '/src/common/widget/custom_bottom_navigation_bar.dart';
import '/src/feature/home/widget/home_screen.dart';
import '/src/feature/profile/widget/profile_screen.dart';

final _parentKey = GlobalKey<NavigatorState>();

/// Router of this application.
final router = GoRouter(
  initialLocation: '/auth',
  navigatorKey: _parentKey,
  routes: [
    GoRoute(
      name: 'auth',
      path: '/auth',
      builder: (context, state) => const AuthScreen(),
      routes: [
        GoRoute(
          name: 'verify',
          path: 'verify',
          builder: (context, state) => const VerificationScreen(),
          routes: [
            GoRoute(
              name: 'register',
              path: 'register',
              builder: (context, state) => const RegistrationScreen(),
            ),
          ],
        ),
      ],
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => CustomBottomNavigationBar(
        navigationShell,
      ),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              name: 'home',
              builder: (context, state) => const HomeScreen(),
              routes: [
                GoRoute(
                  name: 'employee_info',
                  path: 'employee',
                  parentNavigatorKey: _parentKey,
                  builder: (context, state) => EmployeeInfoScreen(
                    employee: state.extra as EmployeeModel,
                  ),
                ),
                GoRoute(
                  name: 'news',
                  path: 'news',
                  parentNavigatorKey: _parentKey,
                  builder: (context, state) => NewsScreen(
                    news: state.extra as NewsModel,
                  ),
                ),
                GoRoute(
                  name: 'salon_choice_from_home',
                  path: 'salon_choice',
                  parentNavigatorKey: _parentKey,
                  builder: (context, state) => SalonChoiceScreen(
                    currentSalon: state.extra as Salon?,
                  ),
                ),
                GoRoute(
                  name: 'choice_service',
                  path: 'choice_service',
                  parentNavigatorKey: _parentKey,
                  builder: (context, state) => ServiceChoiceScreen(
                    salonId:
                        context.read<SalonBLoC>().state.currentSalon?.id ?? 1,
                  ),
                ),
                GoRoute(
                  name: 'choice_employee',
                  path: 'choice_employee',
                  parentNavigatorKey: _parentKey,
                  builder: (context, state) => EmployeeChoiceScreen(
                    salonId:
                        context.read<SalonBLoC>().state.currentSalon?.id ?? 1,
                  ),
                ),
                GoRoute(
                  name: 'choice_date',
                  path: 'choice_date',
                  parentNavigatorKey: _parentKey,
                  builder: (context, state) => DateChoiceScreen(
                    // TODO: Брать дату пресет из extra
                    salonId:
                        context.read<SalonBLoC>().state.currentSalon?.id ?? 1,
                  ),
                ),
                _recordRoute,
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/store',
              builder: (context, state) => const StoreScreen(),
              routes: [
                GoRoute(
                  name: 'salon_choice_from_store',
                  path: 'salon_choice',
                  parentNavigatorKey: _parentKey,
                  builder: (context, state) => SalonChoiceScreen(
                    currentSalon: state.extra as Salon?,
                  ),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfileScreen(),
              routes: [
                GoRoute(
                  path: 'edit',
                  name: 'profile_edit',
                  parentNavigatorKey: _parentKey,
                  builder: (context, state) => const EditProfileScreen(),
                ),
                GoRoute(
                  path: 'booking_history',
                  name: 'booking_history',
                  parentNavigatorKey: _parentKey,
                  builder: (context, state) => const BookingHistoryScreen(),
                  // routes: [_recordRoute],
                ),
                GoRoute(
                  path: 'notifications',
                  name: 'notifications',
                  parentNavigatorKey: _parentKey,
                  builder: (context, state) => const NotificationsScreen(),
                ),
                GoRoute(
                  path: 'discounts',
                  name: 'discounts',
                  parentNavigatorKey: _parentKey,
                  builder: (context, state) => const DiscountsScreen(),
                ),
                GoRoute(
                  path: 'payment',
                  name: 'payment',
                  parentNavigatorKey: _parentKey,
                  builder: (context, state) => const PaymentScreen(),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);

final _recordRoute = GoRoute(
  name: 'record',
  path: 'record',
  parentNavigatorKey: _parentKey,
  builder: (context, state) {
    Map<String, dynamic>? map;
    if (state.extra is Map<String, dynamic>) {
      map = state.extra as Map<String, dynamic>;
    }
    return RecordScreen(
      servicePreset: map?['servicePreset'],
      employeePreset: map?['employeePreset'],
      datePreset: map?['datePreset'],
      needReentry:
          bool.tryParse(state.uri.queryParameters['needReentry'].toString()) ??
              false,
      recordId: map?['recordId'],
    );
  },
  routes: [
    GoRoute(
      name: 'choice_service_from_record',
      path: 'choice_service',
      parentNavigatorKey: _parentKey,
      builder: (context, state) {
        final salonId = context.read<SalonBLoC>().state.currentSalon?.id;
        return ServiceChoiceScreen(
          servicePreset: state.extra as ServiceModel?,
          salonId: salonId,
          employeeId: int.tryParse(
            state.uri.queryParameters['employee_id'] ?? '',
          ),
          timetableItemId: int.tryParse(
            state.uri.queryParameters['timeblock_id'] ?? '',
          ),
          dateAt: state.uri.queryParameters['date_at'],
        );
      },
    ),
    GoRoute(
      name: 'choice_employee_from_record',
      path: 'choice_employee',
      parentNavigatorKey: _parentKey,
      builder: (context, state) => EmployeeChoiceScreen(
        employeePreset: state.extra as EmployeeModel?,
        salonId: context.read<SalonBLoC>().state.currentSalon?.id ?? 1,
        serviceId: int.tryParse(
          state.uri.queryParameters['service_id'] ?? '',
        ),
        timeblockId: int.tryParse(
          state.uri.queryParameters['timeblock_id'] ?? '',
        ),
        dateAt: state.uri.queryParameters['date_at'],
      ),
    ),
    GoRoute(
      name: 'choice_date_from_record',
      path: 'choice_date',
      parentNavigatorKey: _parentKey,
      builder: (context, state) => DateChoiceScreen(
        // TODO: Брать дату пресет из extra
        salonId: context.read<SalonBLoC>().state.currentSalon?.id ?? 1,
        serviceId: int.tryParse(
          state.uri.queryParameters['service_id'] ?? '',
        ),
        employeeId: int.tryParse(
          state.uri.queryParameters['employee_id'] ?? '',
        ),
      ),
    ),
    GoRoute(
      name: 'congratulation',
      path: 'congratulation',
      parentNavigatorKey: _parentKey,
      builder: (context, state) => CongratulationScreen(
        url: state.uri.queryParameters['url'] ?? '',
      ),
    ),
  ],
);
