//
//  SJRegisterViewController.m
//  ShellJournal
//
//  Created by 刘勇 on 2017/4/5.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "SJRegisterViewController.h"

@interface SJRegisterViewController ()

@property (strong, nonatomic) IBOutlet UIView *accountView;
@property (strong, nonatomic) IBOutlet UIView *nicknameView;
@property (strong, nonatomic) IBOutlet UIView *passwordView;
@property (strong, nonatomic) IBOutlet UIButton *registerBtn;
@property (strong, nonatomic) IBOutlet UITextField *phoneTF;
@property (strong, nonatomic) IBOutlet UITextField *nickNameTF;
@property (strong, nonatomic) IBOutlet UITextField *pswTF;

@end

@implementation SJRegisterViewController
- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (IBAction)registerAccount:(id)sender {
    if (self.phoneTF.text.length&&self.pswTF.text.length&&self.nickNameTF.text.length) {
        if ([self.phoneTF.text isPhone]) {
            if ([[SJDataManager manager]isExist:self.phoneTF.text]) {
                [MBProgressHUD showError:@"账号已存在"];
            }else{
                SJPerson*person=[SJPerson new];
                person.personHeadImage=@"";
                person.personNickName=self.nickNameTF.text;
                person.personAccount=self.phoneTF.text;
                person.personLevel=@"0";
                person.personSignature=@"这个家伙很懒,什么都没留下";
                person.personPassword=[self.pswTF.text stringWithMD5];
                person.head=0;
                person.personcode=0000;
                person.boolVoice=1;
                person.boolImage=1;
                person.boolWeather=1;
                person.boolAddress=1;
                person.boolpassword=0;
                person.boolfinger=0;
                person.boolalert=0;
                person.alrtTime=@"20:00";

                [[SJDataManager manager]registerAccountWithPerson:person];
                [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(registerOk) userInfo:nil repeats:NO];
                [MBProgressHUD showMessage:@"正在提交"];
            }
        }else{
            [MBProgressHUD showError:@"请填写正确手机号"];
        }
    }else{
        [MBProgressHUD showError:@"注册信息不完整"];
    }
}

-(void)registerOk{
    [MBProgressHUD hideHUD];
    [MBProgressHUD showSuccess:@"注册成功"];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
