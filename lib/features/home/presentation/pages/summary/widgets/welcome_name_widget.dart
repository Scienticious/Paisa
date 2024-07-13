import 'package:flutter/material.dart';

import 'package:hive_flutter/adapters.dart';

import 'package:paisa/core/common.dart';
import 'package:paisa/core/common_enum.dart';
import 'package:paisa/features/profile/presentation/pages/paisa_user_widget.dart';
import 'package:paisa/main.dart';

class WelcomeNameWidget extends StatelessWidget {
  const WelcomeNameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box>(
      valueListenable: getIt
          .get<Box<dynamic>>(instanceName: BoxType.settings.name)
          .listenable(
        keys: [userNameSetKey],
      ),
      builder: (context, value, _) {
        final String name = value.get(userNameSetKey, defaultValue: 'Name');
        return ListTile(
          leading: const PaisaUserWidget(),
          title: Text(
            name,
            style: context.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: context.onBackground,
            ),
          ),
          subtitle: Text(
            context.loc.welcomeMessage,
            style: Theme.of(context)
                .textTheme
                .labelMedium
                ?.copyWith(color: context.bodySmall?.color),
          ),
        );
      },
    );
  }
}
