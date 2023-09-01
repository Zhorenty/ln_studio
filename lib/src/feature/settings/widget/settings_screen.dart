import 'package:flutter/material.dart';

import '/src/common/utils/extensions/context_extension.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.colors.onBackground,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: CircleAvatar(
              backgroundColor: context.colors.primary,
              child: Icon(
                Icons.person,
                color: context.colors.onBackground,
              ),
            ),
          ),
        ],
      ),
      body: const Center(
        child: Text('Настройки'),
      ),
    );
  }
}
