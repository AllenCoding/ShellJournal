//
//  SJCommonCell.h
//  ShellJournal
//
//  Created by 刘勇 on 2017/5/23.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SJCellModel.h"
@interface SJCommonCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *leftLabel;
@property (strong, nonatomic) IBOutlet UIImageView *rightImage;
@property(nonatomic,strong)SJCellModel*model;


+(id)regiterCellWithTableView:(UITableView*)tableview;


@end
