package com.verify.zsy

import android.app.Activity
import android.text.TextUtils
import com.verify.zsy.ZsyConstant.BACK_DESKTOP_METHOD
import com.verify.zsy.ZsyConstant.METHOD_CHANNEL
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler

/**
 * Android接收Flutter 信息
 */
class ZsyMethodChannel(private val activity: Activity, binaryMessenger: BinaryMessenger) : MethodCallHandler {
    private var methodChannel: MethodChannel? = null
    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        if (TextUtils.equals(call.method, BACK_DESKTOP_METHOD)) {
            activity.moveTaskToBack(false)
            result.success(true)
        }
    }

    init {
        methodChannel = MethodChannel(binaryMessenger, METHOD_CHANNEL)
        methodChannel?.setMethodCallHandler(this)
    }

    fun onCancel() {
        methodChannel?.setMethodCallHandler(null)
        methodChannel = null
    }
}