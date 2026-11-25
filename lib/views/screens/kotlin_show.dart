import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';

class KotlinHello extends StatelessWidget {
  const new({super.key});

  static const MethodChannel channel = MethodChannel("method_Channel_work");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              final batteryPercentage = await channel.invokeMethod(
                "get_battery_percentage",
              );
              if (kDebugMode) print(batteryPercentage);
            },
            child: Text('Show toast'),
          ),

          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              final res = await channel.invokeMethod("add_numbers", {
                'val1': 10,
                'val2': 30,
              });
              if (kDebugMode) print(res);
            },
            child: Text('Add Numbers'),
          ),
        ],
      ),
    );
  }
}
