
package com.example.test_2

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine 
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val channel = "testing.work"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            channel
        ).setMethodCallHandler { call, result ->

            when (call.method) {
                "testUS" -> {
                    result.success("Hello from Android")
                }

             "Say Hello" -> {
                    result.success("This is your captain, welcome to android")                    
                }                
                        

            "To the Future " -> {
                result.success("To the Great day")
            }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }
}
