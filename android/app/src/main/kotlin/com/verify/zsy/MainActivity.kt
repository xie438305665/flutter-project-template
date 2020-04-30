package com.verify.zsy

import android.util.Log
import android.content.Intent
import android.os.Bundle
import android.text.TextUtils
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
    private val BACK_DESKTOP = "backDesktop"
    private val QR_SCAN = "qrScan"

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
                } else {
                    result.notImplemented()
                }
            }
            MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger, QR_SCAN).setMethodCallHandler { call: MethodCall, result: MethodChannel.Result ->
                if (TextUtils.equals(call.method, QR_SCAN)) {
                    result.success(true)
                    startActivity(Intent(this, CaptureActivity::class.java))
                } else {
                    result.notImplemented()
                }
            }
        }
    }
}
