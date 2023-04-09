package tech.amwal.auth.justpassme_flutter

import android.app.Activity
import androidx.activity.ComponentActivity
import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.lifecycleScope
import kotlinx.coroutines.launch
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import tech.amwal.justpassme.AndroidAuth


/** JustpassmeFlutterPlugin */
class JustpassmeFlutterPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var activity: Activity
    private lateinit var androidAuth: AndroidAuth

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "justpassme_flutter")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "getPlatformVersion" -> {
                result.success("Android ${android.os.Build.VERSION.RELEASE}")
            }

            "register" -> {
                this.androidAuth = AndroidAuth(
                    activity = activity,
                    "https://thebank.demo.1pass.tech/",
                    "https://thebank.verify.1pass.tech/auth/",
                    call.argument<String>("sessionId")!!
                )
                val response = androidAuth.register()
                result.success(response)
            }

            "login" -> {
                this.androidAuth = AndroidAuth(
                    activity = activity,
                    "https://thebank.demo.1pass.tech/",
                    "https://thebank.verify.1pass.tech/auth/",
                    call.argument<String>("sessionId")!!
                )
                val response = androidAuth.auth()
                result.success(response)
            }

            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(@NonNull binding: ActivityPluginBinding) {
        android.util.Log.d("JustpassmeFlutterPlugin", "onAttachedToActivity")
        this.activity = binding.activity

    }

    override fun onDetachedFromActivity() {
        android.util.Log.d("JustpassmeFlutterPlugin", "onDetachedFromActivity")

    }

    override fun onDetachedFromActivityForConfigChanges() {
        android.util.Log.d("JustpassmeFlutterPlugin", "onDetachedFromActivityForConfigChanges")
    }

    override fun onReattachedToActivityForConfigChanges(@NonNull binding: ActivityPluginBinding) {
        android.util.Log.d("JustpassmeFlutterPlugin", "onReattachedToActivityForConfigChanges")
        this.activity = binding.activity
        this.androidAuth = AndroidAuth(
            activity = activity,
            "https://thebank.demo.1pass.tech/",
            "https://thebank.verify.1pass.tech/auth/",
            "session_id"
        )
    }
}
