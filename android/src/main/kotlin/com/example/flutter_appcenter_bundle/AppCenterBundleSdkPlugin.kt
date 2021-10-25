package com.example.flutter_appcenter_bundle

import android.app.Application
import android.util.Log
import android.util.Log.VERBOSE
import androidx.annotation.NonNull
import com.microsoft.appcenter.AppCenter
import com.microsoft.appcenter.analytics.Analytics
import com.microsoft.appcenter.crashes.Crashes
import com.microsoft.appcenter.distribute.Distribute
import com.microsoft.appcenter.distribute.UpdateTrack
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** AppCenterBundleSdkPlugin */
class AppCenterBundleSdkPlugin : FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel: MethodChannel
  var application: Application? = null

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "it.wao.flutter_flutter_appcenter_bundle")
    application = flutterPluginBinding.applicationContext as Application
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    Log.d("onMethodCall", "[${call.method}")
    try {
      when (call.method) {
        "start" -> {
          if (application == null) {
            val error = "Fail to resolve Application on registration"
            Log.e(call.method, error)
            result.error(call.method, error, Exception(error))
            return
          }

          val appSecret = call.argument<String>("secret")
          val usePrivateTrack = call.argument<Boolean>("usePrivateTrack")
          if (usePrivateTrack == true) {
            Distribute.setUpdateTrack(UpdateTrack.PRIVATE);
          }

          if (appSecret == null || appSecret.isEmpty()) {
            val error = "App secret is not set"
            Log.e(call.method, error)
            result.error(call.method, error, Exception(error))
            return
          }
          AppCenter.setLogLevel(VERBOSE)
          AppCenter.start(application, appSecret, Analytics::class.java, Crashes::class.java, Distribute::class.java)
        }
        "trackEvent" -> {
          val name = call.argument<String>("name")
          val properties = call.argument<Map<String, String>>("properties")
          Analytics.trackEvent(name, properties)
        }
        "isDistributeEnabled" -> {
          result.success(Distribute.isEnabled().get())
          return
        }
        "getInstallId" -> {
          result.success(AppCenter.getInstallId().get()?.toString())
          return
        }
        "configureDistribute" -> {
          val value = call.arguments as Boolean
          Distribute.setEnabled(value).get()
        }
        "configureDistributeDebug" -> {
          val value = call.arguments as Boolean
          Distribute.setEnabledForDebuggableBuild(value)
        }
        "disableAutomaticCheckForUpdate" -> {
          Distribute.disableAutomaticCheckForUpdate()
        }
        "checkForUpdate" -> {
          Distribute.checkForUpdate()
        }
        "isCrashesEnabled" -> {
          result.success(Crashes.isEnabled().get())
          return
        }
        "configureCrashes" -> {
          val value = call.arguments as Boolean
          Crashes.setEnabled(value).get()
        }
        "isAnalyticsEnabled" -> {
          result.success(Analytics.isEnabled().get())
          return
        }
        "configureAnalytics" -> {
          val value = call.arguments as Boolean
          Analytics.setEnabled(value).get()
        }
        else -> {
          result.notImplemented()
        }
      }

      result.success(null)
    } catch (error: Exception) {
      Log.e("onMethodCall", "", error)
      throw error
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
