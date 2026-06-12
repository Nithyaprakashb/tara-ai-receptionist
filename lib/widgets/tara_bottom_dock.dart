import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/robot_provider.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_sizes.dart';

class TaraBottomDock extends StatelessWidget {
  const TaraBottomDock({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RobotProvider>();

    final items = [
      (Icons.home_rounded, 'Dashboard'),
      (Icons.sentiment_satisfied_alt_rounded, 'Expressions'),
      (Icons.newspaper_rounded, 'News'),
      (Icons.campaign_rounded, 'Announcements'),
      (Icons.memory_rounded, 'IoT'),
      (Icons.settings_rounded, 'Settings'),
    ];

    return Positioned(
      left: 16,
      right: 16,
      bottom: 20,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          AppSizes.radiusLarge,
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 20,
            sigmaY: 20,
          ),
          child: Container(
            height: 76,
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: AppColors.glass,
              borderRadius: BorderRadius.circular(
                AppSizes.radiusLarge,
              ),
              border: Border.all(
                color: AppColors.glassBorder,
              ),
            ),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              itemBuilder: (context, index) {
                final selected =
                    provider.selectedTab == index;

                return GestureDetector(
                  onTap: () {
                    provider.setTab(index);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(
                      milliseconds: 250,
                    ),
                    curve: Curves.easeOutCubic,
                    margin:
                        const EdgeInsets.symmetric(
                      horizontal: 4,
                    ),
                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(28),
                      gradient: selected
                          ? AppColors.primaryGradient
                          : null,
                      color: selected
                          ? null
                          : Colors.transparent,
                    ),
                    child: Row(
                      mainAxisSize:
                          MainAxisSize.min,
                      children: [
                        AnimatedScale(
                          scale:
                              selected ? 1.1 : 1,
                          duration:
                              const Duration(
                            milliseconds: 250,
                          ),
                          child: Icon(
                            items[index].$1,
                            size: 22,
                            color: Colors.white,
                          ),
                        ),
                        if (selected) ...[
                          const SizedBox(width: 8),
                          Text(
                            items[index].$2,
                            style:
                                const TextStyle(
                              color: Colors.white,
                              fontWeight:
                                  FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}