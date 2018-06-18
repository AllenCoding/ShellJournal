//
//  CALayer+Addition.m
//  ShellJournal
//
//  Created by 刘勇 on 2017/4/5.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "CALayer+Addition.h"

@implementation CALayer (Addition)

- (void)setBorderColorWithUIColor:(UIColor *)color{
    self.borderColor = color.CGColor;
}

@end
