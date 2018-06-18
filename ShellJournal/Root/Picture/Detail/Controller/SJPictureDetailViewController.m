//
//  SJPictureDetailViewController.m
//  ShellJournal
//
//  Created by 刘勇 on 2017/3/29.
//  Copyright © 2017年 liuyong. All rights reserved.

#import "SJPictureDetailViewController.h"

@interface SJPictureDetailViewController ()<UIScrollViewDelegate>

@end

@implementation SJPictureDetailViewController

-(UILabel *)pageLabel{
    if (!_pageLabel) {
        _pageLabel=[[UILabel alloc]init];
        _pageLabel.frame=CGRectMake(self.navigationItem.titleView.frame.origin.x, self.navigationItem.titleView.frame.origin.y, 300, 30) ;
        _pageLabel.text=[NSString stringWithFormat:@"%@ [1/%ld]",self.images[0],self.images.count];
        _pageLabel.textColor=kWhiteColor;
        _pageLabel.textAlignment=1;
        _pageLabel.font=kSfont(16);
    }
    return _pageLabel;
}

-(UIImageView *)imageVc{
    if (!_imageVc) {
        NSString*path=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        for (NSInteger index=0; index<self.images.count; index++) {
            _imageVc=[[UIImageView alloc]initWithFrame:CGRectMake(index*ScreenWidth, 0, ScreenWidth, self.myScrollView.frame.size.height)];
            _imageVc.image=[[UIImage alloc]initWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",path,self.images[index]]];
            _imageVc.userInteractionEnabled=YES;
            [self.myScrollView addSubview:_imageVc];
        }
    }
    return _imageVc;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    [self setUpViews];
}

-(void)setUpViews{
    self.myScrollView.contentSize=CGSizeMake(self.images.count*ScreenWidth, 0);
    self.myScrollView.contentOffset=CGPointMake(0, 0);
    self.myScrollView.delegate=self;
    [self.view addSubview:self.myScrollView];
    [self.myScrollView addSubview:self.imageVc];
    [self.navigationItem setTitleView:self.pageLabel];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger index=scrollView.contentOffset.x/ScreenWidth;
    self.pageLabel.text=[NSString stringWithFormat:@"%@ [%ld/%ld]",self.images[index],index+1,self.images.count];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
