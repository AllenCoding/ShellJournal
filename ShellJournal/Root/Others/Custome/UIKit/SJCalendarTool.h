//
//  SJCalendarTool.h
//  ShellJournal
//
//  Created by 刘勇 on 2017/6/12.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SJCalendarTool : NSObject



+ (NSInteger)day:(NSDate *)date;
+ (NSInteger)month:(NSDate *)date;
+ (NSInteger)year:(NSDate *)date;

+ (NSInteger)firstWeekdayInThisMonth:(NSDate *)date;
+ (NSInteger)totaldaysInMonth:(NSDate *)date;

+ (NSDate *)lastMonth:(NSDate *)date;
+ (NSDate*)nextMonth:(NSDate *)date;



@end
