//
//  SJMineViewController.m
//  ShellJournal
//
//  Created by 刘勇 on 2017/3/6.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "SJMineViewController.h"
#import "SJMeModel.h"
#import "SJMineCell.h"
#import "SJAboutUsViewController.h"
#import "SJSettingViewController.h"
#import "SJInfoViewController.h"
#import "SJMoreViewController.h"
#import "SJRecommendViewController.h"

@interface SJMineViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property(nonatomic,strong)UITableView*tableview;
@property(nonatomic,strong)SJMeModel*model;
@property(nonatomic,strong)NSArray*dataSource;
@property(nonatomic,strong)UIView*headView;
@property(nonatomic,strong)UIImageView*iconView;
@property(nonatomic,strong)UILabel*nickNameLabel;
@property(nonatomic,strong)UILabel*levelLabel;
@property(nonatomic,strong)UILabel*signatureLabel;
@property(nonatomic,strong)SJAboutUsViewController*aboutUsVc;
@property(nonatomic,strong)SJSettingViewController*setVc;
@property(nonatomic,strong)SJRecommendViewController*recommendVc;
@property(nonatomic,strong)SJMoreViewController*moreVc;
@property(nonatomic,strong)UIImagePickerController*imagePicker;

@end

@implementation SJMineViewController

-(UIImagePickerController *)imagePicker{
    if (!_imagePicker) {
        _imagePicker=[[UIImagePickerController alloc]init];
        _imagePicker.allowsEditing=YES;
        _imagePicker.delegate=self;
    }
    return _imagePicker;
}
-(UIImageView *)iconView{
    if (!_iconView) {
        NSString*path=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        _iconView=[[UIImageView alloc]initWithFrame:CGRectMake((ScreenWidth-100)/2, 20, 100, 100)];
        _iconView.layer.cornerRadius=50;
        _iconView.layer.masksToBounds=YES;
        _iconView.userInteractionEnabled=YES;
        _iconView.alpha=0.9;
        _iconView.layer.borderColor=kWhiteColor.CGColor;
        _iconView.layer.borderWidth=2;
        UITapGestureRecognizer*tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeHeadIcon)];
        
        _iconView.image=[[SJDataManager manager]currentInfo].head?[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",path,[[SJDataManager manager]currentInfo].personHeadImage]]:[UIImage imageNamed:@"default"];
        
        
        [_iconView addGestureRecognizer:tap];
    }
    return _iconView;
}
-(UIView *)headView{
    if (!_headView) {
        UIImage *image=[UIImage imageNamed:@"爱的牵手"];
        _headView=[[UIView alloc]initWithFrame:CGRectMake(0, -150, ScreenWidth, ScreenHeight/3+20)];
        _headView.backgroundColor=[UIColor colorWithPatternImage:image];
        _headView.layer.contents=(id)image.CGImage;
        _headView.contentMode=UIViewContentModeScaleAspectFill;
        _headView.clipsToBounds=YES;
        [_headView addSubview:self.iconView];
        [_headView addSubview:self.nickNameLabel];
        [_headView addSubview:self.levelLabel];
        [_headView addSubview:self.signatureLabel];
    }
    return _headView;
}
-(UILabel *)nickNameLabel{
    if (!_nickNameLabel) {
        _nickNameLabel=[[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth-200)/2, self.iconView.bottom+10, 200, 20)];
        _nickNameLabel.text=[[SJDataManager manager]currentInfo].personNickName;
        _nickNameLabel.textColor=kWhiteColor;
        _nickNameLabel.font=kBfont(15);
        _nickNameLabel.textAlignment=1;
    }
    return _nickNameLabel;
}
-(UILabel *)levelLabel{
    if (!_levelLabel) {
        _levelLabel=[[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth-200)/2, self.nickNameLabel.bottom+5, 200, 20)];
        _levelLabel.text=[NSString getLevelWithScore:[[[SJDataManager manager]currentInfo].personLevel integerValue]];
        _levelLabel.textColor=kWhiteColor;
        _levelLabel.font=kSfont(14);
        _levelLabel.textAlignment=1;
    }
    return _levelLabel;
}

-(UILabel *)signatureLabel{
    if (!_signatureLabel) {
        _signatureLabel=[[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth-200)/2,self.levelLabel.bottom+5, 200, 20)];
        _signatureLabel.text=[[SJDataManager manager]currentInfo].personSignature;
        _signatureLabel.textColor=kWhiteColor;
        _signatureLabel.font=kSfont(14);
        _signatureLabel.textAlignment=1;
    }
    return _signatureLabel;
}

-(SJAboutUsViewController *)aboutUsVc{
    if (!_aboutUsVc) {
        _aboutUsVc=[[SJAboutUsViewController alloc]init];
    }
    return _aboutUsVc;
}
-(SJSettingViewController *)setVc{
    if (!_setVc) {
        _setVc=[[SJSettingViewController alloc]init];
    }
    return _setVc;
}

-(SJMoreViewController *)moreVc{
    if (!_moreVc) {
        _moreVc=[[SJMoreViewController alloc]init];
    }
    return _moreVc;
}


-(UITableView *)tableview{
    if (!_tableview) {
        _tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:UITableViewStyleGrouped];
        _tableview.delegate=self;
        _tableview.dataSource=self;
        _tableview.contentInset=UIEdgeInsetsMake(ScreenHeight/3+20, 0, 0, 0);
        [_tableview addSubview:self.headView];
    }
    return _tableview;
}
-(SJMeModel *)model{
    if (!_model) {
        _model=[[SJMeModel alloc]init];
    }
    return _model;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.delegate = self;
    self.title=@"我的";
    [self.view addSubview:self.tableview];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reload) name:@"changeInfo" object:nil];
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}

-(void)changeHeadIcon{
   
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:@"请选择头像来源" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *actionCamera=[UIAlertAction actionWithTitle:@"拍照获取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:self.imagePicker animated:YES completion:nil];
    }];
    UIAlertAction *actionPhotoLIbrary=[UIAlertAction actionWithTitle:@"相册获取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.imagePicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:self.imagePicker animated:YES completion:nil];
    }];
    UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:actionCamera];
    [alertController addAction:actionPhotoLIbrary];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];

}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo{
    
    NSString*path=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString*iconStr=[NSString stringWithFormat:@"default_%@.png",userAccount];
    [self saveImage:image withName:iconStr];
    
    [[SJDataManager manager]updateUserHeadWithPersonImageName:iconStr];
    [[SJDataManager manager]updateHead];
    self.iconView.image=[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",path,iconStr]];
    [self.navigationController setNavigationBarHidden:YES animated:YES];

    [self dismiss];
    
}

- (void)saveImage:(UIImage *)currentImage withName:(NSString *)imageName{
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.8);
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    [imageData writeToFile:fullPath atomically:NO];
}

-(void)reload{
    self.signatureLabel.text=[[SJDataManager manager]currentInfo].personSignature;
    self.nickNameLabel.text=[[SJDataManager manager]currentInfo].personNickName;
}
#pragma mark Tabelview delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section==0?2:4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SJMineCell*cell=[SJMineCell registerTableViewWithTabelview:self.tableview];
    self.dataSource=self.model.meArray;
    if (indexPath.section==0) {
        cell.model=self.dataSource[indexPath.row];
    }else{
        cell.model=self.dataSource[indexPath.row+2];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section==0?10:0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            SJInfoViewController *infoVc=[[SJInfoViewController alloc]init];
            [self PushToVc:infoVc];
        }else{
            [self PushToVc:self.setVc];
        }
    }else{
        if (indexPath.row==0) {
            [self PushToVc:self.moreVc];
        }else if (indexPath.row==1){
            [self PushToVc:self.aboutUsVc];
        }else if (indexPath.row==2){
            
        }else{
            SJRecommendViewController*recommendVc=[[SJRecommendViewController alloc]init];
            [self PushToVc:recommendVc];
        }
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    float offsetY=scrollView.contentOffset.y;
    self.headView.frame=CGRectMake(0, offsetY, ScreenWidth,ABS(offsetY));
    self.iconView.frame=CGRectMake((ScreenWidth-100)/2, 20+(ABS(offsetY)-ScreenHeight/3-20), 100, 100);
    self.nickNameLabel.frame=CGRectMake((ScreenWidth-200)/2, self.iconView.bottom+10, 200, 20);
    self.levelLabel.frame=CGRectMake((ScreenWidth-200)/2, self.nickNameLabel.bottom+5, 200, 20);
    self.signatureLabel.frame=CGRectMake((ScreenWidth-200)/2, self.levelLabel.bottom+5, 200, 20);
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
