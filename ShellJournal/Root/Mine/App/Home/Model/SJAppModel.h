//
//  SJAppModel.h
//  ShellJournal
//
//  Created by 刘勇 on 2017/6/1.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SJAppModel : NSObject

@property(nonatomic,copy)NSString*url;
@property(nonatomic,copy)NSString*titleText;
@property(nonatomic,copy)NSString*imageUrl;

@property(nonatomic,strong)NSArray*appArray;




@end
