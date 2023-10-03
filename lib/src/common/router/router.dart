import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ln_studio/src/feature/profile/widget/booking_history_screen.dart';
import 'package:ln_studio/src/feature/profile/widget/edit_profile_screen.dart';
import 'package:ln_studio/src/feature/record/model/category.dart';
import 'package:ln_studio/src/feature/record/model/employee.dart';
import 'package:ln_studio/src/feature/record/widget/congratulation_screen.dart';
import 'package:ln_studio/src/feature/record/widget/date_choice_screen.dart';
import 'package:ln_studio/src/feature/record/widget/employee_choice_screen.dart';
import 'package:ln_studio/src/feature/record/widget/record_screen.dart';
import 'package:ln_studio/src/feature/record/widget/sevice_choice_screen.dart';
import 'package:ln_studio/src/feature/salon/models/salon.dart';
import 'package:ln_studio/src/feature/salon/widget/salon_choice_screen.dart';

import '/src/common/widget/custom_bottom_navigation_bar.dart';
import '/src/feature/qr_code/widget/qr_code_screen.dart';
import '/src/feature/home/widget/home_screen.dart';
import '/src/feature/profile/widget/profile_screen.dart';

final _parentKey = GlobalKey<NavigatorState>();

/// Router of this application.
final router = GoRouter(
  initialLocation: '/home',
  navigatorKey: _parentKey,
  routes: [
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
                  name: 'salon_choice',
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
                    salonId: int.parse(
                      state.uri.queryParameters['salon_id']!,
                    ),
                  ),
                ),
                GoRoute(
                  name: 'choice_employee',
                  path: 'choice_employee',
                  parentNavigatorKey: _parentKey,
                  builder: (context, state) => EmployeeChoiceScreen(
                    salonId: int.parse(
                      state.uri.queryParameters['salon_id']!,
                    ),
                  ),
                ),
                GoRoute(
                  name: 'choice_date',
                  path: 'choice_date',
                  parentNavigatorKey: _parentKey,
                  builder: (context, state) => DateChoiceScreen(
                    // TODO: Брать дату пресет из extra
                    salonId: int.parse(
                      state.uri.queryParameters['salon_id']!,
                    ),
                  ),
                ),
                GoRoute(
                  name: 'record',
                  path: 'record',
                  parentNavigatorKey: _parentKey,
                  builder: (context, state) => RecordScreen(
                    servicePreset: state.extra is ServiceModel
                        ? state.extra as ServiceModel
                        : null,
                    employeePreset: state.extra is EmployeeModel
                        ? state.extra as EmployeeModel
                        : null,
                    datePreset: state.extra is TimeblockWithDate
                        ? state.extra as TimeblockWithDate
                        : null,
                  ),
                  routes: [
                    GoRoute(
                      name: 'choice_service_from_record',
                      path: 'choice_service',
                      parentNavigatorKey: _parentKey,
                      builder: (context, state) {
                        return ServiceChoiceScreen(
                          servicePreset: state.extra as ServiceModel?,
                          salonId: int.parse(
                            state.uri.queryParameters['salon_id']!,
                          ),
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
                        salonId: int.parse(
                          state.uri.queryParameters['salon_id']!,
                        ),
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
                        salonId: int.parse(
                          state.uri.queryParameters['salon_id']!,
                        ),
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
                      builder: (context, state) => const CongratulationScreen(),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/qr_code',
              builder: (context, state) => const QRCodeScreen(),
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
                  path: 'booking_history',
                  name: 'booking_history',
                  parentNavigatorKey: _parentKey,
                  builder: (context, state) => const BookingHistoryScreen(),
                ),
                GoRoute(
                  path: 'edit',
                  name: 'profile_edit',
                  parentNavigatorKey: _parentKey,
                  builder: (context, state) => const EditProfileScreen(),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
