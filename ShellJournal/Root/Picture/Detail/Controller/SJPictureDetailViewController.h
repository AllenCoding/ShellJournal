//
//  SJPictureDetailViewController.h
//  ShellJournal
//
//  Created by 刘勇 on 2017/3/29.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "SJBaseViewController.h"

@interface SJPictureDetailViewController : SJBaseViewController

@property (strong, nonatomic) IBOutlet UIScrollView *myScrollView;
@property(nonatomic,strong)UIImageView*imageVc;
@property(nonatomic,strong)NSArray*images;
@property(nonatomic,strong)UILabel*pageLabel;

@end
