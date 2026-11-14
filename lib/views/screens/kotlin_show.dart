import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';

class KotlinHello extends StatelessWidget {
  const new({super.key});

  static const channel = MethodChannel('testing.work');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              final data = await channel.invokeMethod('testUS');
              if (kDebugMode) print(data);
            },
            child: Text('Press to reveal'),
          ),
        ],
      ),
    );
  }
}
