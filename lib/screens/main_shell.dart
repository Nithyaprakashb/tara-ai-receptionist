import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/robot_provider.dart';

import '../screens/dashboard/dashboard_screen.dart';
import '../screens/expressions/expressions_screen.dart';
import '../screens/news/news_screen.dart';
import '../screens/announcements/announcements_screen.dart';
import '../screens/iot/iot_screen.dart';
import '../screens/settings/settings_screen.dart';

import '../widgets/tara_bottom_dock.dart';

import '../core/constants/app_colors.dart';

class MainShell extends StatelessWidget {
  const MainShell({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RobotProvider>();

    final screens = [
      const DashboardScreen(),
      const ExpressionsScreen(),
      const NewsScreen(),
      const AnnouncementsScreen(),
      const IoTScreen(),
      const SettingsScreen(),
    ];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: SafeArea(
          child: Stack(
            children: [
              AnimatedSwitcher(
                duration: const Duration(
                  milliseconds: 350,
                ),
                child: IndexedStack(
                  key: ValueKey(
                    provider.selectedTab,
                  ),
                  index: provider.selectedTab,
                  children: screens,
                ),
              ),

              const TaraBottomDock(),
            ],
          ),
        ),
      ),
    );
  }
}