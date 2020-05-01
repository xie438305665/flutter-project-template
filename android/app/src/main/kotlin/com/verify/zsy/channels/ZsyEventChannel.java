package com.verify.zsy.channels;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.EventChannel;

public class ZsyEventChannel implements EventChannel.StreamHandler {
    private EventChannel channel;
    private EventChannel.EventSink eventSink;

    private ZsyEventChannel(BinaryMessenger binaryMessenger) {
        channel = new EventChannel(binaryMessenger, ZsyConstant.EVENT_CHANNEL);
        channel.setStreamHandler(this);
    }

    public static ZsyEventChannel create(BinaryMessenger binaryMessenger) {
        return new ZsyEventChannel(binaryMessenger);
    }

    @Override
    public void onListen(Object arguments, EventChannel.EventSink eventSink) {
        this.eventSink = eventSink;
        eventSink.success("this.arguments");
    }

    @Override
    public void onCancel(Object arguments) {
        this.eventSink = null;
    }

    protected void onCancel() {
        if (eventSink != null) {
            eventSink = null;
        }
        if (channel != null) {
            channel.setStreamHandler(null);
            channel = null;
        }
    }
}
