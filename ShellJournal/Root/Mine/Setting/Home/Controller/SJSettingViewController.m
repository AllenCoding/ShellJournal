//
//  SJSettingViewController.m
//  ShellJournal
//
//  Created by 刘勇 on 2017/4/10.
//  Copyright © 2017年 liuyong. All rights reserved.
//


#import "SJSetCell.h"
#import "SJSetModel.h"
#import "SJSettingViewController.h"
#import "SJSafetyHomeViewController.h"
#import "SJCommonSetViewController.h"
#import "SJPrivateViewController.h"

@interface SJSettingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView*tableview;
@property(nonatomic,strong)NSArray*dataSource;
@property(nonatomic,strong)SJSetModel*model;

@end

@implementation SJSettingViewController

#pragma mark 懒加载
-(NSArray *)dataSource{
        _dataSource=self.model.setArray;
    return _dataSource;
}
-(SJSetModel *)model{
    if (!_model) {
        _model=[[SJSetModel alloc]init];
    }
    return _model;
}
-(UITableView *)tableview{
    if (!_tableview) {
        _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
        _tableview.delegate=self;
        _tableview.dataSource=self;
    }
    return _tableview;
}

-(void)viewWillAppear:(BOOL)animated{
    [self.tableview reloadData];
}

#pragma mark 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
     self.title=@"设置";
    [self.view addSubview:self.tableview];
    NSLog(@"%s",__func__);
}

#pragma tableview delegate method
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section==2?5:1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SJSetCell*cell=[SJSetCell registerTableviewWithTableview:self.tableview];
    if (indexPath.section==0) {
        cell.model=self.dataSource[indexPath.row];
    }else if (indexPath.section==1){
        cell.model=self.dataSource[indexPath.row+1];
    }else if (indexPath.section==2){
        cell.model=self.dataSource[indexPath.row+2];
    }else{
        cell.model=self.dataSource[indexPath.row+7];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15.0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1.0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        SJSafetyHomeViewController*safetyHomeVc=[[SJSafetyHomeViewController alloc]init];
        [self PushToVc:safetyHomeVc];
    }else if (indexPath.section==1){

        SJPrivateViewController*privateVc=[[SJPrivateViewController alloc]init];
        [self PushToVc:privateVc];
    
    }else if (indexPath.section==2){
        self.model=self.dataSource[indexPath.row+2];
        if (indexPath.row!=4) {
            SJCommonSetViewController*commonVc=[[SJCommonSetViewController alloc]init];
            commonVc.itemTitle=self.model.leftText;
            [self PushToVc:commonVc];
        }
    }else{
        
        SJLoginViewController*loginVc=[[SJLoginViewController alloc]init];
        [[UIApplication sharedApplication].keyWindow setRootViewController:loginVc];
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"login"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
