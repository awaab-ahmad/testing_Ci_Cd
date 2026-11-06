import 'package:flutter/material.dart';
import 'package:test_2/views/screens/notification_check.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // imp for notifications
  runApp(const MainState());
}
// This is the widget
class MainState extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: NotificationsPage());
  }
}
