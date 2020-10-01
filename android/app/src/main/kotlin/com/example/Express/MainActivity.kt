package com.Auptimism.Express

import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
    override fun onPause() {
        Thread.sleep(100)
        super.onPause()
    }
}
