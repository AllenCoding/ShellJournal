//
//  SJMineCell.h
//  ShellJournal
//
//  Created by 刘勇 on 2017/4/10.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SJMeModel.h"
@interface SJMineCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *leftIconView;
@property (strong, nonatomic) IBOutlet UILabel *centerTextLabel;
@property(nonatomic,strong)SJMeModel*model;

+(instancetype)registerTableViewWithTabelview:(UITableView*)tableview;


@end
