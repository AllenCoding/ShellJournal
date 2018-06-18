//
//  SJLevelViewController.m
//  ShellJournal
//
//  Created by 刘勇 on 2017/6/7.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "SJLevelViewController.h"

@interface SJLevelViewController ()<UIWebViewDelegate>

@property(nonatomic,strong)UIWebView*web;

@end

@implementation SJLevelViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MBProgressHUD showMessage:@"正在加载"];

}

-(UIWebView *)web{
    if (!_web) {
        _web=[[UIWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        NSString *path = [[NSBundle mainBundle] bundlePath];
        NSURL *baseURL = [NSURL fileURLWithPath:path];
        NSString * htmlPath = [[NSBundle mainBundle] pathForResource:@"Level"
                                                              ofType:@"html"];
        NSString * htmlCont = [NSString stringWithContentsOfFile:htmlPath
                                                        encoding:NSUTF8StringEncoding
                                                           error:nil];
        _web.delegate=self;
        [_web loadHTMLString:htmlCont baseURL:baseURL];
        
    }
    return _web;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"等级说明";
    [self.view addSubview:self.web];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideHUD];
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
