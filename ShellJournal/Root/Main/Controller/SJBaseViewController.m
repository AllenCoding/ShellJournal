//
//  SJBaseViewController.m
//  ShellJournal
//
//  Created by 刘勇 on 2017/3/6.
//  Copyright © 2017年 liuyong. All rights reserved.


#import "SJBaseViewController.h"

@interface SJBaseViewController ()

@end

@implementation SJBaseViewController

-(void)PushToVc:(UIViewController *)vc{
    
    if (self.navigationController==nil) return;
    if ([vc isKindOfClass:[UIViewController class]]==NO)  return;
    if (vc.hidesBottomBarWhenPushed==NO) {
        vc.hidesBottomBarWhenPushed=YES;
    }
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)PopToVc:(UIViewController *)vc{
    
    if ([vc isKindOfClass:[UIViewController class]]==NO)return;
    if (self.navigationController==nil)return;
    [self.navigationController popToViewController:vc animated:YES];
}

-(void)PopToRootVc{
    if (self.navigationController==nil)return;
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)Pop{
    if (self.navigationController==nil)return;
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)presentToVc:(UIViewController *)vc{
    
    if ([vc isKindOfClass:[UIViewController class]]==NO)return;
    [self presentVc:vc completion:nil];
}

-(void)presentVc:(UIViewController *)vc completion:(void (^)(void))completion{
    if ([vc isKindOfClass:[UIViewController class]]==NO)return;
    [self presentViewController:vc animated:YES completion:completion];
    
}

-(void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)dismissWithCompletion:(void (^)())completion{
    [self dismissViewControllerAnimated:YES completion:completion];
    
}

-(void)addChildVc:(UIViewController *)vc{
    
    if ([vc isKindOfClass:[UIViewController class]] == NO)return ;
    [vc willMoveToParentViewController:self];
    [vc.view addSubview:vc.view];
    [self.view addSubview:vc.view];
}


-(void)removeChildVc:(UIViewController *)vc{
    
    if ([vc isKindOfClass:[UIViewController class]] == NO)return ;
    [vc.view removeFromSuperview];
    [vc willMoveToParentViewController:nil];
    [vc removeFromParentViewController];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

-(BOOL)isCurrent{
    return self.isViewLoaded && self.view.window;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
