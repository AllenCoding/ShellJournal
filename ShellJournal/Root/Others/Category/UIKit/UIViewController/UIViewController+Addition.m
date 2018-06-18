//
//  UIViewController+Addition.m
//  DBZY
//
//  Created by 刘勇 on 2016/11/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "UIViewController+Addition.h"

@implementation UIViewController (Addition)

- (BOOL)isCurrentAndVisibleViewController {
    return self.isViewLoaded && self.view.window;
}

- (void)pushToNextViewController:(UIViewController *)nextVC {
    self.navigationController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:nextVC animated:YES];
}


@end
