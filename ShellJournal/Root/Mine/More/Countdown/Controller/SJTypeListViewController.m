//
//  SJTypeListViewController.m
//  ShellJournal
//
//  Created by Tian on 2017/6/4.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "SJTypeListViewController.h"
#import "SJTypeModel.h"
@interface SJTypeListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView*tableview;
@property(nonatomic,strong)NSMutableArray*dataSource;
@property(nonatomic,strong)SJTypeModel*model;
@property(nonatomic,strong)NSIndexPath *lastPath;

@end

@implementation SJTypeListViewController


-(UITableView *)tableview{
    if (!_tableview) {
        _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
        _tableview.delegate=self;
        _tableview.dataSource=self;
        _tableview.backgroundColor=[UIColor groupTableViewBackgroundColor];
        _tableview.showsVerticalScrollIndicator=NO;
    }
    return _tableview;
}

-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource=[NSMutableArray new];
        _dataSource=[NSMutableArray arrayWithArray:self.model.dataArray];
    }
    return _dataSource;
}

-(SJTypeModel *)model{
    if (!_model) {
        _model=[[SJTypeModel alloc]init];
    }
    return _model;
}


- (IBAction)close:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableview];
}

#pragma tableview delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell*cell=[self.tableview dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    NSInteger row = [indexPath row];
    NSInteger oldRow = [_lastPath row];
    if (row == oldRow && _lastPath!=nil) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    self.model=self.dataSource[indexPath.row];
    cell.imageView.image=[UIImage imageNamed:self.model.iconUrl];
    cell.textLabel.text=self.model.title;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger newRow = [indexPath row];
    
    NSInteger oldRow = (_lastPath !=nil)?[_lastPath row]:-1;
    
    if (newRow != oldRow) {
        
        UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
        newCell.accessoryType = UITableViewCellAccessoryCheckmark;
        UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:_lastPath];
        oldCell.accessoryType = UITableViewCellAccessoryNone;
        _lastPath = indexPath;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.model=self.dataSource[_lastPath.row];
    
    self.typeBlock(self.model);
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    NSLog(@"%@",self.model.title);
    
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
