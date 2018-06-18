//
//  SJPhotoView.m
//  ShellJournal
//
//  Created by 刘勇 on 2017/3/23.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "SJPhotoView.h"
#import "ZYQAssetPickerController.h"

@interface SJPhotoView()<UIScrollViewDelegate>

@property(nonatomic,strong)UIScrollView*scrollView;

@property(nonatomic,strong)NSMutableArray*images;

@end

@implementation SJPhotoView

-(instancetype)initPhotoViewWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self setUpViews];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getPhotos:) name:@"pickPhoto" object:nil];

    }
    return self;
}

-(NSMutableArray *)images{
    if (!_images) {
        _images=[NSMutableArray array];
    }
    return _images;
}

-(void)getPhotos:(NSNotification*)noti{
    
    [self.scrollView removeFromSuperview];
    
    self.images=[NSMutableArray arrayWithArray:noti.object];
    UIScrollView*scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, self.frame.size.height*0.8)];
    scrollView.delegate=self;
    scrollView.contentSize=CGSizeMake(self.images.count*100+(self.images.count+1)*5,0);
    scrollView.showsHorizontalScrollIndicator=NO;
    scrollView.scrollEnabled=YES;
    scrollView.contentOffset = CGPointMake(0, 0);
    self.scrollView=scrollView;
    [self addSubview:scrollView];
    
    for (NSInteger index=0; index<self.images.count; index++) {
       UIImageView*iv=[[UIImageView alloc]initWithFrame:CGRectMake(5+index*(100+5), 5, 100, self.frame.size.height*0.8)];
        iv.image=self.images[index];
        iv.tag=index+1000;
        iv.userInteractionEnabled=YES;
        [scrollView addSubview:iv];
    }
}

-(void)setUpViews{
    
    NSArray*titles=@[@"相册",@"拍照"];
    for (int index=0; index<titles.count; index++) {
        UIButton*photoBtn=[UIButton buttonWithType:UIButtonTypeSystem];
        photoBtn.frame=CGRectMake(10+60*index, self.bottom-40, 60, 30);
        [photoBtn setTitle:titles[index] forState:UIControlStateNormal];
        photoBtn.titleLabel.font=kSfont(15);
        [photoBtn addTarget: self action:@selector(didOnclickPhoto:) forControlEvents:UIControlEventTouchUpInside];
        photoBtn.tag=index;
        [self addSubview:photoBtn];
    }
    
    UILabel*lineLabel=[[UILabel alloc]initWithFrame:CGRectMake(72, self.bottom-32, 1, 20)];
    lineLabel.backgroundColor=kLightGrayColor;
    [self addSubview:lineLabel];
}

-(void)didOnclickPhoto:(UIButton*)button{
    NSString*action=button.tag==0?@"相册":@"相机";
    [[NSNotificationCenter defaultCenter]postNotificationName:@"photo" object:nil userInfo:@{@"action":action}];
}

@end
