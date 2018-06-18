//
//  SJWallView.m
//  ShellJournal
//
//  Created by 刘勇 on 2017/3/22.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "SJWallView.h"
#import "SJImageView.h"

@interface SJWallView()<UIScrollViewDelegate>

@property(nonatomic,strong)NSArray*images;

@end

@implementation SJWallView

-(instancetype)initWallViewFrame:(CGRect)frame WithImageArrays:(NSArray*)array{
    if (self=[super initWithFrame:frame]) {
        _images=array;
        [self setUpViews];
    }
    return self;
}

-(void)setUpViews{
    
    UIScrollView*scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, self.frame.size.height*0.8)];
    scrollView.delegate=self;
    scrollView.contentSize=CGSizeMake(self.images.count*100+(self.images.count+1)*5,0);
    scrollView.showsHorizontalScrollIndicator=NO;
    scrollView.scrollEnabled=YES;
    scrollView.contentOffset = CGPointMake(0, 0);
    
    
    
    for (NSInteger index=0; index<self.images.count; index++) {
        SJImageView*imageV=[[SJImageView alloc]initWithFrame:CGRectMake(index*100, 5, 100, self.frame.size.height*0.8)];
        imageV.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",self.images[index]]];
        imageV.tag=index+1000;
        imageV.imageName=self.images[index];
        imageV.userInteractionEnabled=YES;
        [scrollView addSubview:imageV];
        UITapGestureRecognizer*tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click:)];
        [imageV addGestureRecognizer:tap];
    }
    [self addSubview:scrollView];
    
        UIButton*photoBtn=[UIButton buttonWithType:UIButtonTypeSystem];
        photoBtn.frame=CGRectMake(10, self.bottom-40, 60, 30);
        [photoBtn setTitle:@"自定义" forState:UIControlStateNormal];
        photoBtn.titleLabel.font=kSfont(15);
        [photoBtn addTarget: self action:@selector(didOnclickPhoto) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:photoBtn];
}
-(void)click:(id)sender{
    UITapGestureRecognizer *singleTap = (UITapGestureRecognizer *)sender;
    UIView*tagView=[singleTap view];
    SJImageView*iv=(SJImageView*)tagView;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"wall" object:nil userInfo:@{@"wallname":iv.imageName}];
}

-(void)didOnclickPhoto{
    NSLog(@"点击了自定义");
    [MBProgressHUD showError:@"VIP权限"];
}



@end
