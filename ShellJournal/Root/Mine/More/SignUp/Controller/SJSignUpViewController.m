//
//  SJSignUpViewController.m
//  ShellJournal
//
//  Created by 刘勇 on 2017/6/7.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "SJSignUpViewController.h"
#import "SJCalendarView.h"

@interface SJSignUpViewController ()

@property(nonatomic,strong)NSMutableArray*sign;

@end

@implementation SJSignUpViewController

-(NSMutableArray *)sign{
    if (!_sign) {
        _sign=[NSMutableArray array];
        NSMutableArray*day=[NSMutableArray array];
        day=[[[SJDataManager manager]allSigns] mutableCopy];
        for (int i=0; i<day.count; i++) {
            SJSignModel*model=day[i];
            [_sign addObject:[NSNumber numberWithInt:(int)model.day]];
        }
    }
    return _sign;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"今日签到";
    self.view.backgroundColor=kWhiteColor;
    [self setUpCalendarView];
}

-(void)setUpCalendarView{
    
    SJCalendarView *calendarView = [[SJCalendarView alloc] init];
    calendarView.frame = CGRectMake(10, 30, (ScreenWidth-20), 280);
    [self.view addSubview:calendarView];
    
    //设置已经签到的天数日期
    calendarView.signArray = self.sign;
    calendarView.date = [NSDate date];
    
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:[NSDate date]];
    //日期点击事件
    __weak typeof(SJCalendarView) *calendar = calendarView;
    calendarView.calendarBlock =  ^(NSInteger day, NSInteger month, NSInteger year){
        if ([comp day]==day&&![[SJDataManager manager]isSign]) {
            
            
            SJProcessModel*model=[[SJProcessModel alloc]init];
            model.processtime=[NSString currentTime];
            model.colorStr=[NSString randomString];
            model.desc=@"完成今日签到任务";
            model.author=userAccount;
            model.score=@"+3";
            [[SJDataManager manager]insertProcessWithProcessModel:model];

            
            SJSignModel*sign=[[SJSignModel alloc]init];
            sign.day=day;
            sign.signTime=[NSString now];
            sign.signer=userAccount;
            sign.isSign=1;
            [[SJDataManager manager]insertSignWithSignModel:sign];
            [[SJDataManager manager]updateLevelWithSign];
            [MBProgressHUD showSuccess:@"签到成功"];
            [calendar setStyle_Today_Signed:calendar.dayButton];
        }else{
            
            [MBProgressHUD showError:@"明天再来吧!"];
        }
    };
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
