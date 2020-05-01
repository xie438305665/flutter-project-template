package com.verify.zsy.channels;

import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.PluginRegistry;

public class ZsyPlugin implements ActivityAware, FlutterPlugin {

    @Nullable
    private ZsyChannelHelper zsyChannelHelper;
    @Nullable
    private ZsyActivityHelper zsyActivityHelper;

    public static void registerWith(PluginRegistry.Registrar registrar) {
        ZsyChannelHelper zsyChannelHelper = new ZsyChannelHelper(new ZsyActivityHelper(registrar.activity(), registrar.context()));
        zsyChannelHelper.startListening(registrar.messenger());
    }


    @Override
    public void onAttachedToEngine(@NotNull FlutterPluginBinding binding) {
        zsyActivityHelper = new ZsyActivityHelper(binding.getApplicationContext());
        zsyChannelHelper = new ZsyChannelHelper(zsyActivityHelper);
        zsyChannelHelper.startListening(binding.getBinaryMessenger());
    }

    @Override
    public void onDetachedFromEngine(FlutterPluginBinding binding) {
        if (zsyChannelHelper != null) {
            zsyChannelHelper.stopListening();
        }
        zsyChannelHelper = null;
        zsyActivityHelper = null;
    }

    @Override
    public void onAttachedToActivity(ActivityPluginBinding binding) {
        if (zsyChannelHelper != null && zsyActivityHelper != null) {
            binding.addActivityResultListener(zsyActivityHelper);
            zsyActivityHelper.setActivity(binding.getActivity());
        }
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
        onDetachedFromActivity();
    }

    @Override
    public void onReattachedToActivityForConfigChanges(ActivityPluginBinding binding) {
        onAttachedToActivity(binding);
    }

    @Override
    public void onDetachedFromActivity() {
        if (zsyChannelHelper == null) return;
        if (zsyActivityHelper != null) {
            zsyActivityHelper.onCancel();
        }
    }
}
