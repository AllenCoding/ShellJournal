//
//  SJCustomEmptyView.h
//  ShellJournal
//
//  Created by 刘勇 on 2017/3/6.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EmptyViewDelegate <NSObject>

#pragma mark 点击按钮的事件

@optional
-(void)didClickOnAction;

@end

@interface SJCustomEmptyView : UIView

@property(nonatomic,weak)id<EmptyViewDelegate>delegate;

-(instancetype)initEmptyViewWithBtnTitle:(NSString*)btnTitle;


@end
