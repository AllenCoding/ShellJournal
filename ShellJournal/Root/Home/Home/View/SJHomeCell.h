//
//  SJHomeCell.h
//  ShellJournal
//
//  Created by 刘勇 on 2017/3/27.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SJDiaryModel.h"
@interface SJHomeCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *dayLabel;
@property (strong, nonatomic) IBOutlet UILabel *weekLabel;
@property (strong, nonatomic) IBOutlet UILabel *yearLabel;
@property (strong, nonatomic) IBOutlet UILabel *contentLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
@property(assign,nonatomic)SJDiaryModel*diary;

+(instancetype)configCellWithTabelView:(UITableView*)tableview;

@end
