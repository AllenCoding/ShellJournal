//
//  SJWeatherView.m
//  ShellJournal
//
//  Created by 刘勇 on 2017/3/24.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "SJWeatherView.h"
#import "SJImageView.h"

@interface SJWeatherView ()

@property(nonatomic,strong)NSMutableArray*images;
@property(nonatomic,strong)UILabel*label;
@property(nonatomic,strong)UIButton*selectedButton;

@end

@implementation SJWeatherView

-(UILabel *)label{
    if (!_label) {
        _label=[[UILabel alloc]initWithFrame:CGRectMake(20, self.bottom-30, 300, 20)];
        _label.font=kSfont(15);
        _label.textAlignment=NSTextAlignmentLeft;
        _label.textColor=kCommonBgColor;
        _label.text=@"请选择天气情况";
    }
    return _label;
}

-(NSMutableArray *)images{
    if (!_images) {
        _images=[NSMutableArray array];
        NSArray*images=[NSArray arrayWithObjects:@"晴天",@"大雨",@"小雨",@"大雪",@"大风",@"大雾",@"阴天",@"晴转多云",@"雷",@"风暴", nil];
        [_images addObjectsFromArray:images];
    }
    return _images;
}

-(instancetype)initWeatherViewWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self setUpViews];
    }
    return self;
}




-(void)setUpViews{
    [self addSubview:self.label];
    int totalColumns=5;
    CGFloat Xspace=(ScreenWidth-5*40)/6;
    for (int index=0; index<10; index++) {
        int row=index/totalColumns;
        int col=index%totalColumns;
        UIButton*btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag=index;
        btn.frame=CGRectMake(Xspace+col*(Xspace+40), 20+row*(Xspace+40), 40, 40);
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"天气_%@",self.images[index]]]forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:self.images[index]] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(choseWeather:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
}

-(void)choseWeather:(UIButton*)sender{
    NSLog(@"%@",self.images[sender.tag]);
    self.label.text=[NSString stringWithFormat:@"你选择的天气：%@",self.images[sender.tag]];
    if (!sender.isSelected) {
        self.selectedButton.selected = !self.selectedButton.selected;
        sender.selected = !sender.selected;
        self.selectedButton = sender;
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:@"weather" object:@{@"weather":self.images[sender.tag]}];
}




@end
