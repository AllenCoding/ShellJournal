//
//  SJDetailCell.m
//  ShellJournal
//
//  Created by 刘勇 on 2017/3/28.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "SJDetailCell.h"

@implementation SJDetailCell


+(instancetype)configCellWithTabelView:(UITableView *)tableview{
    static  NSString  *CellIdentiferId = @"diary";
    SJDetailCell  *cell = [tableview dequeueReusableCellWithIdentifier:CellIdentiferId];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"SJDetailCell" owner:self options:nil].lastObject;
    }
    return cell;
}


-(void)setDiary:(SJDiaryModel *)diary{
    self.weekLabel.text=diary.week;
    if ([[SJDataManager manager]currentInfo].boolAddress) {
        self.addressLabel.text=diary.address;
    }else {
        //这里是因为你有xib写的所以得移除，不然会默认显示你的占位图
        [self.addressLabel removeFromSuperview];
        [self.addressView removeFromSuperview];
    }
    self.dayLabel.text=[diary.time substringWithRange:NSMakeRange(0, 12)];
    self.timeLabel.text=[diary.time substringWithRange:NSMakeRange(12, 5)];
    self.contentLabel.text=diary.content;
    if ([[SJDataManager manager]currentInfo].boolWeather) {
         self.weatherImageView.image=[UIImage imageNamed:diary.weather];
    }else {
        //这里是因为你有xib写的所以得移除，不然会默认显示你的占位图
        [self.weatherImageView removeFromSuperview];
    }

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
