//
//  SJPrivateViewController.m
//  ShellJournal
//
//  Created by 刘勇 on 2017/5/26.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "SJPrivateViewController.h"
#import "SJSetLockViewController.h"
@interface SJPrivateViewController ()

@end

@implementation SJPrivateViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title=@"隐私安全";
    [self loadSwitchValue];
    
    
}

//指纹验证
- (IBAction)fingerOffanON:(UISwitch *)sender {
    [[SJDataManager manager]updateUserFingerSetting:sender.on];
}
//密码验证
- (IBAction)passwordOffandON:(UISwitch *)sender {
    SJSetLockViewController*lockVc=[[SJSetLockViewController alloc]init];
    if (sender.on) {
        [self PushToVc:lockVc];
    }
    [[SJDataManager manager]updateUserPasswordSetting:sender.on];
}


-(void)loadSwitchValue{
    self.fingerSwitch.on=[[SJDataManager manager]currentInfo].boolfinger?[[SJDataManager manager]currentInfo].boolfinger:NO;
    self.passwordSwitch.on=[[SJDataManager manager]currentInfo].boolpassword?[[SJDataManager manager]currentInfo].boolpassword:NO;
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
