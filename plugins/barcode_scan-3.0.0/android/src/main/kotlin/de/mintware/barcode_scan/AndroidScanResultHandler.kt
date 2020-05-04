package de.mintware.barcode_scan

import android.app.Activity
import android.content.Intent
import android.util.Log
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry.ActivityResultListener

class AndroidScanResultHandler(private val result: MethodChannel.Result) : ActivityResultListener {

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        val scanResult: String
        when (resultCode) {
            Activity.RESULT_OK -> {
                scanResult = data?.getStringExtra(BarcodeScannerActivity.EXTRA_RESULT).toString()
            }
            else -> scanResult = ""
        }
        result.success(Protos.ScanResult.newBuilder()
                .setRawContent(scanResult)
                .build()
                .toByteArray())
        return true
    }
}