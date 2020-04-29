package com.verify.zsy

import android.os.Bundle
import android.text.TextUtils
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
    private val BACK_DESKTOP = "backDesktop"
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        if (flutterEngine != null) {
            MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger, BACK_DESKTOP).setMethodCallHandler { call: MethodCall, result: MethodChannel.Result ->
                if (TextUtils.equals(call.method, BACK_DESKTOP)) {
                    result.success(true)
                    moveTaskToBack(false)
                }
            }
        }
    }
}
