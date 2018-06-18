//
//  SJDetailCell.h
//  ShellJournal
//
//  Created by 刘勇 on 2017/3/28.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SJDetailCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *dayLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *weekLabel;
@property (strong, nonatomic) IBOutlet UIImageView *weatherImageView;
@property (weak, nonatomic) IBOutlet UIImageView *addressView;

@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) IBOutlet UILabel *contentLabel;

@property(assign,nonatomic)SJDiaryModel*diary;

+(instancetype)configCellWithTabelView:(UITableView*)tableview;



@end
