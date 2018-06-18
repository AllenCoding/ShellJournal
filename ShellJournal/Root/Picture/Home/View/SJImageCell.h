//
//  SJImageCell.h
//  ShellJournal
//
//  Created by 刘勇 on 2017/3/28.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SJImageCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UILabel *imageNumLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@property(strong,nonatomic)SJDiaryModel*diary;




@end
