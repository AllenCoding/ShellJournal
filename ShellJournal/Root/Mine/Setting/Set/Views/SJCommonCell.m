//
//  SJCommonCell.m
//  ShellJournal
//
//  Created by 刘勇 on 2017/5/23.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "SJCommonCell.h"

@implementation SJCommonCell

+(id)regiterCellWithTableView:(UITableView *)tableview{
    SJCommonCell*cell=[tableview dequeueReusableCellWithIdentifier:@"common"];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"SJCommonCell" owner:self options:nil].lastObject;
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)setModel:(SJCellModel *)model{
    self.leftLabel.text=model.leftText;
    self.rightImage.image=model.isSelected?[UIImage imageNamed:@"default_selected"]:[UIImage imageNamed:@""];
}





- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
