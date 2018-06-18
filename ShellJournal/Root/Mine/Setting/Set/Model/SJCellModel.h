//
//  SJCellModel.h
//  ShellJournal
//
//  Created by 刘勇 on 2017/5/23.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SJCellModel : NSObject

@property(nonatomic,copy)NSString*leftText;
@property(nonatomic,assign)BOOL isSelected;

@property(nonatomic,strong)NSArray*weather;
@property(nonatomic,strong)NSArray*address;
@property(nonatomic,strong)NSArray*picture;
@property(nonatomic,strong)NSArray*voice;



@end
