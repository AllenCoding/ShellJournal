//
//  UIColor+Addition.m
//  ShellJournal
//
//  Created by 刘勇 on 2017/6/9.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "UIColor+Addition.h"

@implementation UIColor (Addition)

+(UIColor*)ColorWithString:(NSString*)colorStr{
    NSArray*colors=[colorStr componentsSeparatedByString:@","];
    CGFloat R=[colors[0] floatValue];
    CGFloat G=[colors[1] floatValue];
    CGFloat B=[colors[2] floatValue];
    return kColorWithRGB(R, G, B);
}

@end
