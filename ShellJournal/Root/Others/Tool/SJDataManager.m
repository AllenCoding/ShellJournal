//
//  SJDataManager.m
//  ShellJournal
//
//  Created by 刘勇 on 2017/3/6.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "SJDataManager.h"

@interface SJDataManager(){
    
    FMDatabase*database;
}
@end

static SJDataManager*manager=nil;

@implementation SJDataManager

+(SJDataManager *)manager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager=[[SJDataManager alloc]init];
    });
    return manager;
}
-(instancetype)init{
    if (self=[super init]) {
        [self openData];
    }
    return self;
}

-(void)openData{
    NSString*path=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString*dbPath=[path stringByAppendingPathComponent:@"data.db"];
    database=[FMDatabase databaseWithPath:dbPath];
    [database open];
     NSString*diarySql=@"create table if not exists diary(diaryId integer primary key autoincrement,time text,address text,content text,week text,backgroundImageName text,imageName text,weather text,author text,enable text)";
    
    NSString*personSql=@"create table if not exists person(personId integer primary key autoincrement,personAccount text,personNickName text,personHeadImage text,personSignature text,personLevel text,personPassword text,head integer,personcode integer,weather integer,address integer,image integer,voice integer,finger integer,password integer,alerttime text,alert integer)";
    
    NSString*taskSql=@"create table if not exists task(taskId integer primary key autoincrement,tasktitle text,tasktime integer,taskcreater text,taskalert integer,type text,time text)";
    
    NSString*processSql=@"create table if not exists process(processId integer primary key autoincrement,author text,processtime text,colorStr text,desc text,score text)";
    
    NSString*signSql=@"create table if not exists sign(signId integer primary key autoincrement,signer text,signtime text,signday integer,isSign integer)";

    
    
    [database executeUpdate:diarySql];
    [database executeUpdate:personSql];
    [database executeUpdate:taskSql];
    [database executeUpdate:processSql];
    BOOL isOk=[database executeUpdate:signSql];

    if (isOk) {
        NSLog(@"签到表成功");
    }else{
        NSLog(@"签到表失败");
    }
}



#pragma mark 签到记录

-(void)insertSignWithSignModel:(SJSignModel *)sign{
    NSString*add_sql=@"insert into sign (signer,signtime,signday,isSign) values(?,?,?,?)";
    BOOL Ok=[database executeUpdate:add_sql,sign.signer,sign.signTime,@(sign.day),@(sign.isSign)];
    if (Ok) {
        NSLog(@"添加签到成功");
    }else{
        NSLog(@"添加签到失败");
    }
}

-(NSMutableArray *)allSigns{
    NSString*selectall=@"select *from sign  where signer = ? order by signId desc";
    FMResultSet *set=[database executeQuery:selectall,userAccount];
    NSMutableArray*data=[NSMutableArray new];
    while ([set next]) {
        SJSignModel*sign=[[SJSignModel alloc]init];
        sign.signId=[set stringForColumn:@"signId"].integerValue;
        sign.day=[set stringForColumn:@"signday"].integerValue;
        sign.signer=[set stringForColumn:@"signer"];
        sign.signTime=[set stringForColumn:@"signtime"];
        sign.isSign=[set stringForColumn:@"isSign"].integerValue;
    
        [data addObject:sign];
    }
    return data;
}

-(void)updateLevelWithSign{
    
    NSString*updateLevel=@"update person set personLevel=?  where personAccount=?";
    NSString*string=[NSString stringWithFormat:@"%ld",[[self currentInfo].personLevel integerValue]+3];
    BOOL isSS = [database executeUpdate:updateLevel,string,userAccount];
    if (isSS) {
        NSLog(@"等级成功");
    }else{
        NSLog(@"等级失败");
    }
}

-(NSInteger)isSign{
    NSString*selectoday=@"select *from sign  where signer = ? and signday=?";
    FMResultSet *set=[database executeQuery:selectoday,userAccount,@([NSString currentDay])];
    NSMutableArray*data=[NSMutableArray new];
    while ([set next]) {
        SJSignModel*sign=[[SJSignModel alloc]init];
        sign.signId=[set stringForColumn:@"signId"].integerValue;
        sign.day=[set stringForColumn:@"signday"].integerValue;
        sign.signer=[set stringForColumn:@"signer"];
        sign.signTime=[set stringForColumn:@"signtime"];
        sign.isSign=[set stringForColumn:@"isSign"].integerValue;
        [data addObject:sign];
    }
    return data.count>0?1:0;
}




#pragma mark 操作记录

-(void)insertProcessWithProcessModel:(SJProcessModel*)process{
     NSString*add_sql=@"insert into process (author,processtime,colorStr,desc,score) values(?,?,?,?,?)";
    BOOL Ok=[database executeUpdate:add_sql,process.author,process.processtime,process.colorStr,process.desc,process.score];
    if (Ok) {
        NSLog(@"添加成功");
    }else{
        NSLog(@"添加失败");
    }
}

-(NSMutableArray*)getAllRecord{
    NSString*selectall=@"select *from process  where author = ? order by processId desc";
    FMResultSet *set=[database executeQuery:selectall,userAccount];
    NSMutableArray*data=[NSMutableArray new];
    while ([set next]) {
        SJProcessModel*process=[[SJProcessModel alloc]init];
        process.processId=[set stringForColumn:@"processId"].integerValue;
        process.author=[set stringForColumn:@"author"];
        process.processtime=[set stringForColumn:@"processtime"];
        process.colorStr=[set stringForColumn:@"colorStr"];
        process.score=[set stringForColumn:@"score"];
        process.desc=[set stringForColumn:@"desc"];
        [data addObject:process];
    }
    return data;
}

#pragma mark 日记部分

-(void)insertDiaryWithDiaryModel:(SJDiaryModel *)diary{
    NSString*addDiary_sql=@"insert into diary (time,address,content,week,imageName,backgroundImageName,weather,author,enable) values(?,?,?,?,?,?,?,?,?)";
    BOOL isOk=[database executeUpdate:addDiary_sql,diary.time,diary.address,diary.content,diary.week,diary.imageName,diary.backgroundImageName,diary.weather,diary.author,diary.enable];
    if (isOk) {
        NSLog(@"插入成功");
    }else{
        NSLog(@"插入失败");
    }
}

-(void)disableDiaryWithDiaryId:(NSInteger)diaryId{
    NSString*enable_update=@"update diary set enable = '0' where diaryId=?";
    BOOL isSS = [database executeUpdate:enable_update,@(diaryId)];
    if (isSS) {
        NSLog(@"加锁成功");
    }else{
        NSLog(@"加锁失败");
    }
}

-(void)enableDiaryWithDiaryId:(NSInteger)diaryId{
    NSString*enable_update=@"update diary set enable = '1' where diaryId=?";
    BOOL isSS = [database executeUpdate:enable_update,@(diaryId)];
    if (isSS) {
        NSLog(@"解锁成功");
    }else{
        NSLog(@"解锁失败");
    }
}


-(void)deleteDiaryWithDiaryId:(NSInteger)diaryId{
    NSString*sql_delete=@"delete from diary where diaryId= ?";
    BOOL isOk= [database executeUpdate:sql_delete,@(diaryId)];
    if (isOk) {
        NSLog(@"删除成功");
    }else{
        NSLog(@"删除失败");
    }
}

-(NSMutableArray *)showAllDiarys{
    NSString*selectall=@"select *from diary  where author = ? and enable='1' order by diaryId desc";
    FMResultSet *set=[database executeQuery:selectall,userAccount];
    NSMutableArray*data=[NSMutableArray new];
    while ([set next]) {
        SJDiaryModel*diary=[[SJDiaryModel alloc]init];
        diary.diaryId=[set stringForColumn:@"diaryId"].integerValue;
        diary.time=[set stringForColumn:@"time"];
        diary.address=[set stringForColumn:@"address"];
        diary.content=[set stringForColumn:@"content"];
        diary.week=[set stringForColumn:@"week"];
        diary.imageName=[set stringForColumn:@"imageName"];
        diary.backgroundImageName=[set stringForColumn:@"backgroundImageName"];
        diary.weather=[set stringForColumn:@"weather"];
        diary.author=[set stringForColumn:@"author"];
        diary.enable=[set stringForColumn:@"enable"];
        [data addObject:diary];
    }
    return data;
}

-(NSMutableArray*)showAllTrashDiarys{
    NSString*selectall=@"select *from diary  where author = ? and enable='0' order by diaryId desc";
    FMResultSet *set=[database executeQuery:selectall,userAccount];
    NSMutableArray*data=[NSMutableArray new];
    while ([set next]) {
        SJDiaryModel*diary=[[SJDiaryModel alloc]init];
        diary.diaryId=[set stringForColumn:@"diaryId"].integerValue;
        diary.time=[set stringForColumn:@"time"];
        diary.address=[set stringForColumn:@"address"];
        diary.content=[set stringForColumn:@"content"];
        diary.week=[set stringForColumn:@"week"];
        diary.imageName=[set stringForColumn:@"imageName"];
        diary.backgroundImageName=[set stringForColumn:@"backgroundImageName"];
        diary.weather=[set stringForColumn:@"weather"];
        diary.author=[set stringForColumn:@"author"];
        diary.enable=[set stringForColumn:@"enable"];
        [data addObject:diary];
    }
    return data;
    
}



-(NSMutableArray *)showAllPictures{
    NSString*selectall=@"select * from diary  where author = ? and enable='1'  and imageName is not null order by diaryId desc";
    FMResultSet *set=[database executeQuery:selectall,userAccount];
    NSMutableArray*data=[NSMutableArray new];
    while ([set next]) {
        SJDiaryModel*diary=[[SJDiaryModel alloc]init];
        diary.diaryId=[set stringForColumn:@"diaryId"].integerValue;
        diary.time=[set stringForColumn:@"time"];
        diary.address=[set stringForColumn:@"address"];
        diary.content=[set stringForColumn:@"content"];
        diary.week=[set stringForColumn:@"week"];
        diary.imageName=[set stringForColumn:@"imageName"];
        diary.backgroundImageName=[set stringForColumn:@"backgroundImageName"];
        diary.weather=[set stringForColumn:@"weather"];
        diary.author=[set stringForColumn:@"author"];
        diary.enable=[set stringForColumn:@"enable"];
        [data addObject:diary];
    }
    return data;
}

#pragma mark 人员部分

-(void)registerAccountWithPerson:(SJPerson *)person{
    NSString*addperson_sql=@"insert into person (personAccount,personNickName,personHeadImage,personSignature,personLevel,personPassword,head,personcode,weather,address,image,voice,finger,password,alerttime,alert) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
    BOOL isOk=[database executeUpdate:addperson_sql,person.personAccount,person.personNickName,person.personHeadImage,person.personSignature,person.personLevel,person.personPassword,@(person.head),@(person.personcode),@(person.boolWeather),@(person.boolAddress),@(person.boolImage),@(person.boolVoice),@(person.boolfinger),@(person.boolpassword),person.alrtTime,@(person.boolalert)];
    if (isOk) {
        NSLog(@"注册成功");
    }else{
        NSLog(@"注册失败");
    }
}

-(SJPerson *)currentInfo{
    NSString*selectSql=@"select *from person where personAccount=?";
    FMResultSet *set=[database executeQuery:selectSql,userAccount];
    SJPerson*person=[[SJPerson alloc]init];
    while ([set next]) {
        person.personId=[set stringForColumn:@"personId"].integerValue;
        person.personAccount=[set stringForColumn:@"personAccount"];
        person.personNickName=[set stringForColumn:@"personNickName"];
        person.personHeadImage=[set stringForColumn:@"personHeadImage"];
        person.personSignature=[set stringForColumn:@"personSignature"];
        person.personLevel=[set stringForColumn:@"personLevel"];
        person.personPassword=[set stringForColumn:@"personPassword"];
        person.head=[set stringForColumn:@"head"].integerValue;
        person.personcode=[set stringForColumn:@"personcode"].integerValue;
        person.boolWeather=[set stringForColumn:@"weather"].integerValue;
        person.boolAddress=[set stringForColumn:@"address"].integerValue;
        person.boolImage=[set stringForColumn:@"image"].integerValue;
        person.boolVoice=[set stringForColumn:@"voice"].integerValue;
        person.boolfinger=[set stringForColumn:@"finger"].integerValue;
        person.boolpassword=[set stringForColumn:@"password"].integerValue;
        person.alrtTime=[set stringForColumn:@"alerttime"];
        person.boolalert=[set stringForColumn:@"alert"].integerValue;
    }
    return person;
}

-(BOOL)isExist:(NSString *)account{
    NSString*selectSql=@"select *from person where personAccount=?";
    FMResultSet *set=[database executeQuery:selectSql,account];
    SJPerson*person=[[SJPerson alloc]init];
    while ([set next]) {
        person.personId=[set stringForColumn:@"personId"].integerValue;
        person.personAccount=[set stringForColumn:@"personAccount"];
        person.personNickName=[set stringForColumn:@"personNickName"];
        person.personHeadImage=[set stringForColumn:@"personHeadImage"];
        person.personSignature=[set stringForColumn:@"personSignature"];
        person.personLevel=[set stringForColumn:@"personLevel"];
        person.personPassword=[set stringForColumn:@"personPassword"];
        person.head=[set stringForColumn:@"head"].integerValue;
        person.personcode=[set stringForColumn:@"personcode"].integerValue;
        person.boolWeather=[set stringForColumn:@"weather"].integerValue;
        person.boolAddress=[set stringForColumn:@"address"].integerValue;
        person.boolImage=[set stringForColumn:@"image"].integerValue;
        person.boolVoice=[set stringForColumn:@"voice"].integerValue;
        person.boolfinger=[set stringForColumn:@"finger"].integerValue;
        person.boolpassword=[set stringForColumn:@"password"].integerValue;
        person.alrtTime=[set stringForColumn:@"alerttime"];
        person.boolalert=[set stringForColumn:@"alert"].integerValue;
        
    }
    BOOL isExist=person.personId==0?NO:YES;
    return isExist;
}
-(void)updateUserPasswordWithNewPassWord:(NSString*)password personAccount:(NSString*)account{
    NSString*psw_update=@"update person set personPassword = ? where personAccount=?";
    BOOL isSS = [database executeUpdate:psw_update,password,account];
    if (isSS) {
        NSLog(@"用户密码修改成功");
    }else{
        NSLog(@"用户密码修改失败");
    }
}
-(void)updateNickName:(NSString *)nickName Signature:(NSString *)signature{
    NSString*updateSql=@"update person set personNickName = ?,personSignature= ? where personAccount=?";
    BOOL isSS = [database executeUpdate:updateSql,nickName,signature,userAccount];
    if (isSS) {
        NSLog(@"信息修改成功");
    }else{
        NSLog(@"信息修改失败");
    }
}

-(void)updateHead{
    NSString*updateSql=@"update person set head = ?  where personAccount=?";
    BOOL isSS = [database executeUpdate:updateSql,@1,userAccount];
    if (isSS) {
        NSLog(@"头像修改成功");
    }else{
        NSLog(@"头像修改失败");
    }
}

-(void)updateUserHeadWithPersonImageName:(NSString *)imageName{
    NSString*updateImage=@"update person set personHeadImage=?  where personAccount=?";
    BOOL isSS = [database executeUpdate:updateImage,imageName,userAccount];
    if (isSS) {
        NSLog(@"头像成功");
    }else{
        NSLog(@"头像失败");
    }
}

-(void)updateUserVoiceSetting:(NSInteger)boolVoice{
    NSString*updateImage=@"update person set voice =?  where personAccount=?";
    BOOL isSS = [database executeUpdate:updateImage,@(boolVoice),userAccount];
    if (isSS) {
        NSLog(@"声音成功");
    }else{
        NSLog(@"声音失败");
    }


}

-(void)updateUserImageSetting:(NSInteger)boolImage{
    NSString*updateImage=@"update person set image=?  where personAccount=?";
    BOOL isSS = [database executeUpdate:updateImage,@(boolImage),userAccount];
    if (isSS) {
        NSLog(@"天气成功");
    }else{
        NSLog(@"天气失败");
    }

}

-(void)updateUserAddressSetting:(NSInteger)boolAddress{
    NSString*updateImage=@"update person set address=?  where personAccount=?";
    BOOL isSS = [database executeUpdate:updateImage,@(boolAddress),userAccount];
    if (isSS) {
        NSLog(@"地址成功");
    }else{
        NSLog(@"地址失败");
    }

}

-(void)updateUserWeatherSetting:(NSInteger)boolWeather{
    NSString*updateImage=@"update person set weather=?  where personAccount=?";
    BOOL isSS = [database executeUpdate:updateImage,@(boolWeather),userAccount];
    if (isSS) {
        NSLog(@"天气成功");
    }else{
        NSLog(@"天气失败");
    }
}

-(void)updateUserFingerSetting:(NSInteger)boolFinger{
    NSString*updateImage=@"update person set finger=?  where personAccount=?";
    BOOL isSS = [database executeUpdate:updateImage,@(boolFinger),userAccount];
    if (isSS) {
        NSLog(@"指纹成功");
    }else{
        NSLog(@"指纹失败");
    }

}

-(void)updateUserPasswordSetting:(NSInteger)boolPassword{
    NSString*updateImage=@"update person set password=?  where personAccount=?";
    BOOL isSS = [database executeUpdate:updateImage,@(boolPassword),userAccount];
    if (isSS) {
        NSLog(@"口令成功");
    }else{
        NSLog(@"口令失败");
    }

}


-(void)updatePersonCode:(NSInteger)personcode{
    NSString*codeSql=@"update person set personcode=? where personAccount=?";
    BOOL isSS = [database executeUpdate:codeSql,@(personcode),userAccount];
    if (isSS) {
        NSLog(@"安全码修改成功");
    }else{
        NSLog(@"安全码改失败");
    }
}

-(void)updateUserAlertSetting:(NSInteger)boolAlert{
    NSString*codeSql=@"update person set alert=? where personAccount=?";
    BOOL isSS = [database executeUpdate:codeSql,@(boolAlert),userAccount];
    if (isSS) {
        NSLog(@"通知修改成功");
    }else{
        NSLog(@"通知修改失败");
    }
}

-(void)updateUserAlertTime:(NSString *)alertTime{
    NSString*updateImage=@"update person set alerttime=?  where personAccount=?";
    BOOL isSS = [database executeUpdate:updateImage,alertTime,userAccount];
    if (isSS) {
        NSLog(@"时间成功");
    }else{
        NSLog(@"时间失败");
    }
}

-(void)updateLevelWithDiaryStatus:(NSInteger)status{
    NSString*updateLevel=@"update person set personLevel=?  where personAccount=?";
    NSInteger num=status?2:-3;
    NSString*string=[NSString stringWithFormat:@"%ld",[[self currentInfo].personLevel integerValue]+num];
    BOOL isSS = [database executeUpdate:updateLevel,string,userAccount];
    if (isSS) {
        NSLog(@"等级成功");
    }else{
        NSLog(@"等级失败");
    }
}




#pragma mark 倒计时任务部分

-(void)addcountDownTaskWithModel:(SJCountModel *)countDownTask{
    NSString*newSql=@"insert into task(tasktitle,tasktime,taskcreater,taskalert,type,time) values(?,?,?,?,?,?)";
     BOOL isOk=[database executeUpdate:newSql,countDownTask.countTitle,@(countDownTask.countTime),countDownTask.countCreater,@(countDownTask.countAlert),countDownTask.type,countDownTask.time];
    if (isOk) {
             NSLog(@"插入成功");
    }else{
            NSLog(@"插入成功");
    }
}

-(NSMutableArray *)showAllCountDownTasks{
    NSString*selectall=@"select * from task  where taskcreater = ? order by tasktime asc";
    FMResultSet *set=[database executeQuery:selectall,userAccount];
    NSMutableArray*data=[NSMutableArray new];
    while ([set next]) {
        SJCountModel*task=[[SJCountModel alloc]init];
        task.countId=[set stringForColumn:@"taskId"].integerValue;
        task.countTitle=[set stringForColumn:@"tasktitle"];
        task.countTime=[set stringForColumn:@"tasktime"].integerValue;
        task.countCreater=[set stringForColumn:@"taskcreater"];
        task.countAlert=[set stringForColumn:@"taskalert"].integerValue;
        task.type=[set stringForColumn:@"type"];
        task.time=[set stringForColumn:@"time"];

        [data addObject:task];
    }
    return data;
}

-(void)deleteCountDownTaskWithCountId:(NSInteger)countId{
    NSString*sql_delete=@"delete from task where taskId= ?";
    BOOL isOk= [database executeUpdate:sql_delete,@(countId)];
    if (isOk) {
        NSLog(@"删除成功");
    }else{
        NSLog(@"删除失败");
    }
}






@end
