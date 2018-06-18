//
//  SJBaseViewController.h
//  ShellJournal
//
//  Created by 刘勇 on 2017/3/6.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SJBaseViewController : UIViewController

-(void)Pop;
-(void)PopToRootVc;
-(void)PopToVc:(UIViewController*)vc;
-(void)PushToVc:(UIViewController *)vc;

-(void)addChildVc:(UIViewController*)vc;
-(void)removeChildVc:(UIViewController*)vc;

-(void)dismiss;
-(void)dismissWithCompletion:(void(^)())completion;
-(void)presentToVc:(UIViewController*)vc;
-(void)presentVc:(UIViewController*)vc completion:(void(^)(void))completion;

-(BOOL)isCurrent;




@end
