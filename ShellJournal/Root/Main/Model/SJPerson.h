//
//  SJPerson.h
//  ShellJournal
//
//  Created by 刘勇 on 2017/4/6.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SJPerson : NSObject

@property(nonatomic,assign)NSInteger personId;

@property(nonatomic,copy)NSString*personAccount;

@property(nonatomic,copy)NSString*personPassword;

@property(nonatomic,copy)NSString*personNickName;

@property(nonatomic,copy)NSString*personHeadImage;

@property(nonatomic,copy)NSString*personSignature;

@property(nonatomic,copy)NSString*personLevel;

@property(nonatomic,assign)NSInteger head;

@property(nonatomic,assign)NSInteger personcode;

@property(nonatomic,assign)NSInteger boolWeather;

@property(nonatomic,assign)NSInteger boolAddress;

@property(nonatomic,assign)NSInteger boolImage;

@property(nonatomic,assign)NSInteger boolVoice;

@property(nonatomic,assign)NSInteger boolfinger;

@property(nonatomic,assign)NSInteger boolpassword;

@property(nonatomic,assign)NSInteger boolalert;

@property(nonatomic,copy)NSString*alrtTime;




@end
