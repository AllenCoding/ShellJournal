//
//  SJKeyBoardView.h
//  ShellJournal
//
//  Created by 刘勇 on 2017/5/26.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SJKeyBoardDelegate <NSObject>

/**
 输入结束后

 @param password 输入的文本
 */

@required

-(void)didFinishInputText:(NSString*)password;

@end

@interface SJKeyBoardView : UIView

@property(nonatomic,assign)NSInteger passwordLength;

@property(nonatomic,weak)id<SJKeyBoardDelegate>delegate;

-(instancetype)initWithFrame:(CGRect)frame;



@end
