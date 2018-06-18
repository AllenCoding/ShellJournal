//
//  SJWallView.h
//  ShellJournal
//
//  Created by 刘勇 on 2017/3/22.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SJWallDelegate <NSObject>

@end

@interface SJWallView : UIView

-(instancetype)initWallViewFrame:(CGRect)frame WithImageArrays:(NSArray*)array;


@end
