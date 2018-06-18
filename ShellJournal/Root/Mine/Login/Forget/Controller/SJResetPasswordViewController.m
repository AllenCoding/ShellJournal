//
//  SJResetPasswordViewController.m
//  ShellJournal
//
//  Created by 刘勇 on 2017/4/6.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "SJResetPasswordViewController.h"

@interface SJResetPasswordViewController ()
@property (strong, nonatomic) IBOutlet UITextField *pswTF;
@property (strong, nonatomic) IBOutlet UITextField *againPswTF;

@end

@implementation SJResetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)resetDone:(id)sender {
    if (self.pswTF.text.length&&self.againPswTF.text.length) {
        if ([self.pswTF.text isEqualToString:self.againPswTF.text]) {
            [[SJDataManager manager]updateUserPasswordWithNewPassWord:[self.pswTF.text stringWithMD5] personAccount:self.accountPhone];
            [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(resetOk) userInfo:nil repeats:NO];
            [MBProgressHUD showMessage:@"正在提交"];
        }else{
            [MBProgressHUD showError:@"输入不一致"];
        }
    }else{
        [MBProgressHUD showError:@"密码不能为空"];
    }
}

-(void)resetOk{
    [MBProgressHUD hideHUD];
    [MBProgressHUD showSuccess:@"修改成功"];
    [self.presentingViewController.presentingViewController dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
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
