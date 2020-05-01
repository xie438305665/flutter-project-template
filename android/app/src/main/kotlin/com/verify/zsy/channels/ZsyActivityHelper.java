package com.verify.zsy.channels;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.util.Log;

import com.verify.zsy.CaptureActivity;

import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

public class ZsyActivityHelper implements PluginRegistry.ActivityResultListener {


    private Activity activity;
    private Context context;

    public ZsyActivityHelper(Context context) {
        this.context = context;
    }


    public ZsyActivityHelper(Activity activity, Context context) {
        this.activity = activity;
        this.context = context;
    }

    protected void startActivityForResult(MethodChannel.Result result, Object arguments, int code) {
        if (activity == null || context == null) return;
        activity.startActivityForResult(new Intent(context, CaptureActivity.class), code);
    }

    protected Activity getActivity() {
        return activity;
    }

    @Override
    public boolean onActivityResult(int requestCode, int resultCode, Intent data) {
//        if (resultCode == Activity.RESULT_OK && data != null) {
//            eventChannel.setArguments(2);
//            eventChannel.onListen();
//        }
        return true;
    }

    public void setActivity(Activity activity) {
        this.activity = activity;
    }

    protected void onCancel() {
        activity = null;
        context = null;
    }
}
