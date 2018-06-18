//
//  SJMainTabbar.m
//  ShellJournal
//
//  Created by 刘勇 on 2017/3/3.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "SJMainTabbar.h"
#import "SJHomeViewController.h"
#import "SJMineViewController.h"
#import "SJPictureViewController.h"
#import "SJNavgationBarController.h"
#import "SJKeyBoardView.h"

#import <LocalAuthentication/LocalAuthentication.h>

@interface SJMainTabbar ()<SJKeyBoardDelegate>

@property(nonatomic,strong)UIView*fullView;

@property(nonatomic,strong)UIImageView*headView;

@property(nonatomic,strong)SJKeyBoardView*keyView;

@end

@implementation SJMainTabbar

+ (void)initialize {
    // 设置为不透明
    [[UITabBar appearance] setTranslucent:NO];
    // 设置背景颜色
    [UITabBar appearance].barTintColor = [UIColor colorWithRed:0.97f green:0.97f blue:0.97f alpha:1.00f];
    
    // 拿到整个导航控制器的外观
    UITabBarItem * item = [UITabBarItem appearance];
    item.titlePositionAdjustment = UIOffsetMake(1, 1.5);

    // 普通状态
    NSMutableDictionary * normalAtts = [NSMutableDictionary dictionary];
    normalAtts[NSFontAttributeName] = kSfont(12);
    normalAtts[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.62f green:0.62f blue:0.63f alpha:1.00f];
    [item setTitleTextAttributes:normalAtts forState:UIControlStateNormal];
    // 选中状态
    NSMutableDictionary *selectAtts = [NSMutableDictionary dictionary];
    selectAtts[NSFontAttributeName] = kSfont(12);;
    selectAtts[NSForegroundColorAttributeName] =kCommonBgColor;
    [item setTitleTextAttributes:selectAtts forState:UIControlStateSelected];
    
}


-(UIView *)fullView{
    if (!_fullView) {
        _fullView=[[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _fullView.backgroundColor=kColorWithRGB(242, 242, 242);
        _fullView.userInteractionEnabled=YES;
        [self.view addSubview:_fullView];
        
           }
    return _fullView;
}

-(UIImageView *)headView{
    if (!_headView) {
        NSString*path=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
       _headView=[[UIImageView alloc]initWithFrame:CGRectMake((ScreenWidth-100)/2, 60, 100, 100)];
        _headView.image=[[SJDataManager manager]currentInfo].head?[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",path,[[SJDataManager manager]currentInfo].personHeadImage]]:[UIImage imageNamed:@"default"];
        _headView.layer.cornerRadius=50;
        _headView.layer.masksToBounds=YES;
    }
    return _headView;
}

-(SJKeyBoardView *)keyView{
    if (!_keyView) {
        _keyView=[[SJKeyBoardView alloc]initWithFrame:CGRectMake((ScreenWidth-260)/2, self.headView.bottom+20, 260, 380)];
        _keyView.passwordLength=4;
        _keyView.delegate=self;
        [self.fullView addSubview:_keyView];
    }
    return _keyView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpControllers];
    [self judgeSafetyMethod];
}

-(void)loadFingerView{
    [self.view addSubview:self.fullView];
    [self.fullView addSubview:self.headView];
    LAContext *context = [LAContext new];
    /** 这个属性用来设置指纹错误后的弹出框的按钮文字
     *  不设置默认文字为“输入密码”
     *  设置@""将不会显示指纹错误后的弹出框
     */
    context.localizedFallbackTitle = @"指纹错误";
    NSError *error;
    //判断设备支不支持Touch ID
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                localizedReason:@"通过指纹验证解锁贝壳日记"
                          reply:^(BOOL success, NSError * _Nullable error) {
                              if (success) {
                                  //验证成功执行
                                  NSLog(@"指纹识别成功");
                                  //在主线程刷新view，不然会有卡顿
                                  dispatch_async(dispatch_get_main_queue(), ^{
                                      [self.fullView removeFromSuperview];
                                  });
                              } else {
                                  if (error.code == kLAErrorUserFallback) {
//                                      //Fallback按钮被点击执行
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                          [self loadPasswordView];
                                        
                                      });
                                  } else if (error.code == kLAErrorUserCancel) {
//                                      //取消按钮被点击执行
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                          [self loadPasswordView];
                                      });
                                  } else {
                                      //指纹识别失败执行
                                      dispatch_async(dispatch_get_main_queue(), ^{
                                          [self loadPasswordView];
                                      });
                                  }
                              }
        }];
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"设备不支持Touch ID" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert animated:YES completion:nil];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:action];
    }
}

-(void)loadPasswordView{
    [self.fullView addSubview:self.headView];
    [self.fullView addSubview:self.keyView];

}

-(void)didFinishInputText:(NSString *)password{
    if ([password integerValue]==[SJDataManager manager].currentInfo.personcode) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.fullView removeFromSuperview];
        });
    }else{
        [MBProgressHUD showError:@"密码有误"];
    }
}
-(void)judgeSafetyMethod{
    if (isLogin&&[[SJDataManager manager]currentInfo].boolpassword&&[[SJDataManager manager]currentInfo].boolfinger) {
        [self loadFingerView];
    }else if(isLogin&&[[SJDataManager manager]currentInfo].boolpassword){
        [self loadPasswordView];
    }
}
-(void)setUpControllers{
    [self addChildViewControllerWithClassname:[SJHomeViewController description] imagename:@"note" title:@"日记"];
    [self addChildViewControllerWithClassname:[SJPictureViewController description]imagename:@"photo" title:@"照片"];
    [self addChildViewControllerWithClassname:[SJMineViewController description] imagename:@"mine" title:@"我的"];
    
}
- (void)addChildViewControllerWithClassname:(NSString *)classname
                                  imagename:(NSString *)imagename
                                      title:(NSString *)title {
    
    UIViewController *vc = [[NSClassFromString(classname) alloc] init];
    SJNavgationBarController *nav = [[SJNavgationBarController alloc] initWithRootViewController:vc];
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = [UIImage imageNamed:imagename];
    nav.tabBarItem.selectedImage = [[UIImage imageNamed:[imagename stringByAppendingString:@"_pressed"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addChildViewController:nav];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
