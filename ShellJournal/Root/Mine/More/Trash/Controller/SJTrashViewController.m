//
//  SJTrashViewController.m
//  ShellJournal
//
//  Created by 刘勇 on 2017/5/31.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "SJTrashViewController.h"
#import "SJCustomEmptyView.h"
#import "SJDiaryModel.h"
@interface SJTrashViewController ()<UITableViewDelegate,UITableViewDataSource,EmptyViewDelegate>

@property(nonatomic,strong)UITableView*tableview;
@property(nonatomic,strong)NSMutableArray*data;
@property(nonatomic,strong)SJCustomEmptyView*emptyViews;
@property(nonatomic,strong)UIView *bottomView;
@property(nonatomic,strong)UIButton*deletBtn;
@property(nonatomic,strong)UIButton*recoverBtn;
@property(nonatomic,strong)UIButton*selectBtn;
@property(nonatomic,strong)UIButton*rightBtn;
@property (strong, nonatomic) NSMutableArray *deleteArr;
@property (assign, nonatomic) NSInteger deleteNum;

@end

@implementation SJTrashViewController


-(NSMutableArray *)deleteArr{
    if (!_deleteArr) {
        _deleteArr=[NSMutableArray array];
    }
    return _deleteArr;
}


-(SJCustomEmptyView *)emptyViews{
    if (!_emptyViews) {
        _emptyViews=[[SJCustomEmptyView alloc]initEmptyViewWithBtnTitle:nil];
        _emptyViews.delegate=self;
        _emptyViews.frame=CGRectMake(0, (ScreenHeight-64-240)/2, ScreenWidth, 240);
        _emptyViews.backgroundColor=[UIColor groupTableViewBackgroundColor];
        _emptyViews.hidden=self.data.count>0;
    }
    return _emptyViews;
}

-(UITableView *)tableview{
    if (!_tableview) {
        _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64-40) style:UITableViewStylePlain];
        _tableview.delegate=self;
        _tableview.dataSource=self;
        _tableview.backgroundColor=[UIColor groupTableViewBackgroundColor];
        _tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableview.showsVerticalScrollIndicator=NO;
    }
    return _tableview;
}

-(NSMutableArray *)data{
    if (!_data) {
        _data=[NSMutableArray new];
        _data=[NSMutableArray arrayWithArray:[[SJDataManager manager]showAllTrashDiarys]];
    }
    return _data;
}

-(UIButton *)rightBtn{
    if (!_rightBtn) {
        _rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.frame=CGRectMake(0, 0, 30, 30);
        [_rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
        _rightBtn.titleLabel.font=kSfont(14);
        [_rightBtn addTarget:self action:@selector(didClickOnAction:) forControlEvents:UIControlEventTouchUpInside];
        _rightBtn.selected=NO;
    }
    return _rightBtn;
}

-(UIButton *)selectBtn{
    if (!_selectBtn) {
        _selectBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _selectBtn.frame=CGRectMake(20, 5, 80, 30);
        [_selectBtn setTitle:@"全选" forState:UIControlStateNormal];
        [_selectBtn setTitle:@"取消全选" forState:UIControlStateSelected];
        _selectBtn.layer.cornerRadius=5;
        _selectBtn.layer.masksToBounds=YES;
        _selectBtn.tag=1000;
        [_selectBtn setBackgroundColor:kCommonBgColor];
        _selectBtn.titleLabel.font=kSfont(14);
        [_selectBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [_selectBtn addTarget:self action:@selector(clickOn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectBtn;

}

-(UIButton *)deletBtn{
    if (!_deletBtn) {
        _deletBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _deletBtn.frame=CGRectMake(self.selectBtn.right+(ScreenWidth-300)/3, 5, 100, 30);
        [_deletBtn setTitle:[NSString stringWithFormat:@"删除(%lu)",self.deleteNum] forState:UIControlStateNormal];
        _deletBtn.layer.cornerRadius=5;
        _deletBtn.layer.masksToBounds=YES;
        _deletBtn.tag=1001;
        [_deletBtn setBackgroundColor:kLightGrayColor];
        _deletBtn.titleLabel.font=kSfont(14);
        [_deletBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [_deletBtn addTarget:self action:@selector(clickOn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deletBtn;
}

-(UIButton *)recoverBtn{
    if (!_recoverBtn) {
       _recoverBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _recoverBtn.frame=CGRectMake(self.deletBtn.right+(ScreenWidth-300)/3, 5, 100, 30);
        [_recoverBtn setTitle:[NSString stringWithFormat:@"还原(%lu)",self.deleteNum] forState:UIControlStateNormal];
        _recoverBtn.layer.cornerRadius=5;
        _recoverBtn.layer.masksToBounds=YES;
        _recoverBtn.tag=1002;
        [_recoverBtn setBackgroundColor:kLightGrayColor];
        _recoverBtn.titleLabel.font=kSfont(14);
        [_recoverBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [_recoverBtn addTarget:self action:@selector(clickOn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _recoverBtn;
}

-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView=[[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight-64-40, ScreenWidth, 40)];
        [self.view addSubview:_bottomView];
        [_bottomView addSubview:self.selectBtn];
        [_bottomView addSubview:self.deletBtn];
        [_bottomView addSubview:self.recoverBtn];

    }
    return _bottomView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    self.title=@"垃圾篓";
    [self.view addSubview:self.tableview];
    [self.view addSubview:self.emptyViews];
    [self setRightItem];

}

-(void)setRightItem{
    
    UIBarButtonItem*rightItem=[[UIBarButtonItem alloc]initWithCustomView:self.rightBtn];
    self.navigationItem.rightBarButtonItem=rightItem;
    self.rightBtn.hidden=self.data.count==0;
    
    
}

-(void)didClickOnAction:(UIButton*)btn{
    if (!btn.selected) {
       btn.selected = YES;
       self.tableview.editing=YES;
       [btn setTitle:@"完成" forState:UIControlStateNormal];
       [self.view addSubview:self.bottomView];
    }else{
        btn.selected=NO;
        self.tableview.editing=NO;
        [btn setTitle:@"编辑" forState:UIControlStateNormal];
        [self.bottomView removeFromSuperview];
        [self.deleteArr removeAllObjects];
        self.deleteNum=0;
    }
}


-(void)clickOn:(UIButton*)sender{
    if (sender.tag==1000) {
        //全选
        if (self.tableview.editing) {
            if (!self.selectBtn.selected) {
                self.selectBtn.selected = YES;
                for (int i = 0; i < self.data.count; i++) {
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
                    [self.tableview selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionBottom];
                }
                [self.deleteArr addObjectsFromArray:self.data];
                self.deleteNum = self.data.count;
                [self.deletBtn setTitle:[NSString stringWithFormat:@"删除(%lu)",self.deleteNum] forState:UIControlStateNormal];
                [self.recoverBtn setTitle:[NSString stringWithFormat:@"还原(%lu)",self.deleteNum] forState:UIControlStateNormal];
                [self.deletBtn setBackgroundColor:kRedColor];
                [self.recoverBtn setBackgroundColor:kRedColor];
                
            }else{
                self.selectBtn.selected = NO;
                [self.deleteArr removeAllObjects];
                for (int i = 0; i < self.data.count; i++) {
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
                    [self.tableview deselectRowAtIndexPath:indexPath animated:NO];
                }
                self.deleteNum = 0;
                [self.deletBtn setTitle:[NSString stringWithFormat:@"删除(%lu)",self.deleteNum] forState:UIControlStateNormal];
                [self.recoverBtn setTitle:[NSString stringWithFormat:@"还原(%lu)",self.deleteNum] forState:UIControlStateNormal];
                [self.deletBtn setBackgroundColor:kLightGrayColor];
                [self.recoverBtn setBackgroundColor:kLightGrayColor];
                self.rightBtn.hidden=self.data.count==0;
                
            }

        }
           }else if (sender.tag==1001){
        //删除
            if (self.deleteArr.count>0) {
                UIAlertController*alert=[UIAlertController alertControllerWithTitle:@"" message:@"日记删除后将无法恢复，确认删除？" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction*deleteAction=[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self.data removeObjectsInArray:self.deleteArr];
                    self.deleteNum = 0;
                    [self.deletBtn setTitle:[NSString stringWithFormat:@"删除(%lu)",self.deleteNum] forState:UIControlStateNormal];
                    [self.recoverBtn setTitle:[NSString stringWithFormat:@"还原(%lu)",self.deleteNum] forState:UIControlStateNormal];
                    self.selectBtn.selected = NO;
                    [self reloadViews];
                    self.rightBtn.hidden=self.data.count==0;
                    for (int index=0; index<self.deleteArr.count; index++) {
                        SJDiaryModel*diary=self.deleteArr[index];
                        [[SJDataManager manager]deleteDiaryWithDiaryId:diary.diaryId];
                        [self Pop];
                    }
                }];
                UIAlertAction*cancelAction=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    return ;
                }];
                [alert addAction:cancelAction];
                [alert addAction:deleteAction];
                [self presentViewController:alert animated:YES completion:nil];
        }
    }else{
        //恢复
        [self.data removeObjectsInArray:self.deleteArr];
        self.deleteNum = 0;
        [self.deletBtn setTitle:[NSString stringWithFormat:@"删除(%lu)",self.deleteNum] forState:UIControlStateNormal];
        [self.recoverBtn setTitle:[NSString stringWithFormat:@"还原(%lu)",self.deleteNum] forState:UIControlStateNormal];
        self.selectBtn.selected = NO;
        [self reloadViews];
        self.rightBtn.hidden=self.data.count==0;
        for (int index=0; index<self.deleteArr.count; index++) {
            SJDiaryModel*diary=self.deleteArr[index];
            [[SJDataManager manager]enableDiaryWithDiaryId:diary.diaryId];
        }
        [[NSNotificationCenter defaultCenter]postNotificationName:@"newDiary" object:nil];
        [self Pop];
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    SJDiaryModel*diary=self.data[indexPath.row];
    cell.textLabel.text =[NSString stringWithFormat:@"%@-%@",diary.time,diary.week];
    cell.textLabel.font=kSfont(14);
    return cell;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.tableview.editing) {
        [self.deleteArr addObject:[self.data objectAtIndex:indexPath.row]];
        self.deleteNum += 1;
        [self.deletBtn setTitle:[NSString stringWithFormat:@"删除(%lu)",self.deleteNum] forState:UIControlStateNormal];
        [self.recoverBtn setTitle:[NSString stringWithFormat:@"还原(%lu)",self.deleteNum] forState:UIControlStateNormal];
        [self.deletBtn setBackgroundColor:kRedColor];
        [self.recoverBtn setBackgroundColor:kRedColor];
    }
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.tableview.editing) {
        [self.deleteArr removeObject:[self.data objectAtIndex:indexPath.row]];
        self.deleteNum -= 1;
        [self.deletBtn setTitle:[NSString stringWithFormat:@"删除(%lu)",self.deleteNum] forState:UIControlStateNormal];
        [self.recoverBtn setTitle:[NSString stringWithFormat:@"还原(%lu)",self.deleteNum] forState:UIControlStateNormal];
        if(self.deleteArr.count==0){
            [self.deletBtn setBackgroundColor:kLightGrayColor];
            [self.recoverBtn setBackgroundColor:kLightGrayColor];
        }
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return [NSString stringWithFormat:@"共计%ld条数据",self.data.count];
}


-(void)reloadViews{
    [self.tableview reloadData];
    self.emptyViews.hidden=self.data.count>0;
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
