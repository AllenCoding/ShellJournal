//
//  SJMoreViewController.m
//  ShellJournal
//
//  Created by 刘勇 on 2017/4/10.
//  Copyright © 2017年 liuyong. All rights reserved.


#import "SJMoreViewController.h"
#import "SJCollectionMoreCell.h"
#import "SJTrashViewController.h"
#import "SJCountDownViewController.h"
#import "SJRemindViewController.h"
#import "SJGrowUpViewController.h"
#import "SJSignUpViewController.h"

@interface SJMoreViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)UICollectionView*collectionView;
@property(nonatomic,strong)NSArray*dataSource;


@end

@implementation SJMoreViewController

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout*layout=[[UICollectionViewFlowLayout alloc]init];
        CGFloat xSpace=(ScreenWidth-4*4)/3;
        layout.itemSize=CGSizeMake(xSpace, xSpace);
        layout.scrollDirection=UICollectionViewScrollDirectionVertical;
        layout.sectionInset=UIEdgeInsetsMake(5, 5, 5, 5);
        layout.minimumInteritemSpacing =2;
        layout.minimumLineSpacing = 2;
        _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) collectionViewLayout:layout];
        _collectionView.delegate=self;
        _collectionView.dataSource=self;
        _collectionView.showsVerticalScrollIndicator=NO;
        _collectionView.backgroundColor=[UIColor groupTableViewBackgroundColor];
        [_collectionView sizeToFit];
        [_collectionView registerNib:[UINib nibWithNibName:@"SJCollectionMoreCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"collectionIndentifer"];
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

-(NSArray *)dataSource{
    if (!_dataSource) {
        _dataSource=@[@"每日签到",@"贝壳提醒",@"我的积分",@"倒计时",@"垃圾篓"];
    }
    return _dataSource;
}
/*
 1.每日签到
 2.倒计时
 3.重要提醒
 4.成长足迹
 5.垃圾篓
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"更多功能";
    self.view.backgroundColor=kWhiteColor;
    [self.view addSubview:self.collectionView];
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SJCollectionMoreCell*cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"collectionIndentifer" forIndexPath:indexPath];
    cell.iconView.image=[UIImage imageNamed:self.dataSource[indexPath.row]];
    cell.titleLabel.text=self.dataSource[indexPath.row];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        SJSignUpViewController*signUpVc=[[SJSignUpViewController alloc]init];
        [self PushToVc:signUpVc];
        
    }else if (indexPath.row==1){
        SJRemindViewController*remindVc=[[SJRemindViewController alloc]init];
        [self PushToVc:remindVc];

    }else if (indexPath.row==2){
        SJGrowUpViewController*growUpVc=[[SJGrowUpViewController alloc]init];
        [self PushToVc:growUpVc];
        
          }else if (indexPath.row==3){
        SJCountDownViewController*countVc=[[SJCountDownViewController alloc]init];
        [self PushToVc:countVc];
              
    }else{
        SJTrashViewController*trashVc=[[SJTrashViewController alloc]init];
        [self PushToVc:trashVc];
    }
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
