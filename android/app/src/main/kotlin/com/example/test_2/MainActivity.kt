
package com.example.test_2

import android.content.Context
import android.os.BatteryManager
import android.widget.Toast
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine 
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    
    val channel = "method_Channel_work"
    override fun configureFlutterEngine(flutterEng : FlutterEngine) {
        super.configureFlutterEngine(flutterEng)
        
        MethodChannel(flutterEng.dartExecutor.binaryMessenger, channel).setMethodCallHandler { call, result -> 
        when (call.method) {
            "get_battery_percentage" -> {
                val batteryPercentile = getBatteryPercentile()
                Toast.makeText(context, "Battery is: $batteryPercentile", Toast.LENGTH_LONG).show()
                result.success("The Battery is: $batteryPercentile")
            }
            
            "add_numbers" -> {
                val a = call.argument<Int>("val1") ?: 0
                val b = call.argument<Int>("val2") ?: 0
                
                if(a < 0 || b < 0) {
                    result.error("Wrong values", "", "")
                } else result.success(a + b)
            }
        } 
         
        }
    }
    
    // making the function for getting the battery level
    private fun getBatteryPercentile() : Int? {
        val batteryManager = getSystemService(Context.BATTERY_SERVICE) as? BatteryManager ?: return null
        val value = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        return if (value in 0 .. 100) value else null
    }
}