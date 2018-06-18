//
//  SJScanImageViewController.m
//  ShellJournal
//
//  Created by 刘勇 on 2017/3/28.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "SJScanImageViewController.h"

@interface SJScanImageViewController ()<UIScrollViewDelegate>

@property(nonatomic,assign)NSInteger page;

@end

@implementation SJScanImageViewController

-(UIImageView *)imageVc{
    if (!_imageVc) {
        NSString*path=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        for (NSInteger index=0; index<self.images.count; index++) {
           _imageVc=[[UIImageView alloc]initWithFrame:CGRectMake(index*ScreenWidth, 0, ScreenWidth, self.imageScrollView.frame.size.height)];
            _imageVc.image=[[UIImage alloc]initWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",path,self.images[index]]];
            _imageVc.userInteractionEnabled=YES;
            [self.imageScrollView addSubview:_imageVc];
        }
    }
    return _imageVc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpViews];
}
-(void)setUpViews{
    NSInteger index=[self.tag integerValue];
    self.pageLabel.text=[NSString stringWithFormat:@"(%ld/%ld)",index+1,self.images.count];
    self.imageScrollView.contentSize=CGSizeMake(self.images.count*ScreenWidth, 0);
    self.imageScrollView.contentOffset=CGPointMake(index*ScreenWidth, 0);
    self.imageScrollView.delegate=self;
    [self.view addSubview:self.imageScrollView];
    [self.imageScrollView addSubview:self.imageVc];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger index=scrollView.contentOffset.x/ScreenWidth;
    self.pageLabel.text=[NSString stringWithFormat:@"(%ld/%ld)",index+1,self.images.count];
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
