import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../providers/robot_provider.dart';
import '../../services/bluetooth_service.dart';

import '../../core/constants/app_sizes.dart';

import '../../widgets/glass_card.dart';
import '../../widgets/section_header.dart';

class ExpressionsScreen extends StatelessWidget {
  const ExpressionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final robot = context.watch<RobotProvider>();

    final expressions = [
      ('HAPPY', 'assets/expressions/happy.png'),
      ('LISTENING', 'assets/expressions/listening.png'),
      ('THINKING', 'assets/expressions/thinking.png'),
      ('TALKING', 'assets/expressions/talking.png'),
      ('SLEEPING', 'assets/expressions/sleeping.png'),
      ('IDLE', 'assets/expressions/idle.png'),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(
        AppSizes.screenPadding,
        24,
        AppSizes.screenPadding,
        140,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            title: 'Expressions',
            subtitle:
                'Choose an OLED expression for TARA',
          ),

          const SizedBox(height: 24),

          GridView.builder(
            shrinkWrap: true,
            physics:
                const NeverScrollableScrollPhysics(),
            itemCount: expressions.length,
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.9,
            ),
            itemBuilder: (context, index) {
              final expression =
                  expressions[index];

              final selected =
                  robot.currentExpression ==
                  expression.$1;

              return TweenAnimationBuilder<double>(
                duration: const Duration(
                  milliseconds: 250,
                ),
                curve: Curves.easeOutBack,
                tween: Tween(
                  begin: 1,
                  end: selected ? 1.04 : 1,
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
                child: GestureDetector(
                  onTap: () async {
                    HapticFeedback.mediumImpact();

                    await BluetoothService.instance
                        .sendExpression(
                      expression.$1,
                    );

                    robot.setExpression(
                      expression.$1,
                    );
                  },
                  child: AnimatedContainer(
                    duration: const Duration(
                      milliseconds: 300,
                    ),
                    curve: Curves.easeOutBack,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(
                        24,
                      ),
                    ),
                    child: GlassCard(
                      child: Column(
                        mainAxisAlignment:
                            MainAxisAlignment
                                .center,
                        children: [
                          Expanded(
                            child: Image.asset(
                              expression.$2,
                              fit: BoxFit.contain,
                              errorBuilder: (
                                context,
                                error,
                                stackTrace,
                              ) {
                                return const Icon(
                                  Icons.face,
                                  size: 80,
                                  color:
                                      Colors.white,
                                );
                              },
                            ),
                          ),

                          const SizedBox(
                            height: 12,
                          ),

                          Text(
                            expression.$1,
                            style:
                                const TextStyle(
                              color:
                                  Colors.white,
                              fontWeight:
                                  FontWeight.w700,
                              fontSize: 15,
                            ),
                          ),

                          const SizedBox(
                            height: 8,
                          ),

                          AnimatedContainer(
                            duration:
                                const Duration(
                              milliseconds:
                                  250,
                            ),
                            height: 4,
                            width: 60,
                            decoration:
                                BoxDecoration(
                              borderRadius:
                                  BorderRadius
                                      .circular(
                                20,
                              ),
                              color: selected
                                  ? const Color(
                                      0xFF8B5CF6,
                                    )
                                  : Colors
                                      .transparent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}