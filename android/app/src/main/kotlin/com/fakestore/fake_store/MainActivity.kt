package com.fakestore.fake_store

import io.flutter.embedding.android.FlutterActivity
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.provider.Settings
import androidx.annotation.NonNull
import android.os.PowerManager
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "battery_optimizer_channel"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "requestIgnoreBatteryOptimizations") {
                requestIgnoreBatteryOptimizations()
                result.success(null)
            } else if (call.method == "openBatterySaverSettings") {
                openBatterySaverSettings()
                result.success(null)
            }else if(call.method == "isIgnoringBatteryOptimizations"){
                val isIgnoring = isIgnoringBatteryOptimizations()
                result.success(isIgnoring)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun requestIgnoreBatteryOptimizations() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            val intent = Intent(Settings.ACTION_REQUEST_IGNORE_BATTERY_OPTIMIZATIONS)
            intent.data = Uri.parse("package:$packageName")
            startActivity(intent)
        }
    }
    
    private fun openBatterySaverSettings() {
        val intent = Intent(android.provider.Settings.ACTION_BATTERY_SAVER_SETTINGS)
        startActivity(intent)
    }
    
    private fun isIgnoringBatteryOptimizations(): Boolean {
        val pm = getSystemService(Context.POWER_SERVICE) as PowerManager
        return pm.isIgnoringBatteryOptimizations(packageName)
    }
}
