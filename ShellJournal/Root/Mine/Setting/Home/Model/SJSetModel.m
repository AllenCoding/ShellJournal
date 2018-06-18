//
//  SJSetModel.m
//  ShellJournal
//
//  Created by 刘勇 on 2017/4/11.
//  Copyright © 2017年 liuyong. All rights reserved.


#import "SJSetModel.h"

@implementation SJSetModel

-(NSArray *)setArray{
        SJSetModel*model=[[SJSetModel alloc]init];
        model.leftText=@"账号安全";
        model.rightText=@"";
        model.centerText=@"";
        model.isHaveArrow=YES;

        SJSetModel*model2=[[SJSetModel alloc]init];
        model2.leftText=@"隐私安全";
        model2.rightText=@"";
        model2.centerText=@"";
        model2.isHaveArrow=YES;

        SJSetModel*model3=[[SJSetModel alloc]init];
        model3.leftText=@"天气情况";
        model3.rightText=[[SJDataManager manager]currentInfo].boolWeather?@"显示":@"不显示";
        model3.centerText=@"";
        model3.isHaveArrow=YES;


        SJSetModel*model4=[[SJSetModel alloc]init];
        model4.leftText=@"地址显示";
        model4.rightText=[[SJDataManager manager]currentInfo].boolAddress?@"显示":@"不显示";
        model4.centerText=@"";
        model4.isHaveArrow=YES;

        SJSetModel*model5=[[SJSetModel alloc]init];
        model5.leftText=@"图片日记";
        model5.centerText=@"";
        model5.isHaveArrow=YES;
        model5.rightText=[[SJDataManager manager]currentInfo].boolImage?@"允许":@"不允许";
    
        SJSetModel*model6=[[SJSetModel alloc]init];
        model6.leftText=@"语音日记";
        model6.centerText=@"";
        model6.isHaveArrow=YES;
        model6.rightText=[[SJDataManager manager]currentInfo].boolVoice?@"支持":@"不支持";

        SJSetModel*model7=[[SJSetModel alloc]init];
        model7.leftText=@"清除缓存";
        model7.centerText=@"";
        model7.rightText=@"";
        model7.isHaveArrow=NO;

        SJSetModel*model8=[[SJSetModel alloc]init];
        model8.leftText=@"";
        model8.centerText=@"退出登录";
        model8.rightText=@"";
        model8.isHaveArrow=NO;
    
        _setArray=@[model,model2,model3,model4,model5,model6,model7,model8];
    return _setArray;
}



@end
