package com.verify.zsy

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {
    private var zsyMethodChannel: ZsyMethodChannel? = null
    private var zsyEventChannel: ZsyEventChannel? = null
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        flutterEngine?.let {
            zsyMethodChannel = ZsyMethodChannel(this, it.dartExecutor.binaryMessenger)
            zsyEventChannel = ZsyEventChannel(this, it.dartExecutor.binaryMessenger)
        }
    }

    override fun onDestroy() {
        zsyMethodChannel?.onCancel()
        zsyEventChannel?.onCancel()
        super.onDestroy()
    }
}
