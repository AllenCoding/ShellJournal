//
//  SJMeModel.h
//  ShellJournal
//
//  Created by 刘勇 on 2017/4/10.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SJMeModel : NSObject

@property(nonatomic,copy)NSString*leftImageName;
@property(nonatomic,copy)NSString*leftText;
@property(nonatomic,copy)NSString*centerText;
@property(nonatomic,copy)NSString*rightImageName;
@property(nonatomic,assign)BOOL isShowAsscessory;

@property(nonatomic,strong)NSArray*meArray;

@end
