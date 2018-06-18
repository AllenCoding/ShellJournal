//
//  NSString+Addition.h
//  ShellJournal
//
//  Created by 刘勇 on 2017/3/24.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Addition)
/*获取当前星期*/
+(NSString*)currentWeek;
/*获取当前时间*/
+(NSString*)currentTime;

+(NSString*)now;
/*获取当前月份*/
+(NSInteger)currentMonth;
/*判断是手机号*/
-(BOOL)isPhone;
/**
 *  判断合法手机
 */
- (BOOL)isValidateMobile:(NSString *)mobileNum;
/**
 *  判断邮箱
 */
-(BOOL)isEmailWithString:(NSString *)str;

/**
 判断国际号
 
 @param str 字符串
 @return 是否
 */
-(BOOL)isGloabelNumberWithString:(NSString *)str;


//将图片数组转换成字符串
+(NSString*)imageTransformWithArray:(NSMutableArray*)array;


/**
 根据积分获取等级

 @param score <#score description#>
 @return <#return value description#>
 */
+(NSString*)getLevelWithScore:(NSInteger)score;



+(NSString*)randomString;

+(NSInteger)currentDay;



@end
