import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State createState() => _Noti();
}

class _Noti extends State<NotificationsPage> {
  static List<Map<String, dynamic>> data = [
    {'id': 20},
    {'id': 21},
    {'id': 22},
    {'id': 24},
  ];

  final FlutterLocalNotificationsPlugin nt = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    timeZoneSetup();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final ind = data[index];
                final id = ind['id'];
                return ListTile(
                  onTap: () async {
                    if (kDebugMode) print('The tile pressed');
                    await showNotification(
                      id: id,
                      title: 'Hello Awaab',
                      body: 'The id of this notification is $id',
                    );
                  },
                  title: Text('Id: $id'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void timeZoneSetup() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Karachi'));

    const andSettings = AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings init = InitializationSettings(
      android: andSettings,
      iOS: DarwinInitializationSettings(),
    );

    await nt.initialize(settings: init);
  }

  Future<void> showNotification({
    required int id,
    required String title,
    body,
  }) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'instant_channel_id',
          'Instant Notifications',
          channelDescription: 'Channel for instant local notifications',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker',
        );
    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
    );
    await nt.show(
      id: id,
      title: title,
      body: body,
      notificationDetails: notificationDetails,
    );
  }
}
