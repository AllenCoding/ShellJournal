//
//  SJImageCell.m
//  ShellJournal
//
//  Created by 刘勇 on 2017/3/28.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "SJImageCell.h"

@implementation SJImageCell

-(void)setDiary:(SJDiaryModel *)diary{
    NSString*path=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    self.imageView.image=[[UIImage alloc]initWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",path,[diary.imageName componentsSeparatedByString:@","][0]]];
    self.timeLabel.text=[diary.time substringWithRange:NSMakeRange(5, 6)];
    self.imageNumLabel.text=[NSString stringWithFormat:@"%ld张",[diary.imageName componentsSeparatedByString:@","].count];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
