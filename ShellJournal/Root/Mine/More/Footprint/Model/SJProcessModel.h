//
//  SJProcessModel.h
//  ShellJournal
//
//  Created by 刘勇 on 2017/6/9.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SJProcessModel : NSObject

@property(nonatomic,assign)NSInteger processId;
@property(nonatomic,copy)NSString*author;
@property(nonatomic,copy)NSString*processtime;
@property(nonatomic,copy)NSString*colorStr;
@property(nonatomic,copy)NSString*desc;
@property(nonatomic,copy)NSString*score;

@end
