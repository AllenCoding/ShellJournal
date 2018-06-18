//
//  SJSignModel.h
//  ShellJournal
//
//  Created by 刘勇 on 2017/6/12.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SJSignModel : NSObject

@property(nonatomic,assign)NSInteger signId;

@property(nonatomic,copy)NSString*signer;

@property(nonatomic,copy)NSString*signTime;

@property(nonatomic,assign)NSInteger day;

@property(nonatomic,assign)NSInteger isSign;


@end
