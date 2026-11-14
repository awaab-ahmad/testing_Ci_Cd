
package com.example.test_2

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val Channel = "testing.work"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            Channel
        ).setMethodCallHandler { call, result ->

            when (call.method) {
                "testUS" -> {
                    result.success("Hello from Android")
                }

                else -> {
                    result.notImplemented()
                }
            }
        }
    }
}
