//
//  SJAppCell.m
//  ShellJournal
//
//  Created by 刘勇 on 2017/6/1.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "SJAppCell.h"

@implementation SJAppCell

-(void)setAppModel:(SJAppModel *)appModel{
    self.iconView.image=[UIImage imageNamed:appModel.imageUrl];
    self.titleLabel.text=appModel.titleText;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
