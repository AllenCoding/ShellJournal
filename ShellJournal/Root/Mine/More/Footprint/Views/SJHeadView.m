//
//  SJHeadView.m
//  ShellJournal
//
//  Created by 刘勇 on 2017/6/7.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "SJHeadView.h"

@interface SJHeadView ()

@property(nonatomic,strong)UIImageView*icon;
@property(nonatomic,strong)UIImageView*scoreImageView;
@property(nonatomic,strong)UIImageView*nameImageView;
@property(nonatomic,strong)UILabel*scoreLabel;
@property(nonatomic,strong)UILabel*nameLabel;

@end

@implementation SJHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self setUpViews];
        self.backgroundColor=kWhiteColor;
    }
    return self;
}

-(void)setUpViews{
    
    NSString*path=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    UIImageView*icon=[[UIImageView alloc]init];

     icon.image=[[SJDataManager manager]currentInfo].head?[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",path,[[SJDataManager manager]currentInfo].personHeadImage]]:[UIImage imageNamed:@"default"];
    
    icon.layer.cornerRadius=40;
    icon.layer.masksToBounds=YES;
    [self addSubview:icon];
    _icon=icon;
    
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).with.offset(20);
        make.top.mas_equalTo(self.mas_top).with.offset(10);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(80);
        
    }];
    
    NSArray*array=@[@"积分",@"昵称"];
    NSArray*title=@[[[SJDataManager manager]currentInfo].personLevel,[NSString getLevelWithScore:[[[SJDataManager manager]currentInfo].personLevel integerValue]]];
    CGFloat vSpace=(self.height-20*2)/3;
    for (int index=0; index<array.count; index++) {
        UIImageView*ico=[[UIImageView alloc]initWithFrame:CGRectMake(120, vSpace+(vSpace+20)*index, 20, 20)];
        ico.image=[UIImage imageNamed:array[index]];
        [self addSubview:ico];
        
        UILabel*lab=[[UILabel alloc]initWithFrame:CGRectMake(150, vSpace+(vSpace+20)*index, 100, 20)];
        lab.text=title[index];
        lab.textColor=kBlackColor;
        lab.textAlignment=NSTextAlignmentLeft;
        lab.font=kSfont(13);
        [self addSubview:lab];
    }
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
