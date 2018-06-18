//
//  SJSetLockViewController.m
//  ShellJournal
//
//  Created by 刘勇 on 2017/5/26.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "SJSetLockViewController.h"
#import "SJKeyBoardView.h"
@interface SJSetLockViewController ()<SJKeyBoardDelegate>

@property (strong, nonatomic) IBOutlet UILabel *warnLabel;

@property(nonatomic,strong)SJKeyBoardView*keyView;

@end

@implementation SJSetLockViewController

-(SJKeyBoardView *)keyView{
    if (!_keyView) {
        _keyView=[[SJKeyBoardView alloc]initWithFrame:CGRectMake((ScreenWidth-240)/2, self.warnLabel.bottom+20, 240, 350)];
        _keyView.delegate=self;
        _keyView.passwordLength=4;
    }
    return _keyView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"安全密码";
    [self.view addSubview:self.keyView];
}

-(void)didFinishInputText:(NSString *)password{
    NSLog(@"设置密码代理走了一遍");
    [[SJDataManager manager]updatePersonCode:[password integerValue]];
    [MBProgressHUD showSuccess:@"设置完成"];
    [self Pop];
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
