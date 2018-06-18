//
//  SJRecommendViewController.m
//  ShellJournal
//
//  Created by 刘勇 on 2017/4/10.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "SJRecommendViewController.h"
#import "SJAppModel.h"
#import "SJAppCell.h"

@interface SJRecommendViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)NSArray*dataSource;
@property(nonatomic,strong)SJAppModel*model;
@property(nonatomic,strong)UICollectionView*collectionView;

@end

@implementation SJRecommendViewController

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout*layout=[[UICollectionViewFlowLayout alloc]init];
        CGFloat xSpace=(ScreenWidth-4*4)/3;
        layout.itemSize=CGSizeMake(xSpace, xSpace*0.9);
        layout.scrollDirection=UICollectionViewScrollDirectionVertical;
        layout.sectionInset=UIEdgeInsetsMake(15, 5, 5, 5);
        layout.minimumInteritemSpacing =2;
        layout.minimumLineSpacing = 2;
        _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) collectionViewLayout:layout];
        _collectionView.delegate=self;
        _collectionView.dataSource=self;
        _collectionView.showsVerticalScrollIndicator=NO;
        _collectionView.backgroundColor=[UIColor groupTableViewBackgroundColor];
        [_collectionView sizeToFit];
        [_collectionView registerNib:[UINib nibWithNibName:@"SJAppCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"appcell"];
    }
    return _collectionView;
}

-(SJAppModel *)model{
    if (!_model) {
        _model=[[SJAppModel alloc]init];
    }
    return _model;
}

-(NSArray *)dataSource{
    if (!_dataSource) {
        _dataSource=self.model.appArray;
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"推荐更多";
    [self.view addSubview:self.collectionView];
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SJAppCell*cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"appcell" forIndexPath:indexPath];
    cell.appModel=self.dataSource[indexPath.row];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.model=self.dataSource[indexPath.row];
    if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:self.model.url]]) {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:self.model.url] options:@{}completionHandler:^(BOOL success) {
        }];
    }
    
    NSLog(@"%@",self.model.url);
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
