import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/robot_provider.dart';
import '../../services/bluetooth_service.dart';

import '../../widgets/glass_card.dart';
import '../../widgets/section_header.dart';
import '../../widgets/floating_action_chip.dart';

import '../../core/constants/app_sizes.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  Future<void> _connect(
    BuildContext context,
  ) async {
    final robot =
        context.read<RobotProvider>();

    final success =
        await BluetoothService.instance
            .connectToTara();

    robot.setConnection(success);

    if (context.mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            success
                ? 'Connected to TARA'
                : 'Unable to connect',
          ),
        ),
      );
    }
  }

  Future<void> _disconnect(
    BuildContext context,
  ) async {
    final robot =
        context.read<RobotProvider>();

    await BluetoothService.instance
        .disconnect();

    robot.setConnection(false);

    if (context.mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content:
              Text('Disconnected'),
        ),
      );
    }
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
            title: 'Settings',
            subtitle:
                'Robot information and configuration',
          ),

          const SizedBox(height: 24),

          // Robot Info

          GlassCard(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                const Text(
                  'Robot Information',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight:
                        FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 16),

                _infoTile(
                  'Robot Name',
                  robot.robotName,
                ),

                _infoTile(
                  'Status',
                  robot.connected
                      ? 'Online'
                      : 'Offline',
                ),

                _infoTile(
                  'Expression',
                  robot.currentExpression,
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // BLE Info

          GlassCard(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                const Text(
                  'BLE Information',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight:
                        FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 16),

                _infoTile(
                  'Device',
                  'TARA',
                ),

                _infoTile(
                  'Connection',
                  robot.connected
                      ? 'Connected'
                      : 'Disconnected',
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Actions

          GlassCard(
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                FloatingActionChip(
                  label: 'Connect',
                  icon: Icons.bluetooth,
                  onTap: () =>
                      _connect(context),
                ),

                FloatingActionChip(
                  label: 'Disconnect',
                  icon:
                      Icons.bluetooth_disabled,
                  onTap: () =>
                      _disconnect(context),
                ),

                FloatingActionChip(
                  label: 'Reset State',
                  icon:
                      Icons.restart_alt,
                  onTap: () {
                    context
                        .read<
                            RobotProvider>()
                        .resetState();

                    ScaffoldMessenger.of(
                            context)
                        .showSnackBar(
                      const SnackBar(
                        content: Text(
                          'State Reset',
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Developers

          GlassCard(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                const Text(
                  'Developers',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight:
                        FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 20),

                _developerTile(
                  'NITHYA PRAKASH B',
                  '212224050026',
                ),

                const SizedBox(height: 12),

                _developerTile(
                  'RAHUL R',
                  '212224050034',
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          Center(
            child: Text(
              'TARA AI Receptionist v1.0',
              style: TextStyle(
                color: Colors.white
                    .withOpacity(0.5),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _infoTile(
    String title,
    String value,
  ) {
    return Padding(
      padding:
          const EdgeInsets.only(
        bottom: 12,
      ),
      child: Row(
        children: [
          Text(
            '$title : ',
            style: const TextStyle(
              color: Colors.white70,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style:
                  const TextStyle(
                color: Colors.white,
                fontWeight:
                    FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _developerTile(
    String name,
    String regNo,
  ) {
    return Container(
      padding:
          const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color:
            Colors.white.withOpacity(
          0.05,
        ),
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor:
                Colors.deepPurple,
            child: Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,
              children: [
                Text(
                  name,
                  style:
                      const TextStyle(
                    color:
                        Colors.white,
                    fontWeight:
                        FontWeight
                            .w700,
                  ),
                ),
                Text(
                  regNo,
                  style:
                      const TextStyle(
                    color:
                        Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}