//  SJChangePasswordViewController.m
//  ShellJournal
//
//  Created by 刘勇 on 2017/4/12.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "SJChangePasswordViewController.h"

@interface SJChangePasswordViewController ()

@property (strong, nonatomic) IBOutlet UITextField *oldPswTF;
@property (strong, nonatomic) IBOutlet UITextField *pswTF;
@property (strong, nonatomic) IBOutlet UITextField *againTF;

@end

@implementation SJChangePasswordViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.oldPswTF becomeFirstResponder];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"修改密码";
    [self setRightItem];
}
-(void)setRightItem{
    UIButton*btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, 30, 30);
    [btn setTitle:@"保存" forState:UIControlStateNormal];
    [btn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(keep) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font=kSfont(14);
    UIBarButtonItem*item=[[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem=item;
}

/**
 修改密码成功
 */
-(void)keep{
    if (self.pswTF.text.length&&self.oldPswTF.text.length&&self.againTF.text.length) {
        if ([[self.oldPswTF.text stringWithMD5] isEqualToString:[[SJDataManager manager]currentInfo].personPassword]) {
            if ([self.pswTF.text isEqualToString:self.againTF.text]) {
                [[SJDataManager manager]updateUserPasswordWithNewPassWord:[self.pswTF.text stringWithMD5] personAccount:userAccount];
                [MBProgressHUD showSuccess:@"修改成功"];
                [self Pop];
                
            }else{
                [MBProgressHUD showError:@"密码输入不一致"];
            }
        }else{
            [MBProgressHUD showError:@"原密码错误"];
        }
    }else{
        [MBProgressHUD showError:@"密码不能为空"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
