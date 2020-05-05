package com.verify.zsy

import android.app.Activity
import com.verify.zsy.ZsyConstant.EVENT_METHOD
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel

/**
 * Android发送Flutter信息
 */
class ZsyEventChannel(private val activity: Activity, binaryMessenger: BinaryMessenger) : EventChannel.StreamHandler {

    private var eventChannel: EventChannel? = null
    private var eventSink: EventChannel.EventSink? = null

    init {
        eventChannel = EventChannel(binaryMessenger, EVENT_METHOD)
        eventChannel?.setStreamHandler(this)
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        this.eventSink = events
    }

    override fun onCancel(arguments: Any?) {
        this.eventSink = null
    }

    fun onCancel() {
        eventChannel?.setStreamHandler(null)
        eventChannel = null
    }
}