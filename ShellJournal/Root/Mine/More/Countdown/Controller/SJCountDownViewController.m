//
//  SJCountDownViewController.m
//  ShellJournal
//
//  Created by Tian on 2017/6/3.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "SJCountDownViewController.h"
#import "SJAddTaskViewController.h"
#import "SJTaskDetailViewController.h"
#import "SJCountCell.h"

@interface SJCountDownViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView*tableview;
@property(nonatomic,strong)NSMutableArray*dataSource;
@property(nonatomic,strong)UIImageView*topHeadView;
@property(nonatomic,strong)UILabel*untilLabel;
@property(nonatomic,strong)UILabel*taskLabel;
@property(nonatomic,strong)UILabel*dayLabel;
@property(nonatomic,strong)UILabel*timeLabel;
@property(nonatomic,strong)SJCountModel*count;


@end

@implementation SJCountDownViewController

-(SJCountModel *)count{
    if (!_count) {
        _count=self.dataSource.count?self.dataSource[0]:nil;
    }
    return _count;
}

-(UILabel *)untilLabel{
    if (!_untilLabel) {
        _untilLabel=[[UILabel alloc]initWithFont:kSfont(17) textColor:kWhiteColor textAlignment:1];
        _untilLabel.frame=CGRectMake((ScreenWidth-100)/2, 20, 100, 20);
        _untilLabel.text=@"距离";
        [self.topHeadView addSubview:_untilLabel];
    }
    return _untilLabel;
}

-(UILabel *)taskLabel{
    if (!_taskLabel) {
        _taskLabel=[[UILabel alloc]initWithFont:kSfont(20) textColor:kWhiteColor textAlignment:1];
        _taskLabel.frame=CGRectMake((ScreenWidth-300)/2, self.untilLabel.bottom, 300, 30);
        _taskLabel.text=self.count.countTitle;
        [self.topHeadView addSubview:_taskLabel];
    }
    return _taskLabel;
}

-(UILabel *)dayLabel{
    if (!_dayLabel) {
        _dayLabel=[[UILabel alloc]initWithFont:kSfont(60) textColor:kWhiteColor textAlignment:1];
        _dayLabel.frame=CGRectMake((ScreenWidth-200)/2, self.taskLabel.bottom, 200, 100);
        NSDate*date=[NSDate date];
        NSInteger nowDay=date.timeIntervalSince1970;
        NSInteger num=self.count.countTime-nowDay<12*3600?0:1;
        _dayLabel.text=self.dataSource.count?[NSString stringWithFormat:@"%ld",((self.count.countTime-nowDay)/(24*3600)+num)]:@"";
        [self.topHeadView addSubview:_dayLabel];
    }
    return _dayLabel;
}

-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel=[[UILabel alloc]initWithFont:kSfont(17) textColor:kWhiteColor textAlignment:1];
        _timeLabel.frame=CGRectMake((ScreenWidth-300)/2, self.dayLabel.bottom, 300, 30);
        _timeLabel.text=self.count.time;
        [self.topHeadView addSubview:_timeLabel];
     }
    return _timeLabel;
}

-(UIImageView *)topHeadView{
    if (!_topHeadView) {
        _topHeadView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 220)];
        _topHeadView.image=[UIImage imageNamed:@"爱的牵手"];
        [_topHeadView addSubview:self.dayLabel];
        [_topHeadView addSubview:self.timeLabel];
        [_topHeadView addSubview:self.taskLabel];
        [_topHeadView addSubview:self.untilLabel];
    }
    return _topHeadView;
}


-(UITableView *)tableview{
    if (!_tableview) {
        _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
        _tableview.delegate=self;
        _tableview.dataSource=self;
        _tableview.backgroundColor=kWhiteColor;
        _tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableview.showsVerticalScrollIndicator=NO;
        _tableview.tableHeaderView=self.topHeadView;
    }
    return _tableview;
}
-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource=[NSMutableArray new];
        _dataSource=[NSMutableArray arrayWithArray:[[SJDataManager manager]showAllCountDownTasks]];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor=kWhiteColor;
    self.title=@"倒计时";
    [self setRightItem];
    [self.view addSubview:self.tableview];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadTableView) name:@"addTask" object:nil];

    
}


-(void)reloadTableView{
    self.dataSource=[[SJDataManager manager]showAllCountDownTasks];
    [self.tableview reloadData];
    self.count=self.dataSource.count?self.dataSource[0]:nil;

    self.taskLabel.text=self.count.countTitle;
    self.timeLabel.text=self.count.time;
    NSDate*date=[NSDate date];
    NSInteger nowDay=date.timeIntervalSince1970;
    NSInteger num=self.count.countTime-nowDay<12*3600?0:1;
    self.dayLabel.text=self.dataSource.count?[NSString stringWithFormat:@"%ld",((self.count.countTime-nowDay)/(24*3600)+num)]:@"";
}

-(void)setRightItem{
    UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(0, 0, 25, 25);
    [button setBackgroundImage:[UIImage imageNamed:@"NavgationBar_write"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(didClickOnAction) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem*rightItem=[[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem=rightItem;
}

-(void)didClickOnAction{
    SJAddTaskViewController*addVc=[[SJAddTaskViewController alloc]init];
    [self presentToVc:addVc];
    
}


#pragma UITabelview  Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SJCountCell*cell=[SJCountCell initCellWithTableview:self.tableview];
    SJCountModel*model=self.dataSource[indexPath.row];
    cell.model=model;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
//定义编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}
//进入编辑模式，按下出现的编辑按钮后,进行删除操作
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        SJCountModel*model=self.dataSource[indexPath.row];
        [[SJDataManager manager]deleteCountDownTaskWithCountId:model.countId];
        [self.dataSource removeObjectAtIndex:indexPath.row];
        [self.tableview deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self reloadTableView];
        
            }
}
//修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
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
