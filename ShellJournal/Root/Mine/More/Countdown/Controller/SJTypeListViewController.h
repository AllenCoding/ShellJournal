//
//  SJTypeListViewController.h
//  ShellJournal
//
//  Created by Tian on 2017/6/4.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SJTypeModel.h"

typedef void(^SelectedTypeBlock)(SJTypeModel *model);

@interface SJTypeListViewController : UIViewController

@property(nonatomic,copy)SelectedTypeBlock typeBlock;


@end
