//
//  SJAppCell.h
//  ShellJournal
//
//  Created by 刘勇 on 2017/6/1.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SJAppModel.h"
@interface SJAppCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *iconView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property(nonatomic,strong)SJAppModel*appModel;



@end
