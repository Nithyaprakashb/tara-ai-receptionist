import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/bluetooth_service.dart';
import '../../providers/robot_provider.dart';
import '../../services/bluetooth_service.dart';

import '../../widgets/glass_card.dart';
import '../../widgets/section_header.dart';
import '../../widgets/floating_action_chip.dart';

import '../../core/constants/app_sizes.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() =>
      _NewsScreenState();
}

class _NewsScreenState
    extends State<NewsScreen> {
  final TextEditingController
      _controller = TextEditingController();

  Future<void> _sendNews() async {
    final provider =
        context.read<RobotProvider>();

    final text =
        _controller.text.trim();

    if (text.isEmpty) return;

    await BluetoothService.instance
        .sendNews(text);

    provider.addNews(text);

    _controller.clear();

    if (mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content:
              Text('News sent to TARA'),
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
            title: 'News',
            subtitle:
                'Send news headlines to TARA',
          ),

          const SizedBox(height: 24),

          GlassCard(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                const Text(
                  'Current News',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight:
                        FontWeight.w700,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 12),

                Text(
                  robot.currentNews.isEmpty
                      ? 'No news available'
                      : robot.currentNews,
                  style: const TextStyle(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          GlassCard(
            child: Column(
              children: [
                TextField(
                  controller:
                      _controller,
                  maxLines: 4,
                  style:
                      const TextStyle(
                    color: Colors.white,
                  ),
                  decoration:
                      InputDecoration(
                    hintText:
                        'Enter news headline...',
                    hintStyle:
                        TextStyle(
                      color: Colors
                          .white
                          .withOpacity(
                        0.4,
                      ),
                    ),
                    border:
                        InputBorder.none,
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
                    label: 'Send',
                    icon:
                        Icons.send_rounded,
                    onTap: _sendNews,
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

          if (robot.newsHistory.isEmpty)
            GlassCard(
              child: Padding(
                padding:
                    const EdgeInsets.all(
                  12,
                ),
                child: Text(
                  'No news sent yet',
                  style: TextStyle(
                    color: Colors.white
                        .withOpacity(
                      0.6,
                    ),
                  ),
                ),
              ),
            ),

          ...robot.newsHistory.map(
            (item) => Padding(
              padding:
                  const EdgeInsets.only(
                bottom: 12,
              ),
              child: GlassCard(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                  children: [
                    Text(
                      item.message,
                      style:
                          const TextStyle(
                        color:
                            Colors.white,
                        fontWeight:
                            FontWeight
                                .w600,
                      ),
                    ),

                    const SizedBox(
                      height: 8,
                    ),

                    Text(
                      item.timestamp
                          .toString(),
                      style:
                          TextStyle(
                        color: Colors
                            .white
                            .withOpacity(
                          0.4,
                        ),
                        fontSize: 12,
                      ),
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