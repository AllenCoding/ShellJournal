//
//  SJRemindViewController.m
//  ShellJournal
//
//  Created by 刘勇 on 2017/6/7.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "SJRemindViewController.h"

@interface SJRemindViewController ()<UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *timeTF;
@property (strong, nonatomic) IBOutlet UISwitch *alertSwitch;
@property(nonatomic,strong)NSMutableArray*hour;
@property(nonatomic,strong)NSMutableArray*minute;
@property(nonatomic,strong)UIPickerView*datePicker;
@property (strong, nonatomic) IBOutlet UILabel *warnLabel;

@property(nonatomic,copy)NSString*hourStr;
@property(nonatomic,copy)NSString*minuteStr;


@end

@implementation SJRemindViewController


-(UIPickerView *)datePicker{
    if (!_datePicker) {
        _datePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 216)];
        _datePicker.showsSelectionIndicator=YES;
        _datePicker.dataSource = self;
        _datePicker.delegate = self;
    }
    return _datePicker;
}

-(NSMutableArray *)hour{
    if (!_hour) {
        _hour=[NSMutableArray new];
        for (NSInteger index=0; index<24; index++) {
            NSString*string=[NSString stringWithFormat:@"%02ld",index];
            [_hour addObject:string];
        }
    }
    return _hour;
}

-(NSMutableArray *)minute{
    if (!_minute) {
        _minute=[NSMutableArray new];
        for (NSInteger index=0; index<60; index++) {
            NSString*string=[NSString stringWithFormat:@"%02ld",index];
            [_minute addObject:string];
        }
    }
    return _minute;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"贝壳提醒";
    [self setUpViews];
}

-(void)setUpViews{
    self.timeTF.delegate=self;
    self.timeTF.text=[[SJDataManager manager]currentInfo].alrtTime;
    self.alertSwitch.on=[[SJDataManager manager]currentInfo].boolalert;
    self.warnLabel.hidden=self.alertSwitch.on;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    textField.inputView=self.datePicker;
}

#pragma Mark -- UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return component==0?[self.hour count]:[self.minute count];
}

#pragma Mark -- UIPickerViewDelegate
// 每列宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return ScreenWidth/4;
}
// 返回选中的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0) {
        _hourStr = [self.hour objectAtIndex:row];
    
    } else {
        _minuteStr = [self.minute objectAtIndex:row];
    }
}
//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return component==0?self.hour[row]:self.minute[row];
}

- (IBAction)isAlert:(UISwitch *)sender {
    
    self.warnLabel.hidden=sender.on;

    if (self.hourStr&&self.minuteStr) {
        self.timeTF.text=[NSString stringWithFormat:@"%@:%@",self.hourStr,self.minuteStr];
    }else{
        if (self.hourStr) {
            self.timeTF.text=[NSString stringWithFormat:@"%@:00",self.hourStr];
        }
    }
    if (sender.on) {
        [self setUpLocalNotification:self.timeTF.text];
        [[SJDataManager manager]updateUserAlertSetting:1];
        [[SJDataManager manager]updateUserAlertTime:self.timeTF.text];
    }else{
        [[UIApplication sharedApplication]cancelAllLocalNotifications];
        [[SJDataManager manager]updateUserAlertSetting:0];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:NO];
    
    if (self.hourStr&&self.minuteStr) {
        self.timeTF.text=[NSString stringWithFormat:@"%@:%@",self.hourStr,self.minuteStr];
    }else{
        if (self.hourStr) {
            self.timeTF.text=[NSString stringWithFormat:@"%@:00",self.hourStr];
        }
    }
}

- (void)setUpLocalNotification:(NSString*)string{
  
    [[UIApplication sharedApplication]cancelAllLocalNotifications];
    // 1.创建通知
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    // 2.设置通知的必选参数 设置通知显示的内容
    localNotification.alertBody = @"小贝壳提醒:养成写日记的好习惯哦！";
    // 设置通知的发送时间
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss"];
    NSDate *date = [formatter dateFromString:[NSString stringWithFormat:@"%@:00",string]];
    localNotification.fireDate=date;
    localNotification.soundName=UILocalNotificationDefaultSoundName;
    localNotification.applicationIconBadgeNumber=1;
    localNotification.repeatInterval = kCFCalendarUnitDay;
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    // 3.发送通知
    // 方式一: 根据通知的发送时间(fireDate)发送通知
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    [MBProgressHUD showSuccess:@"设置成功"];
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
