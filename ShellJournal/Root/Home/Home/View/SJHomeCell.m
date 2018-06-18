//
//  SJHomeCell.m
//  ShellJournal
//
//  Created by 刘勇 on 2017/3/27.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "SJHomeCell.h"
#import "UILabel+Addition.h"

@implementation SJHomeCell

+(instancetype)configCellWithTabelView:(UITableView *)tableview{
    static  NSString  *CellIdentiferId = @"diary";
    SJHomeCell  *cell = [tableview dequeueReusableCellWithIdentifier:CellIdentiferId];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"SJHomeCell" owner:self options:nil].lastObject;
    }
    return cell;
}

-(void)setDiary:(SJDiaryModel *)diary{
    self.weekLabel.text=diary.week;
    self.addressLabel.text=diary.address;
    self.yearLabel.text=[diary.time substringToIndex:8];
    self.dayLabel.text=[diary.time substringWithRange:NSMakeRange(8, 2)];
    self.timeLabel.text=[diary.time substringWithRange:NSMakeRange(12, 5)];
    self.contentLabel.text=diary.content;
    [self.contentLabel setTopAlignmentWithText:self.contentLabel.text maxHeight:80 ];
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
