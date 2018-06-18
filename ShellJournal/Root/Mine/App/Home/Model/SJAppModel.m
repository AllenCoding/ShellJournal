//
//  SJAppModel.m
//  ShellJournal
//
//  Created by 刘勇 on 2017/6/1.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "SJAppModel.h"

@implementation SJAppModel


-(NSArray *)appArray{
    if (!_appArray) {
      
        SJAppModel*model=[[SJAppModel alloc]init];
        model.url=@"itms-apps://itunes.apple.com/app/id1156008023";
        model.titleText=@"项目管家";
        model.imageUrl=@"PM";
        
        SJAppModel*model1=[[SJAppModel alloc]init];
        model1.url=@"itms-apps://itunes.apple.com/app/id1171024095";
        model1.titleText=@"三级管理";
        model1.imageUrl=@"IS";

        SJAppModel*model2=[[SJAppModel alloc]init];
        model2.url=@"itms-apps://itunes.apple.com/app/id1114545861";
        model2.titleText=@"健康手环";
        model2.imageUrl=@"EAP";
        
        
        _appArray=@[model,model1,model2];
    }
    return _appArray;
    
}


@end
