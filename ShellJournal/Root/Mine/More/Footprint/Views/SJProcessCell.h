//
//  SJProcessCell.h
//  ShellJournal
//
//  Created by 刘勇 on 2017/6/9.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SJProcessCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UIView *bannerView;
@property (strong, nonatomic) IBOutlet UILabel *desLabel;
@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;
@property(nonatomic,strong)SJProcessModel*process;

+(instancetype)initCellWithTableview:(UITableView*)tableview;



@end
