//
//  SJNavgationBarController.m
//  ShellJournal
//
//  Created by 刘勇 on 2017/3/3.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "SJNavgationBarController.h"
@interface SJNavgationBarController ()

@end

@implementation SJNavgationBarController

+ (void)initialize {
    // 设置为不透明
    [[UINavigationBar appearance] setTranslucent:NO];
    // 设置导航栏背景颜色
    [UINavigationBar appearance].barTintColor = kCommonBgColor;
    // 创建字典保存文字大小和颜色
    NSMutableDictionary * color = [NSMutableDictionary dictionary];
    color[NSFontAttributeName] = kSfont(16.0f);
    color[NSForegroundColorAttributeName] = kWhiteColor;
    [[UINavigationBar appearance] setTitleTextAttributes:color];
    // 拿到整个导航控制器的外观
    UIBarButtonItem * item = [UIBarButtonItem appearance];
    item.tintColor = [UIColor colorWithRed:0.42f green:0.33f blue:0.27f alpha:1.00f];
    // 设置字典的字体大小
    NSMutableDictionary * atts = [NSMutableDictionary dictionary];
    atts[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    atts[NSForegroundColorAttributeName] = kWhiteColor;
    // 将字典给item
    [item setTitleTextAttributes:atts forState:UIControlStateNormal];
    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    /**
     *  如果在堆栈控制器数量大于1 加返回按钮
     */
    if (self.viewControllers.count > 0) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [btn setImage:[UIImage imageNamed:@"NavgationBar_arrow"] forState:UIControlStateNormal];
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, -18, 0, 0);
        btn.tintColor = [UIColor colorWithRed:0.42f green:0.33f blue:0.27f alpha:1.00f];
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        [btn addTarget:self action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = leftItem;
    } else {
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTitle:@"" tintColor:[UIColor colorWithRed:0.42f green:0.33f blue:0.27f alpha:1.00f] touchBlock:nil];
    }
    [super pushViewController:viewController animated:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
