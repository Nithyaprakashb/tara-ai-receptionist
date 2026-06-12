import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/robot_provider.dart';
import '../../services/bluetooth_service.dart';

import '../../widgets/glass_card.dart';
import '../../widgets/robot_hero.dart';
import '../../widgets/status_pill.dart';

import '../../core/constants/app_sizes.dart';

class DashboardScreen extends StatefulWidget {
const DashboardScreen({super.key});

@override
State<DashboardScreen> createState() =>
_DashboardScreenState();
}

class _DashboardScreenState
extends State<DashboardScreen> {
Future<void> _showBluetoothDialog() async {
final robot =
context.read<RobotProvider>();
final actualConnection =
    BluetoothService.instance.isConnected;

if (robot.connected != actualConnection) {
  WidgetsBinding.instance
      .addPostFrameCallback((_) {
    context
        .read<RobotProvider>()
        .setConnection(
          actualConnection,
        );
  });
}

bool scanning = false;
bool failed = false;
bool connected = false;

await showDialog(
  context: context,
  barrierColor: Colors.black54,
  builder: (dialogContext) {
    return StatefulBuilder(
      builder: (context, setDialogState) {
        Future<void> connect() async {
          setDialogState(() {
            scanning = true;
            failed = false;
          });

          final result =
              await BluetoothService.instance
                  .connectToTara()
                  .timeout(
                    const Duration(
                      seconds: 15,
                    ),
                    onTimeout: () => false,
                  );

          if (!mounted) return;

          if (result) {
            robot.setConnection(true);

            setDialogState(() {
              scanning = false;
              connected = true;
            });

            await Future.delayed(
              const Duration(
                milliseconds: 1000,
              ),
            );

            if (mounted) {
              Navigator.pop(
                dialogContext,
              );
            }
          } else {
            setDialogState(() {
              scanning = false;
              failed = true;
            });
          }
        }

        return Dialog(
          backgroundColor:
              Colors.transparent,
          child: Container(
            padding:
                const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color:
                  const Color(0xFF1B1028),
              borderRadius:
                  BorderRadius.circular(
                32,
              ),
              border: Border.all(
                color: Colors.white
                    .withOpacity(0.08),
              ),
            ),
            child: Column(
              mainAxisSize:
                  MainAxisSize.min,
              children: [
                const Icon(
                  Icons.bluetooth,
                  color: Colors.white,
                  size: 42,
                ),

                const SizedBox(
                  height: 16,
                ),

                const Text(
                  'Connect to TARA',
                  style: TextStyle(
                    color:
                        Colors.white,
                    fontSize: 22,
                    fontWeight:
                        FontWeight.w700,
                  ),
                ),

                const SizedBox(
                  height: 24,
                ),

                if (scanning) ...[
                  const CircularProgressIndicator(),

                  const SizedBox(
                    height: 16,
                  ),

                  const Text(
                    'Searching for TARA...',
                    style: TextStyle(
                      color:
                          Colors.white70,
                    ),
                  ),
                ],

                if (failed) ...[
                  const Icon(
                    Icons.error_outline,
                    color: Colors.orange,
                    size: 38,
                  ),

                  const SizedBox(
                    height: 12,
                  ),

                  const Text(
                    'Make sure TARA is active and BLE is enabled.',
                    textAlign:
                        TextAlign.center,
                    style: TextStyle(
                      color:
                          Colors.white70,
                    ),
                  ),
                ],

                if (connected) ...[
                  const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 40,
                  ),

                  const SizedBox(
                    height: 12,
                  ),

                  const Text(
                    'Connected',
                    style: TextStyle(
                      color:
                          Colors.white,
                      fontWeight:
                          FontWeight.w700,
                    ),
                  ),
                ],

                if (!scanning &&
                    !connected) ...[
                  const SizedBox(
                    height: 20,
                  ),

                  SizedBox(
                    width:
                        double.infinity,
                    child:
                        ElevatedButton(
                      onPressed:
                          connect,
                      child:
                          const Text(
                        'Connect to TARA',
                      ),
                    ),
                  ),
                ],

                const SizedBox(
                  height: 12,
                ),

                TextButton(
                  onPressed: () {
                    Navigator.pop(
                      dialogContext,
                    );
                  },
                  child: const Text(
                    'Close',
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  },
);
}

@override
Widget build(BuildContext context) {
final robot =
context.watch<RobotProvider>();
return SingleChildScrollView(
  padding: const EdgeInsets.fromLTRB(
    AppSizes.screenPadding,
    20,
    AppSizes.screenPadding,
    140,
  ),
  child: Column(
    crossAxisAlignment:
        CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          const Expanded(
            child: Text(
              'TARA™',
              style: TextStyle(
                color:
                    Colors.white,
                fontSize: 36,
                fontWeight:
                    FontWeight.w800,
                letterSpacing: -1,
              ),
            ),
          ),

          GestureDetector(
            onTap:
                _showBluetoothDialog,
            child: Container(
              padding:
                  const EdgeInsets.all(
                12,
              ),
              decoration:
                  BoxDecoration(
                color: Colors.white
                    .withOpacity(
                  0.08,
                ),
                borderRadius:
                    BorderRadius
                        .circular(
                  18,
                ),
              ),
              child: const Icon(
                Icons
                    .bluetooth_rounded,
                color:
                    Colors.white,
              ),
            ),
          ),
        ],
      ),

      const SizedBox(height: 16),

      StatusPill(
        title:
            BluetoothService.instance.isConnected
                ? 'Online'
                : 'Offline',
        active:
            BluetoothService.instance.isConnected,
      ),

      const SizedBox(height: 28),

      const Center(
        child: RobotHero(),
      ),

      const SizedBox(height: 40),

      GlassCard(
        child: Column(
          children: const [
            _CapabilityTile(
              icon: Icons.face,
              title:
                  'Control Expressions',
            ),
            SizedBox(height: 18),
            _CapabilityTile(
              icon:
                  Icons.newspaper,
              title:
                  'Display News',
            ),
            SizedBox(height: 18),
            _CapabilityTile(
              icon:
                  Icons.campaign,
              title:
                  'Make Announcements',
            ),
            SizedBox(height: 18),
            _CapabilityTile(
              icon: Icons.memory,
              title:
                  'Control IoT Devices',
            ),
          ],
        ),
      ),
    ],
  ),
);

}
}

class _CapabilityTile
extends StatelessWidget {
final IconData icon;
final String title;

const _CapabilityTile({
required this.icon,
required this.title,
});

@override
Widget build(BuildContext context) {
return Row(
children: [
Icon(
icon,
color: Colors.white,
),
const SizedBox(width: 16),
Text(
title,
style: const TextStyle(
color: Colors.white,
fontSize: 15,
fontWeight:
FontWeight.w600,
),
),
],
);
}
}
