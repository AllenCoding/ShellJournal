//
//  CustomHead.h
//  ShellJournal
//
//  Created by 刘勇 on 2017/3/6.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#ifndef CustomHead_h
#define CustomHead_h

#pragma mark----尺寸
#define kNavigationBarHeight 44
#define kStatusBarHeight 20
#define kTopBarHeight 64
#define kToolBarHeight 44
#define kTabBarHeight 49
#define kiPhone4_W 320
#define kiPhone4_H 480
#define kiPhone5_W 320
#define kiPhone5_H 568
#define kiPhone6_W 375
#define kiPhone6_H 667
#define kiPhone6P_W 414
#define kiPhone6P_H 736
#define ScreenWidth   [UIScreen mainScreen].bounds.size.width
#define ScreenHeight  [UIScreen mainScreen].bounds.size.height

#pragma mark----颜色
#define kWhiteColor [UIColor whiteColor]
#define kBlackColor [UIColor blackColor]
#define kDarkGrayColor [UIColor darkGrayColor]
#define kLightGrayColor [UIColor lightGrayColor]
#define kGrayColor [UIColor grayColor]
#define kRedColor [UIColor redColor]
#define kGreenColor [UIColor greenColor]
#define kBlueColor [UIColor blueColor]
#define kCyanColor [UIColor cyanColor]    

#define kYellowColor [UIColor yellowColor]
#define kMagentaColor [UIColor magentaColor]
#define kOrangeColor [UIColor orangeColor]
#define kPurpleColor [UIColor purpleColor]
#define kBrownColor [UIColor brownColor]
#define kClearColor [UIColor clearColor]
#define kColorWithRGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define kColorWithRGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define kCommonBgColor kColorWithRGB(44,197,94)
#define kRandomColor  kColorWithRGB(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

#define kSfont(size) [UIFont systemFontOfSize:size]
#define kBfont(size) [UIFont boldSystemFontOfSize:size]


#pragma mark UserLogin

#define isLogin [[NSUserDefaults standardUserDefaults]boolForKey:@"login"]
#define userAccount [[NSUserDefaults standardUserDefaults]objectForKey:@"account"]
#define firstLogin [[NSUserDefaults standardUserDefaults]boolForKey:@"firstLogin"]


#endif /* CustomHead_h */
