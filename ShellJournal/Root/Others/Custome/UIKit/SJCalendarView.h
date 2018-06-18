//
//  SJCalendarView.h
//  ShellJournal
//
//  Created by 刘勇 on 2017/6/12.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SJCalendarTool.h"

@interface SJCalendarView : UIView

@property (nonatomic, strong) NSDate *date;

@property (nonatomic, copy) void(^calendarBlock)(NSInteger day, NSInteger month, NSInteger year);

@property (nonatomic,strong)  NSMutableArray *signArray;

//今天的Btn
@property (nonatomic,strong)  UIButton *dayButton;

- (void)setStyle_Today_Signed:(UIButton *)btn;

- (void)setStyle_Today:(UIButton *)btn;



@end
