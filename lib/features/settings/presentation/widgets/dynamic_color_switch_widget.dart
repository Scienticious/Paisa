import 'package:flutter/material.dart';

import 'package:paisa/config/routes.dart';
import 'package:paisa/core/common.dart';
import 'package:paisa/features/settings/presentation/widgets/setting_option.dart';

class DynamicColorSwitchWidget extends StatelessWidget {
  const DynamicColorSwitchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return SettingsOption(
          title: context.loc.dynamicColor,
          trailing: Switch(
            activeColor: context.primary,
            value: settings.get(
              dynamicThemeKey,
              defaultValue: false,
            ),
            onChanged: (value) {
              settings.put(dynamicThemeKey, value);
              setState(() {});
            },
          ),
        );
      },
    );
  }
}
