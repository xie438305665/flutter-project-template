package com.verify.zsy

import android.os.Bundle
import com.verify.zsy.channels.ZsyPlugin
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {
    private var zsyPlugin: ZsyPlugin? = null
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
//        flutterEngine?.let {
//            zsyChannelPlugin = ZsyChannelPlugin()
//            zsyChannelPlugin?.registerWith(this, it.dartExecutor.binaryMessenger);
//        }
    }

    override fun onDestroy() {
        if (zsyPlugin != null) {
            zsyPlugin = null;
        }
        super.onDestroy()
    }
}
