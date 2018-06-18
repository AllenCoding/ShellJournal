//
//  SJHomeViewController.m
//  ShellJournal
//
//  Created by 刘勇 on 2017/3/6.
//  Copyright © 2017年 liuyong. All rights reserved.

#import "SJHomeViewController.h"
#import "SJCustomEmptyView.h"
#import "SJAddDiaryViewController.h"
#import "SJDetailViewController.h"
#import "SJHomeCell.h"
@interface SJHomeViewController ()<EmptyViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)SJCustomEmptyView*emptyViews;
@property(nonatomic,strong)UITableView*tableview;
@property(nonatomic,strong)NSMutableArray*dataSource;

@end

@implementation SJHomeViewController

-(SJCustomEmptyView *)emptyViews{
    if (!_emptyViews) {
        _emptyViews=[[SJCustomEmptyView alloc]initEmptyViewWithBtnTitle:nil];
        _emptyViews.delegate=self;
        _emptyViews.frame=CGRectMake(0, (ScreenHeight-64-240-44)/2, ScreenWidth, 240);
        _emptyViews.backgroundColor=[UIColor groupTableViewBackgroundColor];
        _emptyViews.hidden=self.dataSource.count>0;
    }
    return _emptyViews;
}
-(UITableView *)tableview{
    if (!_tableview) {
        _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64-49) style:UITableViewStylePlain];
        _tableview.delegate=self;
        _tableview.dataSource=self;
        _tableview.backgroundColor=[UIColor groupTableViewBackgroundColor];
        _tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableview.showsVerticalScrollIndicator=NO;
    }
    return _tableview;
}
-(NSMutableArray *)dataSource{
   if (!_dataSource) {
        _dataSource=[NSMutableArray new];
       _dataSource=[NSMutableArray arrayWithArray:[[SJDataManager manager]showAllDiarys]];
    }
    return _dataSource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"日记";
    [self.view addSubview:self.tableview];
    [self.view addSubview:self.emptyViews];
    [self addObserver];
    [self setRightItem];
}

#pragma UITabelview  Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SJHomeCell*cell=[SJHomeCell configCellWithTabelView:self.tableview];
    SJDiaryModel*diary=self.dataSource[indexPath.row];
    cell.diary=diary;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SJDetailViewController*detailVc=[[SJDetailViewController alloc]init];
    SJDiaryModel*diary=self.dataSource[indexPath.row];
    detailVc.diary=diary;
    [self PushToVc:detailVc];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
-(void)setRightItem{
    UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(0, 0, 25, 25);
    [button setBackgroundImage:[UIImage imageNamed:@"NavgationBar_write"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(didClickOnAction) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem*rightItem=[[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem=rightItem;
}
-(void)reloadDiary{
    self.dataSource=[[SJDataManager manager]showAllDiarys];
    self.emptyViews.hidden=self.dataSource.count>0;
    [self.tableview reloadData];
}
-(void)didClickOnAction{
    SJAddDiaryViewController*addDiaryVc=[[SJAddDiaryViewController alloc]init];
    [self PushToVc:addDiaryVc];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
-(void)addObserver{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadDiary) name:@"newDiary" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadDiary) name:@"deleteDiary" object:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
