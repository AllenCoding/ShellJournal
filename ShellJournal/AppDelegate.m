//
//  AppDelegate.m
//  ShellJournal
//  Created by 刘勇 on 2017/3/3.
//  Copyright © 2017年 liuyong. All rights reserved.

#import "AppDelegate.h"
#import "SJMainTabbar.h"
#import <SMS_SDK/SMSSDK.h>
#import"iflyMSC/IFlyMSC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
       [self initRootVc];
       [self loadmap];
       [self loadIflyMSC];
       [self requestAuthor];
        [[UIApplication sharedApplication]setApplicationIconBadgeNumber:0];
    if (!firstLogin) {
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"firstLogin"];
    }
       return YES;
}


- (void)requestAuthor{
    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        // 设置通知的类型可以为弹窗提示,声音提示,应用图标数字提示
        UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert categories:nil];
        // 授权通知
        [[UIApplication sharedApplication] registerUserNotificationSettings:setting];
    }
}

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    NSLog(@"收到通知了");
//    
    NSArray*local=[[UIApplication sharedApplication]scheduledLocalNotifications];
//    for (UILocalNotification*vo in local) {
//        [[UIApplication sharedApplication]cancelLocalNotification:vo];
//    }
    NSLog(@"%@",local);
    
}


-(void)initRootVc{
    
    SJMainTabbar*tabbar=[[SJMainTabbar alloc]init];
    SJLoginViewController*loginVc=[[SJLoginViewController alloc]init];
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor=kWhiteColor;
    [self.window setRootViewController:isLogin?tabbar:loginVc];
    [self.window makeKeyAndVisible];
    NSLog(@"======%@",NSHomeDirectory());
}
#pragma mark 加载讯飞语音
-(void)loadIflyMSC{
    //设置sdk的log等级，log保存在下面设置的工作路径中
    [IFlySetting setLogFile:LVL_ALL];
    //打开输出在console的log开关
    [IFlySetting showLogcat:YES];
    //设置sdk的工作路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [paths objectAtIndex:0];
    [IFlySetting setLogFilePath:cachePath];
    //设置sdk Appkey
    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@",@"58e6f50c"];
    //启动服务
    [IFlySpeechUtility createUtility:initString];
}
#pragma mark 百度地图
-(void)loadmap{
    _mapManager = [[BMKMapManager alloc] init];
    [_mapManager start:@"cWxq93BmYEisHxrPBOVUsXTIoMa9KkFr" generalDelegate:self];
    [SMSSDK registerApp:@"1cbb72c815f95" withSecret:@"1fd5418b7af38c29922e635582a1e404"];
}
- (void)onGetNetworkState:(int)iError{
    if (0 == iError) {
        NSLog(@"联网成功");
    }
    else{
        NSLog(@"onGetNetworkState %d",iError);
    }
}

- (void)onGetPermissionState:(int)iError{
    if (0 == iError) {
        NSLog(@"授权成功");}
    else {
        NSLog(@"onGetPermissionState %d",iError);
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
  
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    NSInteger bage=[[UIApplication sharedApplication]applicationIconBadgeNumber];
    if (bage>0) {
        [[UIApplication sharedApplication]setApplicationIconBadgeNumber:0];
    }
    
    NSLog(@"这是本地通知单：%@",[[UIApplication sharedApplication]scheduledLocalNotifications]);
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
