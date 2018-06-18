//
//  SJCountCell.h
//  ShellJournal
//
//  Created by Tian on 2017/6/4.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SJCountModel.h"
@interface SJCountCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *iconView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *dayLabel;

@property(nonatomic,strong)SJCountModel*model;

+(id)initCellWithTableview:(UITableView*)tableview;


@end
