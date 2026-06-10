import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final _plugin = FlutterLocalNotificationsPlugin();

  static const _channelId = 'geopasture_alerts';
  static const _channelName = 'Animal Distress Alerts';

  static Future<void> init() async {
    // flutter_local_notifications only supports Android/iOS/macOS
    if (defaultTargetPlatform != TargetPlatform.android &&
        defaultTargetPlatform != TargetPlatform.iOS) {
      return;
    }
    const settings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    );
    await _plugin.initialize(settings);
  }

  static Future<void> showDistressAlert({
    required String notificationId,
    required int alertCount,
    required String message,
  }) async {
    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        _channelId,
        _channelName,
        importance: Importance.high,
        priority: Priority.high,
      ),
    );

    final title = alertCount == 1
        ? 'Animal Distress Alert'
        : '$alertCount New Distress Alerts';

    await _plugin.show(notificationId.hashCode.abs(), title, message, details);
  }
}
