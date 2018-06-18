//
//  SJPictureViewController.m
//  ShellJournal
//
//  Created by 刘勇 on 2017/3/6.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "SJPictureViewController.h"
#import "SJCustomEmptyView.h"
#import "SJPictureDetailViewController.h"
#import "SJImageCell.h"

@interface SJPictureViewController ()<EmptyViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)NSMutableArray*dataSource;
@property(nonatomic,strong)SJCustomEmptyView*emptyViews;
@property(nonatomic,strong)UICollectionView*collectionView;

@end

@implementation SJPictureViewController

-(SJCustomEmptyView *)emptyViews{
    if (!_emptyViews) {
        _emptyViews=[[SJCustomEmptyView alloc]initEmptyViewWithBtnTitle:nil];
        _emptyViews.delegate=self;
        _emptyViews.frame=CGRectMake(0, (ScreenHeight-64-240-44)/2, ScreenWidth, 240);
        _emptyViews.backgroundColor=[UIColor groupTableViewBackgroundColor];
    }
    return _emptyViews;
}
-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource=[NSMutableArray new];
        _dataSource=[[SJDataManager manager]showAllPictures];
    }
    return _dataSource;
}
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout*layout=[[UICollectionViewFlowLayout alloc]init];
        CGFloat xSpace=(ScreenWidth-6*3)/2;
        layout.itemSize=CGSizeMake(xSpace, 240);
        layout.scrollDirection=UICollectionViewScrollDirectionVertical;
        layout.sectionInset=UIEdgeInsetsMake(5, 5, 5, 5);
        layout.minimumInteritemSpacing =5;
        layout.minimumLineSpacing = 5;
        _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64-49) collectionViewLayout:layout];
        _collectionView.delegate=self;
        _collectionView.dataSource=self;
        _collectionView.showsVerticalScrollIndicator=NO;
        _collectionView.backgroundColor=[UIColor groupTableViewBackgroundColor];
        [_collectionView sizeToFit];
        [_collectionView registerNib:[UINib nibWithNibName:@"SJImageCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"collectionIndentifer"];
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"图片";
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.emptyViews];
    self.emptyViews.hidden=self.dataSource.count>0;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadImage) name:@"newDiary" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadImage) name:@"deleteDiary" object:nil];

}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
     SJImageCell*cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"collectionIndentifer" forIndexPath:indexPath];
    cell.diary=self.dataSource[indexPath.row];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SJPictureDetailViewController*detialVc=[[SJPictureDetailViewController alloc]init];
    SJDiaryModel*diary=self.dataSource[indexPath.row];
    detialVc.images=[diary.imageName componentsSeparatedByString:@","];
    [self PushToVc:detialVc];
}
-(void)reloadImage{
    self.dataSource=[[SJDataManager manager]showAllPictures];
    self.emptyViews.hidden=self.dataSource.count>0;
    [self.collectionView reloadData];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
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
