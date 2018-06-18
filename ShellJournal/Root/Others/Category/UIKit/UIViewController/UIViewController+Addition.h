//
//  UIViewController+Addition.h
//  DBZY
//
//  Created by 刘勇 on 2016/11/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Addition)

/**
 *  判断是否是正在显示的控制器
 */
- (BOOL)isCurrentAndVisibleViewController;

- (void)pushToNextViewController:(UIViewController *)nextVC;



@end
