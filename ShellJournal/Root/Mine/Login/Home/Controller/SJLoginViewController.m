//
//  SJLoginViewController.m
//  ShellJournal
//
//  Created by 刘勇 on 2017/4/5.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "SJLoginViewController.h"
#import "SJRegisterViewController.h"
#import "SJForgetViewController.h"
#import "SJMainTabbar.h"

@interface SJLoginViewController ()<UITextFieldDelegate>

@end

@implementation SJLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)login:(id)sender {
    [[NSUserDefaults standardUserDefaults]setObject:self.accoutTF.text forKey:@"account"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    SJPerson*person=[[SJDataManager manager]currentInfo];
    if (self.passwordTF.text.length&&self.accoutTF.text.length) {
        if ([[SJDataManager manager]isExist:self.accoutTF.text]) {
            if ([[self.passwordTF.text stringWithMD5] isEqualToString:person.personPassword]&&[self.accoutTF.text isEqualToString:person.personAccount]) {
                [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(loginOk) userInfo:nil repeats:NO];
                [MBProgressHUD showMessage:@"正在登录"];
            }else{
                [MBProgressHUD showError:@"账号或密码有误"];
            }
        }else{
            [MBProgressHUD showError:@"账号不存在"];
        }
    }else{
        [MBProgressHUD showError:@"不能为空"];
    }
}

-(void)loginOk{
    
    [MBProgressHUD hideHUD];
    SJMainTabbar*tabbar=[[SJMainTabbar alloc]init];
    [[UIApplication sharedApplication].keyWindow setRootViewController:tabbar];
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"login"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [MBProgressHUD showSuccess:@"登录成功"];
}

- (IBAction)registerAccount:(id)sender {
    SJRegisterViewController*registerVc=[[SJRegisterViewController alloc]init];
    [self presentViewController:registerVc animated:YES completion:nil];
}
- (IBAction)forgetPassword:(id)sender {
    SJForgetViewController*forgetVc=[[SJForgetViewController alloc]init];
    [self presentViewController:forgetVc animated:YES completion:nil];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
