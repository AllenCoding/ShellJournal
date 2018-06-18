//
//  UIButton+Addition.h
//  DBZY
//
//  Created by 刘勇 on 2016/11/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Addition)

/**
 *  快速创建一个UIButton对象 通过给定的图片
 */
+ (instancetype)buttonWithImagename:(NSString *)imagename
                     hightImagename:(NSString *)hightImagename
                        bgImagename:(NSString *)bgImagename
                             target:(id)target
                             action:(SEL)action;

+ (instancetype)buttonWithTitle:(NSString *)title
                    normalColor:(UIColor *)normalColor
                  selectedColor:(UIColor *)selectedColor
                       fontSize:(CGFloat)fontSize
                         target:(id)target
                         action:(SEL)action;

+ (instancetype)buttonWithTitle:(NSString *)title
                    normalColor:(UIColor *)normalColor
                    diableColor:(UIColor *)diableColor
                       fontSize:(CGFloat)fontSize
                         target:(id)target
                         action:(SEL)action;


+ (instancetype)buttonWithTitle:(NSString *)title
                    normalColor:(UIColor *)normalColor
                  selectedColor:(UIColor *)selectedColor
                       fontSize:(CGFloat)fontSize
                     touchBlock:(void(^)())block;
/**
 *  快速创建一个UIButton对象 通过给定的图片
 */
+ (instancetype)buttonWithImagename:(NSString *)imagename
                     hightImagename:(NSString *)hightImagename
                        bgImagename:(NSString *)bgImagename
                         touchBlock:(void(^)())block;



@end
