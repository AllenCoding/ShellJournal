//
//  SJKeyBoardView.m
//  ShellJournal
//
//  Created by 刘勇 on 2017/5/26.
//  Copyright © 2017年 liuyong. All rights reserved.

#import "SJKeyBoardView.h"


@interface SJKeyBoardView ()

@property(nonatomic,assign)NSInteger length;

@property(nonatomic,strong)UIImageView*top;

@property(nonatomic,strong)NSMutableArray*nums;


@property(nonatomic,strong)UIImageView*image;

@end

@implementation SJKeyBoardView

-(UIImageView *)image{
        for (int i=0; i<self.nums.count; i++) {
           _image=[[UIImageView alloc]initWithFrame:CGRectMake(40*i, 0, 40, 40)];
            _image.image=[UIImage imageNamed:@"default_dot"];
        }
    return _image;
}


-(UIImageView *)top{
    if (!_top) {
        _top=[[UIImageView alloc]init];
        _top.image=[UIImage imageNamed:@"top_back"];
        [self addSubview:_top];
    }
    return _top;
}

-(NSMutableArray *)nums{
    if (!_nums) {
        _nums=[NSMutableArray array];
    }
    return _nums;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self loadUI];
    }
    return self;
}
-(void)loadUI{
    [self addSubview:self.top];
    NSArray*numbers=@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"",@"0",@"删除"];
    int totalColumns=3;
    CGFloat appW=60;
    CGFloat appH=60;
    //定义水平和垂直方面的间距
    CGFloat marginX=(self.frame.size.width-totalColumns*appW)/(totalColumns+1);
    for (int index=0; index<numbers.count; index++) {
        //计算这个app在几行几列
        int row=index/totalColumns;
        int col=index%totalColumns;
        UIButton*numBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        numBtn.frame=CGRectMake(marginX+col*(marginX+appW), 60+row*(marginX+appH), appW, appH);
        [numBtn setTitle:numbers[index] forState:UIControlStateNormal];
        if (numBtn.tag!=11) {
            [numBtn setTitleColor:kGrayColor forState:UIControlStateNormal];
            numBtn.titleLabel.font=kSfont(20);
        }else{
            [numBtn setTitleColor:kRedColor forState:UIControlStateNormal];
            numBtn.titleLabel.font=kSfont(16);
        }
        numBtn.layer.cornerRadius=appH/2;
        numBtn.layer.masksToBounds=YES;
        numBtn.tag=index;
        numBtn.layer.borderColor=kGrayColor.CGColor;
        numBtn.layer.borderWidth=1;
        [numBtn setBackgroundColor:kWhiteColor];
        [numBtn addTarget:self action:@selector(addNum:) forControlEvents:UIControlEventTouchUpInside];
        numBtn.hidden=numBtn.tag==9;
        [self addSubview:numBtn];
    }
}
-(void)addNum:(UIButton*)sender{
    if (sender.tag==9||sender.tag==11) {
        if (sender.tag==11) {
        //删除字符串
            if (self.nums.count>0) {
                [self.nums removeLastObject];
                [[self.top.subviews objectAtIndex:self.nums.count] removeFromSuperview];
            }
        }
    }else{
        //添加字符串
        if (self.nums.count<4) {
            [self.nums addObject:sender.titleLabel.text];
        }
        [self.top addSubview:self.image];
        NSString*string=[self.nums componentsJoinedByString:@""];
        if (self.nums.count==4) {
            [self inputOk:string];
        }
    }
}

-(void)setPasswordLength:(NSInteger)passwordLength{
    _length=passwordLength;
}

-(void)inputOk:(NSString*)string{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(didFinishInputText:)]) {
        [self.delegate didFinishInputText:string];
    }
}


- (void)layoutSubviews {
    // 一定要调用super的方法
    [super layoutSubviews];
    // 确定子控件的frame（这里得到的self的frame/bounds才是准确的）
    CGFloat width = self.bounds.size.width;
    self.top.frame=CGRectMake((width-self.length*40)/2, 0, self.length*40, 40);
  
}





@end
