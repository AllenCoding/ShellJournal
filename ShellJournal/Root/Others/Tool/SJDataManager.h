//
//  SJDataManager.h
//  ShellJournal
//
//  Created by 刘勇 on 2017/3/6.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SJDiaryModel.h"
#import "SJPerson.h"
#import "SJCountModel.h"
#import "SJProcessModel.h"
#import "SJSignModel.h"

@interface SJDataManager : NSObject

+(SJDataManager*)manager;

#pragma mark 日记

/**
 插入日记

 @param diary 日记模型
 */
-(void)insertDiaryWithDiaryModel:(SJDiaryModel*)diary;


/**
 显示所有的日记

 @return 返回包含日记模型的数组
 */
-(NSMutableArray*)showAllDiarys;

-(NSMutableArray*)showAllPictures;

-(NSMutableArray*)showAllTrashDiarys;

/**
 根据日记Id删除日记

 @param diaryId 日记Id
 */
-(void)deleteDiaryWithDiaryId:(NSInteger)diaryId;


/**
 逻辑删除

 @param diaryId diaryId
 */
-(void)disableDiaryWithDiaryId:(NSInteger)diaryId;

-(void)enableDiaryWithDiaryId:(NSInteger)diaryId;


#pragma mark 账号

/**
 注册账号

 @param person 账号
 */
-(void)registerAccountWithPerson:(SJPerson*)person;

/**
 当前登录人信息

 @return 当前登录人信息
 */
-(SJPerson*)currentInfo;

/**
 判断当前账号是否存在
 @param account 手机号
 @return YES/NO
 */
-(BOOL)isExist:(NSString*)account;

/**
 修改密码

 @param password 新密码
 @param account 账号
 */
-(void)updateUserPasswordWithNewPassWord:(NSString*)password personAccount:(NSString*)account;

/**
 修改个人昵称和个性签名

 @param nickName 昵称
 @param signature 个性签名
 */
-(void)updateNickName:(NSString*)nickName Signature:(NSString*)signature;

/**
 更新头像
 */
-(void)updateHead;
/*
 换头像
 */
-(void)updateUserHeadWithPersonImageName:(NSString *)imageName;

-(void)updateUserWeatherSetting:(NSInteger)boolWeather;

-(void)updateUserAddressSetting:(NSInteger)boolAddress;

-(void)updateUserImageSetting:(NSInteger)boolImage;

-(void)updateUserVoiceSetting:(NSInteger)boolVoice;

-(void)updateUserFingerSetting:(NSInteger)boolFinger;

-(void)updateUserPasswordSetting:(NSInteger)boolPassword;

-(void)updateUserAlertSetting:(NSInteger)boolAlert;

-(void)updateUserAlertTime:(NSString*)alertTime;

-(void)updateLevelWithDiaryStatus:(NSInteger)status;

-(void)updateLevelWithSign;

-(void)updateLevelWithShare;

/**
 更新用户安全码

 @param personcode <#personcode description#>
 */
-(void)updatePersonCode:(NSInteger)personcode;


/**
 新建一个倒计时任务

 @param countDownTask 倒计时任务
 */
-(void)addcountDownTaskWithModel:(SJCountModel*)countDownTask;

/**
 返回所有可以用的倒计时任务

 @return 数组
 */
-(NSMutableArray*)showAllCountDownTasks;


/**
 删除倒计时任务

 @param countId 任务Id
 */
-(void)deleteCountDownTaskWithCountId:(NSInteger)countId;



-(void)insertProcessWithProcessModel:(SJProcessModel*)process;

-(NSMutableArray*)getAllRecord;


-(void)insertSignWithSignModel:(SJSignModel*)sign;

-(NSMutableArray*)allSigns;

-(NSInteger)isSign;




@end
