//
//  SJScanImageViewController.h
//  ShellJournal
//
//  Created by 刘勇 on 2017/3/28.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SJScanImageViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *pageLabel;
@property (strong, nonatomic) IBOutlet UIScrollView *imageScrollView;
@property(nonatomic,strong)NSArray*images;
@property(nonatomic,strong)NSString*tag;
@property(nonatomic,strong)UIImageView*imageVc;

@end
