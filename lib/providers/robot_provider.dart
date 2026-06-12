import 'package:flutter/material.dart';

import '../models/announcement_item.dart';
import '../models/news_item.dart';

class RobotProvider extends ChangeNotifier {
  String robotName = 'TARA';

  bool connected = false;

  String currentExpression = 'IDLE';

  String currentNews = '';

  bool relay1 = false;

  bool relay2 = false;

  String lastAnnouncement = '';

  int selectedTab = 0;

  final List<NewsItem> newsHistory = [];

  final List<AnnouncementItem> announcementHistory = [];

  // Connection

  void setConnection(bool value) {
    connected = value;
    notifyListeners();
  }

  // Navigation

  void setTab(int index) {
    selectedTab = index;
    notifyListeners();
  }

  // Expressions

  void setExpression(String expression) {
    currentExpression = expression;
    notifyListeners();
  }

  // News

  void addNews(String message) {
    currentNews = message;

    newsHistory.insert(
      0,
      NewsItem(
        message: message,
        timestamp: DateTime.now(),
      ),
    );

    notifyListeners();
  }

  // Announcements

  void addAnnouncement(String message) {
    lastAnnouncement = message;

    announcementHistory.insert(
      0,
      AnnouncementItem(
        message: message,
        timestamp: DateTime.now(),
      ),
    );

    notifyListeners();
  }

  // Relay 1

  void setRelay1(bool value) {
    relay1 = value;
    notifyListeners();
  }

  // Relay 2

  void setRelay2(bool value) {
    relay2 = value;
    notifyListeners();
  }

  // Reset

  void resetState() {
    connected = false;

    currentExpression = 'IDLE';

    currentNews = '';

    relay1 = false;

    relay2 = false;

    lastAnnouncement = '';

    newsHistory.clear();

    announcementHistory.clear();

    notifyListeners();
  }
}