//
//  SJSafetyHomeViewController.m
//  ShellJournal
//
//  Created by 刘勇 on 2017/4/12.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "SJSafetyHomeViewController.h"
#import "SJChangePasswordViewController.h"
@interface SJSafetyHomeViewController ()
@property (strong, nonatomic) IBOutlet UILabel *accountLabel;
@property (strong, nonatomic) IBOutlet UIView *changeView;



@end

@implementation SJSafetyHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title=@"账号安全";
    self.accountLabel.text=[NSString stringWithFormat:@"当前登录账号:%@",userAccount];
    UITapGestureRecognizer*tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [self.changeView addGestureRecognizer:tap];
}
-(void)tap{
    SJChangePasswordViewController*changeVc=[[SJChangePasswordViewController alloc]init];
    [self PushToVc:changeVc];
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
