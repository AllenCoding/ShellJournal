//
//  SJCommonSetViewController.m
//  ShellJournal
//  Created by 刘勇 on 2017/4/12.
//  Copyright © 2017年 liuyong. All rights reserved.


#import "SJCommonSetViewController.h"
#import "SJCellModel.h"
#import "SJCommonCell.h"

@interface SJCommonSetViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView*tableview;

@property(nonatomic,strong)NSArray*data;

@property(nonatomic,strong)SJCellModel*model;

@end

@implementation SJCommonSetViewController

-(SJCellModel *)model{
    if (!_model) {
        _model=[[SJCellModel alloc]init];
    }
    return _model;
}

-(UITableView *)tableview{
    if (!_tableview) {
        _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStyleGrouped];
        _tableview.delegate=self;
        _tableview.dataSource=self;
        _tableview.showsVerticalScrollIndicator=NO;
    }
    return _tableview;
}

#pragma mark Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=self.itemTitle;
    [self.view addSubview:self.tableview];
    [self reloadCellData];
    
}

-(void)reloadCellData{
    if ([self.itemTitle isEqualToString:@"天气情况"]) {
        _data=self.model.weather;
    }else if ([self.itemTitle isEqualToString:@"地址显示"]){
        _data=self.model.address;
    }else if ([self.itemTitle isEqualToString:@"图片日记"]){
        _data=self.model.picture;
    }else{
        _data=self.model.voice;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SJCommonCell*cell=[SJCommonCell regiterCellWithTableView:self.tableview];
    cell.model=self.data[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    NSInteger isSelected=[[NSString stringWithFormat:@"%ld",indexPath.row] integerValue];
    if ([self.itemTitle isEqualToString:@"天气情况"]) {
        
        [[SJDataManager manager]updateUserWeatherSetting:!isSelected];
    }else if ([self.itemTitle isEqualToString:@"地址显示"]){
        [[SJDataManager manager]updateUserAddressSetting:!isSelected];

    }else if ([self.itemTitle isEqualToString:@"图片日记"]){
        [[SJDataManager manager]updateUserImageSetting:!isSelected];
        
    }else{
        
        [[SJDataManager manager]updateUserVoiceSetting:!isSelected];
    }
    [self.tableview reloadData];
    [self reloadCellData];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
