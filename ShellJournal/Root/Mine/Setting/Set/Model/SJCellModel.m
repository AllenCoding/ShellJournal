//
//  SJCellModel.m
//  ShellJournal
//
//  Created by 刘勇 on 2017/5/23.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "SJCellModel.h"

@implementation SJCellModel
-(NSArray *)address{
        SJCellModel*model=[[SJCellModel alloc]init];
        model.leftText=@"显示地址";
        model.isSelected=[[SJDataManager manager]currentInfo].boolAddress;
        SJCellModel*model2=[[SJCellModel alloc]init];
        model2.leftText=@"不显示地址";
        model2.isSelected=!model.isSelected;
        _address=@[model,model2];
      return _address;
}

-(NSArray *)weather{
        SJCellModel*model=[[SJCellModel alloc]init];
        model.leftText=@"显示天气";
        model.isSelected=[[SJDataManager manager]currentInfo].boolWeather;
    
        SJCellModel*model2=[[SJCellModel alloc]init];
        model2.leftText=@"不显示天气";
        model2.isSelected=!model.isSelected;
    
        _weather=@[model,model2];
    return _weather;
}

-(NSArray *)picture{
    
        SJCellModel*model=[[SJCellModel alloc]init];
        model.leftText=@"允许无图";
        model.isSelected=[[SJDataManager manager]currentInfo].boolImage;
        SJCellModel*model2=[[SJCellModel alloc]init];
        model2.leftText=@"不允许无图";
        model2.isSelected=!model.isSelected;
        
        _picture=@[model,model2];
       return _picture;
}

-(NSArray *)voice{
    
        SJCellModel*model=[[SJCellModel alloc]init];
        model.leftText=@"支持语音日记";
        model.isSelected=[[SJDataManager manager]currentInfo].boolVoice;
    
        SJCellModel*model2=[[SJCellModel alloc]init];
        model2.leftText=@"不支持语音日记";
        model2.isSelected=!model.isSelected;
        _voice=@[model,model2];
    return _voice;
}


@end
