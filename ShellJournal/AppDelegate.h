//
//  AppDelegate.h
//  ShellJournal
//
//  Created by 刘勇 on 2017/3/3.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,BMKGeneralDelegate>

@property (strong, nonatomic) UIWindow *window;

@property(nonatomic,strong)BMKMapManager*mapManager;

@property(nonatomic,strong)BMKLocationService*locService;


@end

