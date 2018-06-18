//
//  UILabel+Addition.h
//  DBZY
//
//  Created by 刘勇 on 2016/11/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Addition)


/**
 快速初始化一个label（实例方法）

 @param font 字体大小
 @param textColor 字体颜色
 @param textAlignment 文本位置
 @return 返回一个label
 */
- (instancetype)initWithFont:(UIFont *)font
                   textColor:(UIColor *)textColor
               textAlignment:(NSTextAlignment)textAlignment;

/**
 快速初始化一个label（类方法）
 
 @param font 字体大小
 @param textColor 字体颜色
 @param textAlignment 文本位置
 @return 返回一个label
 */

+ (instancetype)labelWithFont:(UIFont *)font
                    textColor:(UIColor *)textColor
                textAlignment:(NSTextAlignment)textAlignment;

/**
 返回富文本字典

 @param lineSpacing 间隔
 @param firstLineHeadIndent 缩进
 @param font 字体大小
 @param textColor 字体颜色
 @return 返回字典
 */
-(NSDictionary *)settingAttributesWithLineSpacing:(CGFloat)lineSpacing FirstLineHeadIndent:(CGFloat)firstLineHeadIndent Font:(UIFont *)font TextColor:(UIColor *)textColor;

/**
 实例化一个label

 @param frame frame
 @param contentStr 文本内容
 @param font 字体大小
 @param lineSpace 字体间隔
 @param textlengthSpace 字间距
 @param paragraphSpacing 段落间距
 @return 返回label
 */
+(UILabel *)getLineSpaceLabelWithFrame:(CGRect )frame contentString:(NSString*)contentStr withFont:(UIFont*)font withLineSpace:(CGFloat)lineSpace  textlengthSpace:(NSNumber* )textlengthSpace paragraphSpacing:(CGFloat)paragraphSpacing;

- (void)setTopAlignmentWithText:(NSString *)text maxHeight:(CGFloat)maxHeight;





@end
