//
//  SJCountModel.h
//  ShellJournal
//
//  Created by Tian on 2017/6/3.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SJCountModel : NSObject

@property(nonatomic,assign)NSInteger countId;
@property(nonatomic,assign)NSInteger countAlert;
@property(nonatomic,copy)NSString*countTitle;
@property(nonatomic,assign)NSInteger countTime;
@property(nonatomic,copy)NSString*countCreater;
@property(nonatomic,copy)NSString*type;
@property(nonatomic,copy)NSString*time;



@end
