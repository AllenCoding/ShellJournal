//
//  SJTypeModel.m
//  ShellJournal
//
//  Created by Tian on 2017/6/4.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "SJTypeModel.h"

@implementation SJTypeModel

-(NSArray *)dataArray{
    if (!_dataArray) {
        SJTypeModel*model=[[SJTypeModel alloc]init];
        model.iconUrl=@"type_life";
        model.title=@"日常生活";
        
        SJTypeModel*model2=[[SJTypeModel alloc]init];
        model2.iconUrl=@"type_love";
        model2.title=@"爱情纪念";

        SJTypeModel*model3=[[SJTypeModel alloc]init];
        model3.iconUrl=@"type_birthday";
        model3.title=@"生日纪念";

        SJTypeModel*model4=[[SJTypeModel alloc]init];
        model4.iconUrl=@"type_holiday";
        model4.title=@"度假旅游";

        SJTypeModel*model5=[[SJTypeModel alloc]init];
        model5.iconUrl=@"type_entertainment";
        model5.title=@"娱乐休闲";

        SJTypeModel*model6=[[SJTypeModel alloc]init];
        model6.iconUrl=@"type_study";
        model6.title=@"学习待办";

        SJTypeModel*model7=[[SJTypeModel alloc]init];
        model7.iconUrl=@"type_work";
        model7.title=@"工作事务";

        SJTypeModel*model8=[[SJTypeModel alloc]init];
        model8.iconUrl=@"type_event";
        model8.title=@"其他";

        _dataArray=@[model,model2,model3,model4,model5,model6,model7,model8];
    }
    return _dataArray;
}


@end
