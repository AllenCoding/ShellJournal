//
//  SJDetailViewController.m
//  ShellJournal
//
//  Created by 刘勇 on 2017/3/28.
//  Copyright © 2017年 liuyong. All rights reserved.

#import "SJDetailCell.h"
#import "SJDetailViewController.h"
#import "UILabel+Addition.h"
#import "SJHomeFooterView.h"
#import "SJScanImageViewController.h"

@interface SJDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView*tableview;
@property(nonatomic,strong)UILabel*textLabel;
@property(nonatomic,strong)SJHomeFooterView*footView;

@end

@implementation SJDetailViewController

-(SJHomeFooterView *)footView{
    if (!_footView) {
        NSArray*array=[self.diary.imageName componentsSeparatedByString:@","];
        _footView=[[SJHomeFooterView alloc]initFooterViewWithImages:array];
    }
    return _footView;
}

-(UITableView *)tableview{
    if (!_tableview) {
        _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
        _tableview.delegate=self;
        _tableview.dataSource=self;
        _tableview.backgroundColor=[UIColor groupTableViewBackgroundColor];
        _tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableview.showsVerticalScrollIndicator=NO;
        UIImage*image=[UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",self.diary.backgroundImageName]];
        _tableview.backgroundColor=[UIColor colorWithPatternImage:image];
        _tableview.layer.contents=(id)image.CGImage;
        if (![self.diary.imageName isEqualToString:@" "]&&[self.diary.imageName componentsSeparatedByString:@","].count>=1) {
            _tableview.tableFooterView=self.footView;
        }
    }
    return _tableview;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"日记详情";
    [self.view addSubview:self.tableview];
    [self setRightItem];
    self.view.backgroundColor=kWhiteColor;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(scanImage:) name:@"scanImage" object:nil];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UILabel*lab=[UILabel getLineSpaceLabelWithFrame:self.textLabel.frame contentString:self.diary.content withFont:kSfont(13) withLineSpace:1 textlengthSpace:@1 paragraphSpacing:2];
    if ([[SJDataManager manager]currentInfo].boolAddress) {
         return 80+lab.frame.size.height;
    }else{
        return 40+lab.frame.size.height;
    }
   
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPat{
    SJDetailCell*cell=[SJDetailCell configCellWithTabelView:self.tableview];
    cell.diary=self.diary;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.backgroundColor=kClearColor;
    self.textLabel=cell.contentLabel;
    return cell;
}
-(void)setRightItem{
    UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(0, 0, 25, 25);
    [button setBackgroundImage:[UIImage imageNamed:@"NavgationBar_clean"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(didClickOnAction) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem*rightItem=[[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem=rightItem;
}
-(void)didClickOnAction{
    UIAlertController*alert=[UIAlertController alertControllerWithTitle:@"确认删除日记" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction*deleteAction=[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[SJDataManager manager]disableDiaryWithDiaryId:self.diary.diaryId];
        [[SJDataManager manager]updateLevelWithDiaryStatus:0];
        SJProcessModel*model=[[SJProcessModel alloc]init];
        model.processtime=[NSString currentTime];
        model.colorStr=[NSString randomString];
        model.desc=@"删除了一篇日记！";
        model.author=userAccount;
        model.score=@"-3";
        [[SJDataManager manager]insertProcessWithProcessModel:model];
    
        
        [[NSNotificationCenter defaultCenter]postNotificationName:@"deleteDiary" object:nil];
        [self Pop];
    }];
    UIAlertAction*cancelAction=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        return ;
    }];
    [alert addAction:cancelAction];
    [alert addAction:deleteAction];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)scanImage:(NSNotification*)noti{
    SJScanImageViewController*imageVc=[[SJScanImageViewController alloc]init];
    imageVc.images=[self.diary.imageName componentsSeparatedByString:@","];
    imageVc.tag=noti.object[@"tag"];
    [self presentToVc:imageVc];
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
