#import "EmasTlogPlugin.h"
#import <AlicloudTLog/AlicloudTlogProvider.h>
#import <AlicloudHAUtil/AlicloudHAProvider.h>
#import <TRemoteDebugger/TRDManagerService.h>

#import <TRemoteDebugger/TLogBiz.h>
#import <TRemoteDebugger/TLogFactory.h>
#import <UTDID/UTDevice.h>

@implementation EmasTlogPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"emas_tlog"
            binaryMessenger:[registrar messenger]];
  EmasTlogPlugin* instance = [[EmasTlogPlugin alloc] init];
  NSLog(@"\n ==== %@",[UTDevice utdid]); // YZ2gRyP4t0EDAK4z2x7IRG+C
      NSLog(@"这是插件oc代码");
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSString *message = call.arguments[@"message"];
    NSString *module = call.arguments[@"module"];
    TLogBiz *log = [TLogFactory createTLogForModuleName:module];
    
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);

  }else if([@"debug" isEqualToString:call.method]){
    [log debug:message];

  }else if([@"error" isEqualToString:call.method]){
    [log error:message];

  }else if([@"warn" isEqualToString:call.method]){
    [log warn:message];

  }else if([@"info" isEqualToString:call.method]){
    [log info:message];

  }else if([@"comment" isEqualToString:call.method]){ // 主动上传日志
    [AlicloudTlogProvider uploadTLog:@"COMMENT"];

  }else if([@"init" isEqualToString:call.method]){ // alicloud

     /*
         appKey
         appSecret
         tlogRsaSecret
         appVersion // App版本
         channel // 渠道标记 固定外界可不传
         nick  // 用户昵称  都不能为空
     */
     NSString *appKey = call.arguments[@"appKeyIos"];
     NSString *appSecret = call.arguments[@"appSecretIos"];
     NSString *tlogRsaSecret = call.arguments[@"rsaPublicKeyIos"];
     NSString *type = call.arguments[@"type"];

     NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
     NSString *appVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];; //配置项：App版本号
     NSString *channel = call.arguments[@"channel"]; //配置项：渠道标记
     NSString *nick = call.arguments[@"userNick"]; //配置项：用户昵称

     //配置项：控制台可拉取的日志级别
     [[AlicloudTlogProvider alloc] initWithAppKey:appKey secret:appSecret tlogRsaSecret:tlogRsaSecret appVersion:appVersion channel:channel nick:nick];
     [AlicloudHAProvider start];
     // 拉取日志级别
     NSInteger logLevel;
     if([type isEqualToString:@"i"]){
         logLevel = TLogLevelInfo;
     }else if([type isEqualToString:@"w"]){
         logLevel = TLogFlagWarn;
     }else if([type isEqualToString:@"e"]){
         logLevel = TLogFlagError;
     }else{
         logLevel = TLogLevelDebug; // d
     }
     [TRDManagerService updateLogLevel:logLevel];

  }else {
    result(FlutterMethodNotImplemented);
  }
}

@end
