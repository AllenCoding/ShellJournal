//
//  SJForgetViewController.m
//  ShellJournal
//
//  Created by 刘勇 on 2017/4/5.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "SJForgetViewController.h"
#import "SJResetPasswordViewController.h"
#import <SMS_SDK/SMSSDK.h>

@interface SJForgetViewController ()<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *phoneTF;
@property (strong, nonatomic) IBOutlet UITextField *codeTF;
@property (strong, nonatomic) IBOutlet UIButton *nextBtn;
@property (strong, nonatomic) IBOutlet UIButton *codeBtn;
@property(assign,nonatomic)BOOL isAvaliable;

@end

@implementation SJForgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)change:(UITextField *)sender {
    if (self.isAvaliable&&self.codeTF.text.length==4) {
        [SMSSDK commitVerificationCode:self.codeTF.text phoneNumber:self.phoneTF.text zone:@"86" result:^(NSError *error) {
            if (!error) {
                self.nextBtn.enabled=YES;
                self.nextBtn.backgroundColor=kCommonBgColor;
            }else{
                self.nextBtn.enabled=NO;
                self.nextBtn.backgroundColor=kLightGrayColor;
                [MBProgressHUD showError:@"验证码有误"];
            }
        }];
    }
}
- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)getCode:(id)sender {
    if ([self.phoneTF.text isPhone]&&[[SJDataManager manager]isExist:self.phoneTF.text]) {
        [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.phoneTF.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
            if (!error) {
                [MBProgressHUD showSuccess:@"已发送"];
                self.isAvaliable=YES;
            }else{
                [MBProgressHUD showError:@"发送失败"];
            }
        }];
        __block int timeout=59; //倒计时时间
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
        dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
        dispatch_source_set_event_handler(_timer, ^{
            if(timeout<=0){
                dispatch_source_cancel(_timer);
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.codeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
                    self.codeBtn.userInteractionEnabled = YES;
                    self.codeBtn.backgroundColor = [UIColor orangeColor];
                    [self.codeBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
                });
            }else{
                int seconds = timeout % 60;
                NSString *strTime = [NSString stringWithFormat:@"%d", seconds];
                dispatch_async(dispatch_get_main_queue(), ^{
                [self.codeBtn setTitle:[NSString stringWithFormat:@"%@秒后可重新发送",strTime] forState:UIControlStateNormal];
                    self.codeBtn.userInteractionEnabled = NO;
                    self.codeBtn.backgroundColor = kWhiteColor;
                    [self.codeBtn setTitleColor:kCommonBgColor forState:UIControlStateNormal];
                });
                timeout--;
            }
        });
        dispatch_resume(_timer);
    }else{
        if ([self.phoneTF.text isPhone]) {
            [MBProgressHUD showError:@"账号未注册"];
        }else{
            [MBProgressHUD showError:@"请填写正确手机号"];
 
        }
    }
}
- (IBAction)nextStep:(id)sender {
    SJResetPasswordViewController*resetVc=[[SJResetPasswordViewController alloc]init];
    resetVc.accountPhone=self.phoneTF.text;
    [self presentViewController:resetVc animated:YES completion:nil];
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
