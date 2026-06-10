package com.geopasture.geopasture

import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
    companion object {
        init {
            // Force the Flex delegate .so to load before any TFLite interpreter
            // is created. Without this, LSTM ops (TensorListReserve) fail because
            // the select-tf-ops library is in the APK but not yet linked.
            try {
                System.loadLibrary("tensorflowlite_flex")
            } catch (_: UnsatisfiedLinkError) {
                // Silently ignored — TFLite will report a clearer error if inference fails
            }
        }
    }
}
