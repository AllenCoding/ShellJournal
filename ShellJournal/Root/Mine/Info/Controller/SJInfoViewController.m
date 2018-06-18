//
//  SJInfoViewController.m
//  ShellJournal
//
//  Created by 刘勇 on 2017/4/10.
//  Copyright © 2017年 liuyong. All rights reserved.

#import "SJInfoViewController.h"

@interface SJInfoViewController ()
@property (strong, nonatomic) IBOutlet UITextField *nickNameTF;
@property (strong, nonatomic) IBOutlet UITextView *sigatureTextView;

@end

@implementation SJInfoViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.nickNameTF becomeFirstResponder];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"我的资料";
    self.nickNameTF.text=[[SJDataManager manager]currentInfo].personNickName;
    self.sigatureTextView.text=[[SJDataManager manager]currentInfo].personSignature;
    [self setRightItemButton];
}
-(void)setRightItemButton{
    UIButton*btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, 30, 30);
    [btn setTitle:@"保存" forState:UIControlStateNormal];
    btn.titleLabel.font=kSfont(14);
    [btn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*rightItem=[[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem=rightItem;
}
-(void)submit{
    if (self.nickNameTF.text.length&&self.sigatureTextView.text.length) {
        [[SJDataManager manager]updateNickName:self.nickNameTF.text Signature:self.sigatureTextView.text];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"changeInfo" object:nil];
        [self Pop];
    }else{
        [MBProgressHUD showError:@"信息不能为空"];
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
