//
//  SJMineCell.m
//  ShellJournal
//
//  Created by 刘勇 on 2017/4/10.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "SJMineCell.h"

@implementation SJMineCell

+(instancetype)registerTableViewWithTabelview:(UITableView *)tableview{
    static  NSString  *CellIdentiferId = @"mecell";
    SJMineCell  *cell = [tableview dequeueReusableCellWithIdentifier:CellIdentiferId];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"SJMineCell" owner:self options:nil].lastObject;
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)setModel:(SJMeModel *)model{
    self.leftIconView.image=[UIImage imageNamed:model.leftImageName];
    self.centerTextLabel.text=model.leftText;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
