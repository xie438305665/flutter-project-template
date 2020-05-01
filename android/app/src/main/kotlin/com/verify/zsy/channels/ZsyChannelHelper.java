package com.verify.zsy.channels;

import org.jetbrains.annotations.Nullable;

import io.flutter.plugin.common.BinaryMessenger;

public class ZsyChannelHelper {


    @Nullable
    private ZsyActivityHelper zsyActivityHelper;

    @Nullable
    private ZsyMethodChannel methodChannel;

    public ZsyChannelHelper(@Nullable ZsyActivityHelper zsyActivityHelper) {
        this.zsyActivityHelper = zsyActivityHelper;
    }

    @Nullable
    private ZsyEventChannel eventChannel;


    protected void startListening(BinaryMessenger binaryMessenger) {
        if (methodChannel != null || eventChannel != null || zsyActivityHelper == null) {
            stopListening();
        }
        methodChannel = ZsyMethodChannel.create(zsyActivityHelper, binaryMessenger);
        eventChannel = ZsyEventChannel.create(binaryMessenger);
    }

    protected void stopListening() {
        if (methodChannel != null) {
            methodChannel.onCancel();
            methodChannel = null;
        }
        if (eventChannel != null) {
            eventChannel.onCancel();
            eventChannel = null;
        }
    }
}
