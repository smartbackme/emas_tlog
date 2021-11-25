#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"
#import <AlicloudTLog/AlicloudTlogProvider.h>
#import <AlicloudHAUtil/AlicloudHAProvider.h>
#import <TRemoteDebugger/TRDManagerService.h>

#import <TRemoteDebugger/TLogBiz.h>
#import <TRemoteDebugger/TLogFactory.h>
#import <UTDID/UTDevice.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
    
//    NSString *appVersion = @"1.0"; //配置项：App版本
//    NSString *channel = @"appstore"; //配置项：渠道标记
//    NSString *nick = @"AppDelegateEmas"; //配置项：用户昵称
////    [[AlicloudTlogProvider alloc] autoInitWithAppVersion:appVersion channel:channel nick:nick];
//    [[AlicloudTlogProvider alloc] initWithAppKey:@"333579447" secret:@"6ea5234e35d04b90b431f08376e71b78" tlogRsaSecret:@"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCND5dpkA3ovENpGu0RPV/SiUph+p6pqQz7K25IZmYo8nwIfSux0l6UUeAbICfCEqReS48w7u9y6mPiR6kEpkphxAHlXtx3T0FHPWiA0ZC8qug6AWWjGjli0mvLMZSKMG1MP4oE/VNuTNiZ8Fe2BvhUiKOovSnmYDlZ2fn+BlHh6QIDAQAB" appVersion:appVersion channel:channel nick:nick];
//    [AlicloudHAProvider start];
//    [TRDManagerService updateLogLevel:TLogLevelInfo];
//    
//    
//    TLogBiz *log = [TLogFactory createTLogForModuleName:@"lpn_AppDelegateEmas"];
//    [log info:@"info message_AppDelegateEmas"];
//    
//    [AlicloudTlogProvider uploadTLog:@"COMMENT"];
    
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
