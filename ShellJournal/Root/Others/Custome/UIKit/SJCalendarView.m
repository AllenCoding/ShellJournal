//
//  SJCalendarView.m
//  ShellJournal
//
//  Created by 刘勇 on 2017/6/12.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "SJCalendarView.h"

@implementation SJCalendarView
{
    UIButton  *_selectButton;
    NSMutableArray *_daysArray;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _daysArray = [NSMutableArray arrayWithCapacity:42];
        for (int i = 0; i < 42; i++) {
            UIButton *button = [[UIButton alloc] init];
            [self addSubview:button];
            [_daysArray addObject:button];
        }
    }
    return self;
}

#pragma mark - create View
- (void)setDate:(NSDate *)date{
    _date = date;
    [self createCalendarViewWith:date];
}

- (void)createCalendarViewWith:(NSDate *)date{
    
    CGFloat itemW     = self.frame.size.width / 7;
    CGFloat itemH     = self.frame.size.height / 7;
    
    // 1.year month
    UILabel *headlabel = [[UILabel alloc] init];
    headlabel.text     = [NSString stringWithFormat:@"%li年%li月",[SJCalendarTool year:date],[SJCalendarTool month:date]];
    headlabel.font     = [UIFont systemFontOfSize:18];
    headlabel.frame           = CGRectMake(0, 0, self.frame.size.width, itemH);
    headlabel.textAlignment   = NSTextAlignmentCenter;
    [self addSubview:headlabel];
    
    // 2.weekday
    NSArray *array = @[@"日", @"一", @"二", @"三", @"四", @"五", @"六"];
    
    UIView *weekBg = [[UIView alloc] init];
    weekBg.frame = CGRectMake(0, CGRectGetMaxY(headlabel.frame)+10, self.frame.size.width, 30);
    [self addSubview:weekBg];
    
    for (int i = 0; i < 7; i++) {
        UILabel *week = [[UILabel alloc] init];
        week.text     = array[i];
        week.font     = [UIFont systemFontOfSize:14];
        week.frame    = CGRectMake(itemW * i, 0, itemW, 32);
        week.textAlignment   = NSTextAlignmentCenter;
        week.backgroundColor = [UIColor clearColor];
        week.textColor       = [UIColor blackColor];
        [weekBg addSubview:week];
    }
    
    //  3.days (1-31)
    for (int i = 0; i < 42; i++) {
        int x = (i % 7) * itemW ;
        int y = (i / 7) * itemH + CGRectGetMaxY(weekBg.frame);
        
        UIButton *dayButton = _daysArray[i];
        dayButton.frame = CGRectMake(x, y, itemW, itemW);
        dayButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        dayButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        dayButton.layer.cornerRadius = itemW/2;
        dayButton.layer.masksToBounds=YES;
        
        [dayButton addTarget:self action:@selector(logDate:) forControlEvents:UIControlEventTouchUpInside];
        
        NSInteger daysInLastMonth = [SJCalendarTool totaldaysInMonth:[SJCalendarTool lastMonth:date]];
        NSInteger daysInThisMonth = [SJCalendarTool totaldaysInMonth:date];
        NSInteger firstWeekday    = [SJCalendarTool firstWeekdayInThisMonth:date];
        
        NSInteger day = 0;
        
        if (i < firstWeekday) {
            day = daysInLastMonth - firstWeekday + i + 1;
            [self setStyle_BeyondThisMonth:dayButton];
            
        }else if (i > firstWeekday + daysInThisMonth - 1){
            day = i + 1 - firstWeekday - daysInThisMonth;
            [self setStyle_BeyondThisMonth:dayButton];
            
        }else{
            day = i - firstWeekday + 1;
            [self setStyle_AfterToday:dayButton];
        }
        
        [dayButton setTitle:[NSString stringWithFormat:@"%li", day] forState:UIControlStateNormal];
        
        // this month
        if ([SJCalendarTool month:date] == [SJCalendarTool month:[NSDate date]]) {
            
            NSInteger todayIndex = [SJCalendarTool day:date] + firstWeekday - 1;
            
            if (i < todayIndex && i >= firstWeekday) {
                [self setStyle_BeforeToday:dayButton];
                [self setSign:i andBtn:dayButton];
            }else if(i ==  todayIndex){
                [self setStyle_Today:dayButton];
                _dayButton = dayButton;
            }
        }
    }
}

#pragma mark 设置已经签到
- (void)setSign:(int)i andBtn:(UIButton*)dayButton{
    [_signArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        //        int now = i-4+1;
        int now=i-3;
        int now2 = [obj intValue];
        if (now2== now) {
            [self setStyle_SignEd:dayButton];
        }
    }];
}


#pragma mark - output date
-(void)logDate:(UIButton *)dayBtn{
    
//    _selectButton.selected = NO;
//    dayBtn.selected = YES;
//    _selectButton = dayBtn;
    
    NSInteger day = [[dayBtn titleForState:UIControlStateNormal] integerValue];
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self.date];
    
    if (self.calendarBlock) {
        self.calendarBlock(day, [comp month], [comp year]);
    }
}


#pragma mark - date button style
//设置不是本月的日期字体颜色   ---白色  看不到
- (void)setStyle_BeyondThisMonth:(UIButton *)btn{
    btn.enabled = NO;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

//这个月今日之前的日期的状态（含签到和未签到的）
- (void)setStyle_BeforeToday:(UIButton *)btn{
    btn.enabled = NO;
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
}

//今日已签到状态
- (void)setStyle_Today_Signed:(UIButton *)btn{
    
    btn.enabled = NO;
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor whiteColor]];
    
}
//今日没签到的状态
- (void)setStyle_Today:(UIButton *)btn{
    if ([[SJDataManager manager]isSign]) {
        btn.enabled = YES;
        [btn setTitleColor:kRedColor forState:UIControlStateNormal];
        [btn setBackgroundColor:kWhiteColor];
    }else{
        btn.enabled = YES;
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setBackgroundColor:kCommonBgColor];
    }
}

//这个月 今天之后的日期未签到
- (void)setStyle_AfterToday:(UIButton *)btn{
    btn.enabled = NO;
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

//已经签过的 日期style
- (void)setStyle_SignEd:(UIButton *)btn{
    btn.enabled = NO;
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
