import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/bluetooth_service.dart';
import '../../providers/robot_provider.dart';
import '../../services/bluetooth_service.dart';

import '../../widgets/floating_action_chip.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/section_header.dart';

import '../../core/constants/app_sizes.dart';

class AnnouncementsScreen extends StatefulWidget {
  const AnnouncementsScreen({super.key});

  @override
  State<AnnouncementsScreen> createState() =>
      _AnnouncementsScreenState();
}

class _AnnouncementsScreenState
    extends State<AnnouncementsScreen> {
  final TextEditingController
      _controller = TextEditingController();

  Future<void> _sendAnnouncement() async {
    final provider =
        context.read<RobotProvider>();

    final text =
        _controller.text.trim();

    if (text.isEmpty) return;

    await BluetoothService.instance
        .sendAnnouncement(text);

    provider.addAnnouncement(text);

    _controller.clear();

    if (mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'Announcement sent',
          ),
        ),
      );
    }
  }

  Future<void> _replay(
    String message,
  ) async {
    await BluetoothService.instance
        .sendAnnouncement(message);

    if (mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'Announcement replayed',
          ),
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
            title: 'Announcements',
            subtitle:
                'Broadcast messages through TARA',
          ),

          const SizedBox(height: 24),

          GlassCard(
            child: Column(
              children: [
                TextField(
                  controller:
                      _controller,
                  maxLines: 5,
                  style:
                      const TextStyle(
                    color: Colors.white,
                  ),
                  decoration:
                      InputDecoration(
                    border:
                        InputBorder.none,
                    hintText:
                        'Enter announcement...',
                    hintStyle:
                        TextStyle(
                      color: Colors
                          .white
                          .withOpacity(
                        0.4,
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 16,
                ),

                Align(
                  alignment:
                      Alignment.centerRight,
                  child:
                      FloatingActionChip(
                    label: 'Broadcast',
                    icon: Icons.campaign,
                    onTap:
                        _sendAnnouncement,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          if (robot.lastAnnouncement
              .isNotEmpty)
            GlassCard(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,
                children: [
                  const Text(
                    'Last Announcement',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight:
                          FontWeight.w700,
                    ),
                  ),

                  const SizedBox(
                    height: 12,
                  ),

                  Text(
                    robot
                        .lastAnnouncement,
                    style:
                        const TextStyle(
                      color:
                          Colors.white,
                    ),
                  ),
                ],
              ),
            ),

          const SizedBox(height: 28),

          const Text(
            'History',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight:
                  FontWeight.w700,
            ),
          ),

          const SizedBox(height: 16),

          if (robot
              .announcementHistory
              .isEmpty)
            GlassCard(
              child: Text(
                'No announcements yet',
                style: TextStyle(
                  color: Colors.white
                      .withOpacity(
                    0.6,
                  ),
                ),
              ),
            ),

          ...robot
              .announcementHistory
              .map(
                (announcement) =>
                    Padding(
                  padding:
                      const EdgeInsets
                          .only(
                    bottom: 12,
                  ),
                  child: GlassCard(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                      children: [
                        Text(
                          announcement
                              .message,
                          style:
                              const TextStyle(
                            color: Colors
                                .white,
                            fontWeight:
                                FontWeight
                                    .w600,
                          ),
                        ),

                        const SizedBox(
                          height: 14,
                        ),

                        Row(
                          children: [
                            Text(
                              announcement
                                  .timestamp
                                  .toString(),
                              style:
                                  TextStyle(
                                color: Colors
                                    .white
                                    .withOpacity(
                                  0.4,
                                ),
                                fontSize:
                                    12,
                              ),
                            ),

                            const Spacer(),

                            IconButton(
                              onPressed:
                                  () =>
                                      _replay(
                                announcement
                                    .message,
                              ),
                              icon:
                                  const Icon(
                                Icons
                                    .replay_rounded,
                                color: Colors
                                    .white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
        ],
      ),
    );
  }
}