//
//  SJSetCell.h
//  ShellJournal
//
//  Created by 刘勇 on 2017/4/11.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SJSetModel.h"

@interface SJSetCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *leftLabel;
@property (strong, nonatomic) IBOutlet UILabel *centerLabel;
@property (strong, nonatomic) IBOutlet UILabel *rightLabel;
@property(nonatomic,strong)SJSetModel*model;
@property (strong, nonatomic) IBOutlet UIImageView *arrowImage;

+(instancetype)registerTableviewWithTableview:(UITableView*)tableview;

@end
