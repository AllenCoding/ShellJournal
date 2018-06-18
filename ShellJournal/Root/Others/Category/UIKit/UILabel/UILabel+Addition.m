//
//  UILabel+Addition.m
//  DBZY
//
//  Created by 刘勇 on 2016/11/21.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "UILabel+Addition.h"

@implementation UILabel (Addition)

- (instancetype)initWithFont:(UIFont *)font
                   textColor:(UIColor *)textColor
               textAlignment:(NSTextAlignment)textAlignment {
    if (self = [super init]) {
        self.font = font;
        self.textAlignment = textAlignment ? textAlignment : NSTextAlignmentLeft;
        self.textColor = textColor;
    }
    return self;
}

+ (instancetype)labelWithFont:(UIFont *)font
                    textColor:(UIColor *)textColor
                textAlignment:(NSTextAlignment)textAlignment {
    return [[UILabel alloc] initWithFont:font textColor:textColor textAlignment:textAlignment];
}



-(NSDictionary *)settingAttributesWithLineSpacing:(CGFloat)lineSpacing FirstLineHeadIndent:(CGFloat)firstLineHeadIndent Font:(UIFont *)font TextColor:(UIColor *)textColor{
    //分段样式
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //行间距
    paragraphStyle.lineSpacing = lineSpacing;
    //首行缩进
    paragraphStyle.firstLineHeadIndent = firstLineHeadIndent;
    
    //富文本样式
    NSDictionary *attributeDic = @{
                                   NSFontAttributeName : font,
                                   NSParagraphStyleAttributeName : paragraphStyle,
                                   NSForegroundColorAttributeName : textColor
                                   };
    return attributeDic;
}

+(UILabel *)getLineSpaceLabelWithFrame:(CGRect)frame contentString:(NSString *)contentStr withFont:(UIFont *)font withLineSpace:(CGFloat)lineSpace textlengthSpace:(NSNumber *)textlengthSpace paragraphSpacing:(CGFloat)paragraphSpacing{
    
    UILabel  *lab = [[UILabel alloc] init];
    lab.font = font;
    lab.text=contentStr;
    lab.adjustsFontSizeToFitWidth=YES;
    lab.textColor=kBlackColor;
    lab.textAlignment = NSTextAlignmentLeft;
    lab.numberOfLines = 0;
    NSDictionary *attributeDict  = [self setTextLineSpaceWithString:contentStr withFont:font withLineSpace:lineSpace  withTextlengthSpace:textlengthSpace paragraphSpacing:paragraphSpacing];
    CGSize size = [contentStr boundingRectWithSize:frame.size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributeDict context:nil].size;
    CGFloat sizeHeight = size.height;
    lab.frame =  CGRectMake(frame.origin.x,frame.origin.y, frame.size.width, sizeHeight);
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:contentStr attributes:attributeDict];
    lab.attributedText = attributedString;
    return lab;
    
}


+(NSDictionary *)setTextLineSpaceWithString:(NSString*)str withFont:(UIFont*)font withLineSpace:(CGFloat)lineSpace withTextlengthSpace:(NSNumber *)textlengthSpace paragraphSpacing:(CGFloat)paragraphSpacing{
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    
    paraStyle.alignment = NSTextAlignmentLeft;
    
    paraStyle.lineSpacing = lineSpace;
    
    paraStyle.hyphenationFactor = 1.0;
    
    paraStyle.firstLineHeadIndent = 10.0;
    
    paraStyle.paragraphSpacingBefore = 0.0;
    
    paraStyle.headIndent = 0;
    
    paraStyle.tailIndent = 0;
    
    NSDictionary *dic = @{NSFontAttributeName:font,
                          
                          NSParagraphStyleAttributeName:paraStyle,
                          
                          NSKernAttributeName:textlengthSpace
                          
                          };
    
    return dic;
    
}

- (void)setTopAlignmentWithText:(NSString *)text maxHeight:(CGFloat)maxHeight
{
    CGRect frame = self.frame;
    CGSize size = [text sizeWithFont:self.font constrainedToSize:CGSizeMake(frame.size.width, maxHeight)];
    
    
    frame.size = CGSizeMake(frame.size.width, size.height);
    self.frame = frame;
    self.text = text;
}





@end
