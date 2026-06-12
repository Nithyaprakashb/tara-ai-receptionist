import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/bluetooth_service.dart';
import '../../providers/robot_provider.dart';
import '../../services/bluetooth_service.dart';

import '../../widgets/glass_card.dart';
import '../../widgets/section_header.dart';

import '../../core/constants/app_sizes.dart';

class IoTScreen extends StatelessWidget {
  const IoTScreen({super.key});

  Future<void> _toggleRelay1(
    RobotProvider robot,
    bool value,
  ) async {
    if (value) {
      await BluetoothService.instance
          .relay1On();
    } else {
      await BluetoothService.instance
          .relay1Off();
    }

    robot.setRelay1(value);
  }

  Future<void> _toggleRelay2(
    RobotProvider robot,
    bool value,
  ) async {
    if (value) {
      await BluetoothService.instance
          .relay2On();
    } else {
      await BluetoothService.instance
          .relay2Off();
    }

    robot.setRelay2(value);
  }

  @override
  Widget build(BuildContext context) {
    final robot =
        context.watch<RobotProvider>();

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(
        AppSizes.screenPadding,
        24,
        AppSizes.screenPadding,
        140,
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            title: 'IoT Control',
            subtitle:
                'Manage connected relay devices',
          ),

          const SizedBox(height: 24),

          GlassCard(
            child: Row(
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment
                            .start,
                    children: [
                      Text(
                        'Relay 1',
                        style: TextStyle(
                          color:
                              Colors.white,
                          fontSize: 18,
                          fontWeight:
                              FontWeight
                                  .w700,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Control device connected to Relay 1',
                        style: TextStyle(
                          color:
                              Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),

                Switch.adaptive(
                  value: robot.relay1,
                  onChanged: (value) =>
                      _toggleRelay1(
                    robot,
                    value,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          GlassCard(
            child: Row(
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment
                            .start,
                    children: [
                      Text(
                        'Relay 2',
                        style: TextStyle(
                          color:
                              Colors.white,
                          fontSize: 18,
                          fontWeight:
                              FontWeight
                                  .w700,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Control device connected to Relay 2',
                        style: TextStyle(
                          color:
                              Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),

                Switch.adaptive(
                  value: robot.relay2,
                  onChanged: (value) =>
                      _toggleRelay2(
                    robot,
                    value,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          GlassCard(
            child: Column(
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.memory,
                      color: Colors.white,
                    ),

                    const SizedBox(
                      width: 12,
                    ),

                    Text(
                      robot.connected
                          ? 'ESP32-S3 Connected'
                          : 'ESP32-S3 Offline',
                      style:
                          const TextStyle(
                        color:
                            Colors.white,
                        fontWeight:
                            FontWeight
                                .w600,
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 16,
                ),

                Row(
                  children: [
                    const Icon(
                      Icons.bluetooth,
                      color: Colors.white,
                    ),

                    const SizedBox(
                      width: 12,
                    ),

                    Text(
                      robot.connected
                          ? 'BLE Active'
                          : 'BLE Disconnected',
                      style:
                          const TextStyle(
                        color:
                            Colors.white,
                        fontWeight:
                            FontWeight
                                .w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}