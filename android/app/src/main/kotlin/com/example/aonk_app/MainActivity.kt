package com.example.aonk_app

import android.os.Bundle
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsCompat
import androidx.core.view.WindowInsetsControllerCompat
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
override fun onCreate(savedInstanceState: Bundle?) {
super.onCreate(savedInstanceState)

// Enable edge-to-edge display manually for FlutterActivity
WindowCompat.setDecorFitsSystemWindows(window, false)

// Configure system bars for proper edge-to-edge display
val windowInsetsController = WindowCompat.getInsetsController(window, window.decorView)
windowInsetsController.systemBarsBehavior = WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
}
}
