//
//  SJProcessCell.m
//  ShellJournal
//
//  Created by 刘勇 on 2017/6/9.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "SJProcessCell.h"

@implementation SJProcessCell

+(instancetype)initCellWithTableview:(UITableView *)tableview{
    static NSString*identifer=@"processce";
    SJProcessCell*cell=[tableview dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"SJProcessCell" owner:self options:nil].lastObject;
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)setProcess:(SJProcessModel *)process{
    self.bannerView.backgroundColor=[UIColor ColorWithString:process.colorStr];
    self.timeLabel.text=process.processtime;
    self.desLabel.text=process.desc;
    self.scoreLabel.text=process.score;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
