//
//  SJToolBarView.h
//  ShellJournal
//
//  Created by 刘勇 on 2017/3/7.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SJToolBarView : UIView

@property(nonatomic,copy)void(^myBlock)(NSInteger index);

-(instancetype)initToolBarViewWithFrame:(CGRect)frame btnImageNamesArray:(NSArray*)imageNames;

-(void)dismiss;

-(void)show;

@end
