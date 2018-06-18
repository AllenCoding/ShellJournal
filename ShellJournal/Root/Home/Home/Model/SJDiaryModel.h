//
//  SJDiaryModel.h
//  ShellJournal
//
//  Created by 刘勇 on 2017/3/6.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SJDiaryModel : NSObject

@property(nonatomic,assign)NSInteger diaryId;
@property(nonatomic,copy)NSString*imageName;
@property(nonatomic,copy)NSString*time;
@property(nonatomic,copy)NSString*week;
@property(nonatomic,copy)NSString*content;
@property(nonatomic,copy)NSString*backgroundImageName;
@property(nonatomic,copy)NSString*address;
@property(nonatomic,copy)NSString*weather;
@property(nonatomic,copy)NSString*author;
@property(nonatomic,copy)NSString*enable;


@end
