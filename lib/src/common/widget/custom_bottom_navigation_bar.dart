import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/src/common/utils/extensions/context_extension.dart';
import '/src/common/widget/animated_button.dart';

/// Custom-styled [BottomNavigationBar].
class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar(this.navigationShell, {super.key});

  /// Widget for managing the state of a [StatefulShellRoute].
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(context) {
    return Scaffold(
      extendBody: true,
      body: navigationShell,
      bottomNavigationBar: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Opacity(
            opacity: 0.95,
            child: BottomNavigationBar(
              currentIndex: navigationShell.currentIndex,
              onTap: navigationShell.goBranch,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              backgroundColor: context.colorScheme.onBackground,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: const AnimatedButton(
                    child: Icon(
                      Icons.home_outlined,
                      color: Color(0xFF828282),
                      size: 28,
                    ),
                  ),
                  activeIcon: AnimatedButton(
                    child: Icon(
                      Icons.home_rounded,
                      color: context.colorScheme.primary,
                      size: 28,
                    ),
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: const AnimatedButton(
                    child: Icon(
                      Icons.qr_code_outlined,
                      color: Color(0xFF828282),
                      size: 28,
                    ),
                  ),
                  activeIcon: AnimatedButton(
                    child: Icon(
                      Icons.qr_code_rounded,
                      color: context.colorScheme.primary,
                      size: 28,
                    ),
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: const AnimatedButton(
                    child: Icon(
                      Icons.person_outlined,
                      color: Color(0xFF828282),
                      size: 28,
                    ),
                  ),
                  activeIcon: AnimatedButton(
                    child: Icon(
                      Icons.person_rounded,
                      color: context.colorScheme.primary,
                      size: 28,
                    ),
                  ),
                  label: '',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
