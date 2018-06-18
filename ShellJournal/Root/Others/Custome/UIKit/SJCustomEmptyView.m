//
//  SJCustomEmptyView.m
//  ShellJournal
//
//  Created by 刘勇 on 2017/3/6.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "SJCustomEmptyView.h"

@interface SJCustomEmptyView ()

@property(nonatomic,strong)UIImageView*emptyViews;
@property(nonatomic,strong)UIButton*actionBtn;
@property(nonatomic,copy)NSString*btnTitle;

@end

@implementation SJCustomEmptyView

-(instancetype)initEmptyViewWithBtnTitle:(NSString *)btnTitle{
    if (self=[super init]) {
        self.btnTitle=btnTitle;
        [self addSubview:self.emptyViews];
    }
    return self;
}

-(UIImageView *)emptyViews{
    if (!_emptyViews) {
        _emptyViews=[[UIImageView alloc]init];
        _emptyViews.image=[UIImage imageNamed:@"default_nocontent"];
        [self addSubview:_emptyViews];
    }
    return _emptyViews;
}

-(UIButton *)actionBtn{
    if (!_actionBtn&&self.btnTitle) {
        _actionBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_actionBtn setTitle:self.btnTitle forState:UIControlStateNormal];
        _actionBtn.titleLabel.font=kSfont(14);
        _actionBtn.backgroundColor=kCommonBgColor;
        [_actionBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [_actionBtn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_actionBtn];

    }
    return _actionBtn;
}

-(void)click{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(didClickOnAction)]) {
        [self.delegate didClickOnAction];
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.emptyViews mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(180);
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self.top).with.offset(10);
        make.height.mas_equalTo(160);
    }];
    [self.actionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(30);
        make.top.mas_equalTo(self.emptyViews.mas_bottom);
        make.centerX.mas_equalTo(self.emptyViews);
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
