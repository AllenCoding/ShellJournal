//
//  NSString+Addition.m
//  ShellJournal
//
//  Created by 刘勇 on 2017/3/24.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "NSString+Addition.h"

@implementation NSString (Addition)

+(NSString *)currentWeek{
    NSArray*weeks=@[[NSNull null],@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
    NSCalendar*calendar=[[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSTimeZone*zone=[[NSTimeZone alloc]initWithName:@"Asia/Beijing"];
    [calendar setTimeZone:zone];
    NSCalendarUnit calendarUint=NSCalendarUnitWeekday;
    NSDate *date=[NSDate date];
    NSDateComponents*com=[calendar components:calendarUint fromDate:date];
    return [weeks objectAtIndex:com.weekday];
}

+(NSString *)currentTime{
    NSDate*date=[NSDate date];
    NSDateFormatter*formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY年MM月dd日 HH:mm"];
    NSString*dateString=[formatter stringFromDate:date];
    return dateString;
}

+(NSInteger)currentMonth{
    
    NSDate*date=[NSDate date];
    NSDateFormatter*formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd月 HH:mm"];
    NSString*dateString=[formatter stringFromDate:date];
    NSInteger month=[dateString substringWithRange:NSMakeRange(5, 2)].integerValue;
    return month;
}

+(NSString *)now{
    NSDate*date=[NSDate date];
    NSDateFormatter*dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"YYYYMMddHHmmss"];
    NSString*dateStr=[dateFormatter stringFromDate:date];
    return dateStr;
}


+(NSInteger)currentDay{
    NSDate*date=[NSDate date];
    NSDateFormatter*dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"YYYYMMddHHmmss"];
    NSString*dateStr=[dateFormatter stringFromDate:date];
    NSString*day=[dateStr substringWithRange:NSMakeRange(6, 2)];
    
    return [day integerValue];

    
    
}


//是否是手机号
-(BOOL)isPhone{
    return [self match:@"^1[3578]\\d{9}$"];
    
}
- (BOOL)match:(NSString *)pattern { //创建正则表达式
    // 1.创建正则表达式
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    // 2.测试字符串
    NSArray *results = [regex matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    
    return results.count > 0;
}

/**
 *  邮箱地址是否合法
 */
-(BOOL)isEmailWithString:(NSString *)str{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:str];
}

// 判断国际手机号
- (BOOL)isGloabelNumberWithString:(NSString *)str {
    NSString *emailRegex = @"^\\d{6,12}$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:str];
    
}

// 判断手机号
- (BOOL)isValidateMobile:(NSString *)mobileNum {
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[0235-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else {
        return NO;
    }
}

+(NSString *)imageTransformWithArray:(NSMutableArray *)array{
    NSMutableArray*nameArray=[NSMutableArray array];
    for (int index=0; index<array.count; index++) {
        UIImage*image=array[index];
        NSData *picData = UIImageJPEGRepresentation(image, 0.5);
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *fileName = [NSString stringWithFormat:@"%@%ld.jpg", [formatter stringFromDate:[NSDate date]], (long)index];
        NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:fileName];
        [picData writeToFile:fullPath atomically:NO];
        [nameArray addObject:fileName];
    }
    NSString*name=[nameArray componentsJoinedByString:@","];
    return name;
}


+(NSString *)getLevelWithScore:(NSInteger)score{
    
    if (score>=0&&score<=10) {
        return @"贝壳宝宝";
    }else if (score>10&&score<=50){
        return @"大贝壳";
    }else if (score>50&&score<=100){
        return @"铁贝壳";
    }else if (score>100&&score<=200){
        return @"铜贝壳";
    }else if (score>200&&score<=500){
        return @"银贝壳";
    }else if (score>500&&score<=1000){
        return @"金贝壳";
    }else {
        return @"钻石贝壳";
    }
}

+(NSString *)randomString{
    
    NSInteger R = (arc4random() % 256);
    NSInteger G = (arc4random() % 256);
    NSInteger B = (arc4random() % 256);

    return [NSString stringWithFormat:@"%ld,%ld,%ld",R,G,B];
}






@end
