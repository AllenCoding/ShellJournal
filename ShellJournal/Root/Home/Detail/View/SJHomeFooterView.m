//
//  SJHomeFooterView.m
//  ShellJournal
//
//  Created by 刘勇 on 2017/3/28.
//  Copyright © 2017年 liuyong. All rights reserved.

#import "SJHomeFooterView.h"
#import "SJImageView.h"
@interface SJHomeFooterView ()

@property(nonatomic,strong)NSArray*images;

@end

@implementation SJHomeFooterView

-(instancetype)initFooterViewWithImages:(NSArray *)images{
    if (self=[super init]) {
        _images=images;
        
        if (images.count==0) {
            
        }else{
            NSInteger num=images.count%4==0?images.count/4:images.count/4+1;
            self.frame=CGRectMake(0, 0, ScreenWidth, (ScreenWidth-10)/4*num+(num-1)*2);
            [self setUpViews];
        }
    }
    return self;
}

-(void)setUpViews{
    int totalColumns=4;
    CGFloat appW=(ScreenWidth-10)/4;
    CGFloat appH=appW;
    CGFloat marginX=2;
    for (int index=0; index<self.images.count; index++) {
        //计算这个app在几行几列
        int row=index/totalColumns;
        int col=index%totalColumns;
        SJImageView*imageV=[[SJImageView alloc]initWithFrame:CGRectMake(marginX+col*(marginX+appW), row*(marginX+appH), appW, appH)];
        NSString*path=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        imageV.image=[[UIImage alloc]initWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",path,self.images[index]]];
        imageV.tag=index;
        imageV.userInteractionEnabled=YES;
        UITapGestureRecognizer*tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(OnclickEvent:)];
        [imageV addGestureRecognizer:tap];
        [self addSubview:imageV];
    }
}

-(void)OnclickEvent:(id)sender{
    UITapGestureRecognizer *singleTap = (UITapGestureRecognizer *)sender;
    UIView*tagView=[singleTap view];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"scanImage" object:@{@"tag":[NSString stringWithFormat:@"%ld",tagView.tag]}];
}







/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
