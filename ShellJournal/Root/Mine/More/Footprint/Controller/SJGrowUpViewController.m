//
//  SJGrowUpViewController.m
//  ShellJournal
//
//  Created by 刘勇 on 2017/6/7.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "SJGrowUpViewController.h"
#import "SJHeadView.h"
#import "SJLevelViewController.h"
#import "SJProcessCell.h"


@interface SJGrowUpViewController ()<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic,strong)SJHeadView*headView;
@property(nonatomic,strong)NSMutableArray*dataSource;
@property(nonatomic,strong)UITableView*tableview;
@property(nonatomic,strong)SJProcessModel*process;


@end

@implementation SJGrowUpViewController

-(SJProcessModel *)process{
    if (!_process) {
        _process=[[SJProcessModel alloc]init];
    }
    return _process;
}


-(SJHeadView *)headView{
    if (!_headView) {
        _headView=[[SJHeadView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
    }
    return _headView;
}

-(UITableView *)tableview{
    if (!_tableview) {
        _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
        _tableview.delegate=self;
        _tableview.dataSource=self;
        _tableview.separatorStyle=UITableViewCellSelectionStyleNone;
        _tableview.showsHorizontalScrollIndicator=NO;
        _tableview.tableHeaderView=self.headView;
    }
    return _tableview;
}


-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource=[NSMutableArray array];
        _dataSource=[[[SJDataManager manager]getAllRecord] mutableCopy];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"我的积分";
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [self setRightItem];
    [self.view addSubview:self.tableview];
}

#pragma mark Tabelview delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SJProcessCell*cell=[SJProcessCell initCellWithTableview:self.tableview];
    cell.process=self.dataSource[indexPath.row];
      return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}




-(void)setRightItem{
    UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(0, 0, 60, 30);
    [button setTitle:@"等级说明" forState:UIControlStateNormal];
    button.titleLabel.font=kSfont(13);
    [button setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [button addTarget:self action:@selector(didClickOnAction) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem*rightItem=[[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem=rightItem;
}
-(void)didClickOnAction{
    SJLevelViewController*levelVc=[[SJLevelViewController alloc]init];
    [self PushToVc:levelVc];
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
