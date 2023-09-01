import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/src/common/utils/extensions/context_extension.dart';

///
class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar(this.navigationShell, {super.key});

  ///
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: navigationShell.goBranch,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: context.colors.onBackground,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded, color: context.colors.primary),
            activeIcon: CircleAvatar(
              radius: 20,
              backgroundColor: context.colors.primary,
              child: const Icon(Icons.home_rounded, color: Colors.black87),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_rounded, color: context.colors.primary),
            activeIcon: CircleAvatar(
              radius: 20,
              backgroundColor: context.colors.primary,
              child: const Icon(Icons.receipt_rounded, color: Colors.black87),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_rounded, color: context.colors.primary),
            activeIcon: CircleAvatar(
              radius: 20,
              backgroundColor: context.colors.primary,
              child: const Icon(Icons.settings, color: Colors.black87),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
