import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                return _DockItem(
                  index: index,
                  icon: items[index].$1,
                  title: items[index].$2,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _DockItem extends StatefulWidget {
  final int index;
  final IconData icon;
  final String title;

  const _DockItem({
    required this.index,
    required this.icon,
    required this.title,
  });

  @override
  State<_DockItem> createState() =>
      _DockItemState();
}

class _DockItemState extends State<_DockItem> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final provider =
        context.watch<RobotProvider>();

    final selected =
        provider.selectedTab == widget.index;

    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _pressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _pressed = false;
        });
      },
      onTapCancel: () {
        setState(() {
          _pressed = false;
        });
      },
      onTap: () {
        HapticFeedback.lightImpact();

        provider.setTab(widget.index);
      },
      child: AnimatedScale(
        scale: _pressed ? 0.92 : 1,
        duration: const Duration(
          milliseconds: 120,
        ),
        child: TweenAnimationBuilder<double>(
          duration: const Duration(
            milliseconds: 350,
          ),
          curve: Curves.easeOutBack,
          tween: Tween(
            begin: 1,
            end: selected ? 1.05 : 1,
          ),
          builder: (
            context,
            scale,
            child,
          ) {
            return Transform.scale(
              scale: scale,
              child: child,
            );
          },
          child: AnimatedContainer(
            duration: const Duration(
              milliseconds: 300,
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
            child: AnimatedSize(
              duration: const Duration(
                milliseconds: 250,
              ),
              curve: Curves.easeOutCubic,
              child: Row(
                mainAxisSize:
                    MainAxisSize.min,
                children: [
                  AnimatedScale(
                    scale:
                        selected ? 1.15 : 1,
                    duration:
                        const Duration(
                      milliseconds: 250,
                    ),
                    curve:
                        Curves.easeOutBack,
                    child: Icon(
                      widget.icon,
                      size: 22,
                      color: Colors.white,
                    ),
                  ),

                  if (selected) ...[
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      widget.title,
                      style:
                          const TextStyle(
                        color:
                            Colors.white,
                        fontWeight:
                            FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}