//
//  SJMeModel.m
//  ShellJournal
//
//  Created by 刘勇 on 2017/4/10.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "SJMeModel.h"

@implementation SJMeModel

-(NSArray *)meArray{
    if (!_meArray) {
        
        SJMeModel*model=[[SJMeModel alloc]init];
        model.leftImageName=@"mine_information";
        model.leftText=@"我的资料";
        model.isShowAsscessory=YES;
        
        SJMeModel*model2=[[SJMeModel alloc]init];
        model2.leftImageName=@"mine_setting";
        model2.leftText=@"我的设置";
        model2.isShowAsscessory=YES;

        SJMeModel*model3=[[SJMeModel alloc]init];
        model3.leftImageName=@"mine_more";
        model3.leftText=@"更多功能";
        model3.isShowAsscessory=YES;
        
        SJMeModel*model4=[[SJMeModel alloc]init];
        model4.leftImageName=@"mine_about";
        model4.leftText=@"关于贝壳";
        model4.isShowAsscessory=YES;

        SJMeModel*model5=[[SJMeModel alloc]init];
        model5.leftImageName=@"mine_share";
        model5.leftText=@"分享贝壳";
        model5.isShowAsscessory=YES;
        
        SJMeModel*model6=[[SJMeModel alloc]init];
        model6.leftImageName=@"mine_app";
        model6.leftText=@"推荐更多";
        model6.isShowAsscessory=YES;

        _meArray=@[model,model2,model3,model4,model5,model6];
      
    }
    return _meArray;
}




@end
