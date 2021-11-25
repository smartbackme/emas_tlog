package com.kangraoo.apm.emas_tlog

import android.app.Application
import android.content.Context
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import com.alibaba.ha.adapter.service.tlog.TLogService;
import com.alibaba.ha.adapter.service.tlog.TLogLevel

import com.alibaba.ha.adapter.AliHaAdapter

import com.alibaba.ha.adapter.AliHaConfig
import com.alibaba.ha.adapter.Plugin
/** EmasTlogPlugin */
class EmasTlogPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private var context: Context? = null

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "emas_tlog")
    channel.setMethodCallHandler(this)
    context = flutterPluginBinding.applicationContext
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when {
      call.method.startsWith("log") -> {
        log(call, result)
      }
      call.method=="updateNickName" -> {
        val name = call.argument<String?>("name")
        AliHaAdapter.getInstance().updateUserNick(name)
      }
      call.method=="comment" -> {
        TLogService.positiveUploadTlog("COMMENT");
      }
      call.method=="init" -> {
        val appKey = call.argument<String>("appKey")
        val appSecret = call.argument<String>("appSecret")
        val rsaPublicKey = call.argument<String>("rsaPublicKey")
        val channel = call.argument<String>("channel")
        val userNick = call.argument<String?>("userNick")
        val type = call.argument<String?>("type")
        val debug = call.argument<Boolean>("debug")
        val config = AliHaConfig()
        config.appKey = appKey //配置项：appkey
        config.appSecret = appSecret //配置项：appsecret
        config.channel = channel //配置项：应用的渠道号标记，自定义
        config.rsaPublicKey = rsaPublicKey //配置项：tlog公钥
        config.userNick = userNick //配置项：用户的昵称

        config.appVersion = getVersionName() //配置项：应用的版本号

        config.application = context!!.applicationContext as Application //配置项：应用指针

        config.context = context!!.applicationContext //配置项：应用上下文

        config.isAliyunos = false //配置项：是否为yunos


        AliHaAdapter.getInstance().addPlugin(Plugin.tlog)
        AliHaAdapter.getInstance().openDebug(debug)
        AliHaAdapter.getInstance().start(config)
        if(type!=null){
          when (type) {
            "v"->{
              TLogService.updateLogLevel(TLogLevel.VERBOSE) //配置项：控制台可拉取的日志级别
            }
            "d"->{
              TLogService.updateLogLevel(TLogLevel.VERBOSE) //配置项：控制台可拉取的日志级别
            }
            "i"->{
              TLogService.updateLogLevel(TLogLevel.INFO) //配置项：控制台可拉取的日志级别
            }
            "w"->{
              TLogService.updateLogLevel(TLogLevel.WARN) //配置项：控制台可拉取的日志级别
            }
            "e"->{
              TLogService.updateLogLevel(TLogLevel.ERROR) //配置项：控制台可拉取的日志级别
            }
          }
        }

      }
      else -> {
        result.notImplemented()
      }
    }
  }

  fun log(@NonNull call: MethodCall, @NonNull result: Result){
    val message = call.argument<String>("message")
    val module = call.argument<String>("module")
    val tag = call.argument<String>("tag")
    when (call.method) {
      "logv"->{
        TLogService.logv(module,tag,message);
      }
      "logd"->{
        TLogService.logd(module,tag,message);
      }
      "logi"->{
        TLogService.logi(module,tag,message);
      }
      "logw"->{
        TLogService.logw(module,tag,message);
      }
      "loge"->{
        TLogService.loge(module,tag,message);
      }
    }
    result.success(true)
  }


  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  fun getVersionName():String = context!!.packageManager.getPackageInfo(context!!.packageName,0).versionName

}
