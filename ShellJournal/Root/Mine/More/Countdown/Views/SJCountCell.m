//
//  SJCountCell.m
//  ShellJournal
//
//  Created by Tian on 2017/6/4.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "SJCountCell.h"

@implementation SJCountCell

+(id)initCellWithTableview:(UITableView *)tableview{

    static  NSString  *CellIdentiferId = @"countcell";
    SJCountCell  *cell = [tableview dequeueReusableCellWithIdentifier:CellIdentiferId];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"SJCountCell" owner:self options:nil].lastObject;
    }
    return cell;
}

-(void)setModel:(SJCountModel *)model{
    
    self.iconView.image=[UIImage imageNamed:[self configImageName:model]];
    self.titleLabel.text=model.countTitle;
    self.timeLabel.text=model.time;

    NSDate*date=[NSDate date];
    NSInteger nowDay=date.timeIntervalSince1970;
    NSInteger number=model.countTime-nowDay;
    NSInteger day=number<=0?0:floor(number/(3600*24))+1;
    self.dayLabel.text=[NSString stringWithFormat:@"%ld",day];//天
    
}

-(NSString*)configImageName:(SJCountModel*)model{
    if ([model.type isEqualToString:@"日常生活"]) {
        return @"type_life";
    }else if ([model.type isEqualToString:@"爱情纪念"]){
        return @"type_love";

    }else if ([model.type isEqualToString:@"生日纪念"]){
        return @"type_birthday";

    }else if ([model.type isEqualToString:@"度假旅游"]){
        return @"type_holiday";

    }else if ([model.type isEqualToString:@"娱乐休闲"]){
        return @"type_entertainment";

    }else if ([model.type isEqualToString:@"学习待办"]){
        return @"type_study";

    }else if ([model.type isEqualToString:@"工作事务"]){
        return @"type_work";
    }else{
        return @"type_event";
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
