import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_2/views/screens/notification_check.dart';
import 'package:test_2/views/screens/user_api.dart';
import 'package:test_2/controller/state_manage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // imp for notifications
  runApp(const MainState());
}

// Now this will move to the new branch that will merge later
// suka
class MainState extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StateManage(),
      child: const MaterialApp(home: UserListScreen()),
    );
  }
}
