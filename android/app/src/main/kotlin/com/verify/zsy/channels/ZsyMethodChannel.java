package com.verify.zsy.channels;

import android.text.TextUtils;

import org.jetbrains.annotations.NotNull;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class ZsyMethodChannel implements MethodChannel.MethodCallHandler {

    private ZsyActivityHelper zsyActivityHelper;
    private MethodChannel channel;

    private ZsyMethodChannel(ZsyActivityHelper zsyActivityHelper, BinaryMessenger binaryMessenger) {
        this.zsyActivityHelper = zsyActivityHelper;
        channel = new MethodChannel(binaryMessenger, ZsyConstant.METHOD_CHANNEL);
        channel.setMethodCallHandler(this);
    }

    protected static ZsyMethodChannel create(ZsyActivityHelper zsyActivityHelper, BinaryMessenger binaryMessenger) {
        return new ZsyMethodChannel(zsyActivityHelper, binaryMessenger);
    }

    @Override
    public void onMethodCall(@NotNull MethodCall call, @NotNull MethodChannel.Result result) {
        if (TextUtils.equals(call.method, ZsyConstant.BACK_DESKTOP_METHOD)) {
            if (zsyActivityHelper == null) return;
            zsyActivityHelper.getActivity().moveTaskToBack(false);
            result.success(true);
        } else if (TextUtils.equals(call.method, ZsyConstant.QR_SCAN_METHOD)) {
            if (zsyActivityHelper == null) return;
            zsyActivityHelper.startActivityForResult(result, "", ZsyConstant.QR_SCAN_CODE);
            result.success(true);
        } else {
            result.notImplemented();
        }
    }

    protected void onCancel() {
        if (channel != null) {
            channel.setMethodCallHandler(null);
            channel = null;
        }
        if (zsyActivityHelper != null) {
            zsyActivityHelper.onCancel();
            zsyActivityHelper = null;
        }
    }
}
