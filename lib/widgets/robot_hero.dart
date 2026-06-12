import 'package:flutter/material.dart';

import '../core/constants/app_sizes.dart';

class RobotHero extends StatelessWidget {
  const RobotHero({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Hero(
          tag: 'tara_robot',
          child: SizedBox(
            height: AppSizes.heroRobotHeight,
            child: Image.asset(
              'assets/images/tara_robot.png',
              fit: BoxFit.contain,
              errorBuilder: (
                context,
                error,
                stackTrace,
              ) {
                return const Icon(
                  Icons.smart_toy_rounded,
                  size: 220,
                  color: Colors.white,
                );
              },
            ),
          ),
        ),

        const SizedBox(height: 12),

        const Text(
          'TARA',
          style: TextStyle(
            color: Colors.white,
            fontSize: 34,
            fontWeight: FontWeight.w800,
            letterSpacing: -1,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          'AI Reception Assistant',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white.withOpacity(
              0.75,
            ),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(height: 6),

        Text(
          'Ready to welcome visitors and assist with information.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white.withOpacity(
              0.55,
            ),
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}