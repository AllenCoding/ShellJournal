//
//  SJVoiceView.m
//  ShellJournal
//
//  Created by 刘勇 on 2017/4/7.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "SJVoiceView.h"

@interface SJVoiceView ()

@property(nonatomic,strong)UIButton*startBtn;
@property(nonatomic,strong)UIImageView*imageV;

@end

@implementation SJVoiceView

-(UIImageView *)imageV{
    if (!_imageV) {
        NSMutableArray *imagesArray = [[NSMutableArray alloc] init];
        for(int i=1;i<=3;i++){
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"image%d.png",i]];
            [imagesArray addObject:image];
        }
        _imageV = [[UIImageView alloc] init];
        _imageV.frame = CGRectMake(self.startBtn.right+10, (self.frame.size.height-80)/2+20, 30, 30);
        _imageV.animationImages = imagesArray;
        _imageV.animationDuration = 2;
        _imageV.animationRepeatCount = 10000;
    }
    return _imageV;
}

-(UIButton *)startBtn{
    if (!_startBtn) {
        CGFloat xSpace=(self.frame.size.width-80)/2;
        _startBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _startBtn.frame=CGRectMake(xSpace, (self.frame.size.height-80)/2, 80, 80);
        [_startBtn setImage:[UIImage imageNamed:@"Home_end"] forState:UIControlStateNormal];
        [_startBtn setImage:[UIImage imageNamed:@"Home_start"] forState:UIControlStateSelected];
        [_startBtn addTarget:self action:@selector(didClickOn:) forControlEvents:UIControlEventTouchUpInside];
        _startBtn.selected=NO;
        [self addSubview:_startBtn];
    }
    return _startBtn;
}

-(instancetype)initVoiceViewWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self addSubview:self.startBtn];
        [self addSubview:self.imageV];
    }
    return self;
}

-(void)didClickOn:(UIButton*)sender{
    if (sender.selected) {
        sender.selected=NO;
        sender.tag=101;
        [self.imageV stopAnimating];

    }else{
        sender.selected=YES;
        sender.tag=100;
        [self.imageV startAnimating];

    }
    [[NSNotificationCenter defaultCenter]postNotificationName:@"recordVoice" object:@{@"tag":[NSString stringWithFormat:@"%ld",sender.tag]}];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
