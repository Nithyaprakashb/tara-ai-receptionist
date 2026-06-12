import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';

import 'providers/robot_provider.dart';

import 'screens/main_shell.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RobotProvider(),
        ),
      ],
      child: const TaraApp(),
    ),
  );
}

class TaraApp extends StatelessWidget {
  const TaraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TARA AI Receptionist',
      debugShowCheckedModeBanner: false,

      theme: AppTheme.darkTheme,

      home: const MainShell(),
    );
  }
}