//
//  SJSetModel.h
//  ShellJournal
//
//  Created by 刘勇 on 2017/4/11.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SJSetModel : NSObject
@property(nonatomic,copy)NSString*leftText;
@property(nonatomic,copy)NSString*centerText;
@property(nonatomic,copy)NSString*rightText;
@property(nonatomic,assign)BOOL isHaveArrow;
@property(nonatomic,strong)NSArray*setArray;

@end
