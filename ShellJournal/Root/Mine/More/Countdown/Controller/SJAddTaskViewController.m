//
//  SJAddTaskViewController.m
//  ShellJournal
//
//  Created by Tian on 2017/6/3.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "SJAddTaskViewController.h"
#import "SJTypeListViewController.h"

@interface SJAddTaskViewController ()

@property (weak, nonatomic) IBOutlet UITextField *titleTF;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property(nonatomic,strong)UIDatePicker*datePicker;
@property(nonatomic,assign)NSInteger alertNum;


@end

@implementation SJAddTaskViewController

-(UIDatePicker *)datePicker{
    if (!_datePicker) {
        _datePicker=[[UIDatePicker alloc]initWithFrame:CGRectMake(0, ScreenHeight*2/3, ScreenWidth, ScreenHeight/3)];
        _datePicker.backgroundColor=kCommonBgColor;
        _datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        _datePicker.minimumDate=[NSDate date];
        _datePicker.date=[NSDate date];
    }
    return _datePicker;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDate*date=[NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString  *string = [[NSString alloc]init];
    string = [dateFormatter stringFromDate:date];
    self.timeLabel.text=[NSString stringWithFormat:@"%@",string];
    
    
}

- (IBAction)alertOffaneOn:(UISwitch *)sender {
    self.alertNum=sender.on?1:0;
}

- (IBAction)done:(id)sender {
   
    if (self.titleTF.text.length&&![self.typeLabel.text isEqualToString:@"点击选择"]) {
        SJCountModel*model=[[SJCountModel alloc]init];
        model.countAlert=self.alertNum;
        model.countTitle=self.titleTF.text;
        model.type=self.typeLabel.text;
        model.time=self.timeLabel.text;
        model.countTime=[self.datePicker.date timeIntervalSince1970];
        model.countCreater=userAccount;
        NSLog(@"%ld",(long)model.countTime);
        [[SJDataManager manager]addcountDownTaskWithModel:model];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"addTask" object:nil];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        if ([self.typeLabel.text isEqualToString:@"点击选择"]) {
            [MBProgressHUD showError:@"选择事项类型"];
        }else{
            [MBProgressHUD showError:@"标题不能为空"];

        }
    }
    
}

- (IBAction)close:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)tapType:(UITapGestureRecognizer *)sender {
    SJTypeListViewController*typelist=[[SJTypeListViewController alloc]init];
    typelist.typeBlock=^(SJTypeModel*model){
        self.typeLabel.text=model.title;
    };
    [self presentViewController:typelist animated:YES completion:nil];
}

- (IBAction)tapTime:(UITapGestureRecognizer *)sender {
    [self.view addSubview:self.datePicker];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    [self setTimeLabelText];
    [self.datePicker removeFromSuperview];
}

-(void)setTimeLabelText{
    NSDate *date = self.datePicker.date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString  *string = [[NSString alloc]init];
    string = [dateFormatter stringFromDate:date];
    self.timeLabel.text=string;
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
