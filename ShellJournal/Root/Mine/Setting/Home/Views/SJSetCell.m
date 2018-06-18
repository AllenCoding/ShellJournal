//
//  SJSetCell.m
//  ShellJournal
//
//  Created by 刘勇 on 2017/4/11.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "SJSetCell.h"

@implementation SJSetCell

+(instancetype)registerTableviewWithTableview:(UITableView *)tableview{
    NSString*cellIndentifer=@"set";
    SJSetCell*cell=[tableview dequeueReusableCellWithIdentifier:cellIndentifer];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"SJSetCell" owner:self options:nil].lastObject;
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)setModel:(SJSetModel *)model{
    self.leftLabel.text=model.leftText;
    self.centerLabel.text=model.centerText;
    self.rightLabel.text=model.rightText;
    self.arrowImage.hidden=!model.isHaveArrow;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
