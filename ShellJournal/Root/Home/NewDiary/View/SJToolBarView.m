
//  SJToolBarView.m
//  ShellJournal
//  Created by 刘勇 on 2017/3/7.
//  Copyright © 2017年 liuyong. All rights reserved.


#import "SJToolBarView.h"
#import "SJWallView.h"
#import "SJPhotoView.h"
#import "SJWeatherView.h"
#import "SJAddressView.h"
#import "SJVoiceView.h"

@interface SJToolBarView()

@property(nonatomic,strong)UIView*topView;
@property(nonatomic,strong)UILabel*linelabel;
@property(nonatomic,strong)NSArray*imageNames;
@property (nonatomic, assign)CGFloat currentHeight;
@property(nonatomic,strong)SJWallView*wallView;
@property(nonatomic,strong)SJPhotoView*photoView;
@property(nonatomic,strong)SJWeatherView*weatherView;
@property(nonatomic,strong)SJAddressView*addressView;
@property(nonatomic,strong)SJVoiceView*voiceView;
@property(nonatomic,strong)UIButton*keyBtn;
@property(nonatomic,strong)UILabel*edgeLabel;

@end

@implementation SJToolBarView

-(UIButton *)keyBtn{
    if (!_keyBtn) {
        _keyBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _keyBtn.frame=CGRectMake(ScreenWidth-60, self.top, 60, 20);
        _keyBtn.backgroundColor=kRedColor;
        [_keyBtn setBackgroundImage:[UIImage imageNamed:@"default_keyboard"] forState:UIControlStateNormal];
    }
    return _keyBtn;
}

-(UIView *)topView{
    if (!_topView) {
        _topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,self.frame.size.width, 40)];
        [self addSubview:_topView];
    }
    return _topView;
}

-(UILabel *)linelabel{
    if (!_linelabel) {
        _linelabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 41, ScreenWidth, 1)];
        [_linelabel setBackgroundColor:kLightGrayColor];
        [self addSubview:_linelabel];
    }
    return _linelabel;
}

-(SJWallView *)wallView{
    if (!_wallView) {
        NSMutableArray*titles=[NSMutableArray array];
        for (int index=1; index<30; index++) {
            NSString*title=[NSString stringWithFormat:@"Background%d",index];
            [titles addObject:title];
        }
        NSArray*array=[NSArray arrayWithArray:titles];
        _wallView=[[SJWallView alloc]initWallViewFrame:CGRectMake(0, 0, ScreenWidth, self.currentHeight-60) WithImageArrays:array];
    }
    return _wallView;
}

-(SJWeatherView *)weatherView{
    if (!_weatherView) {
        _weatherView=[[SJWeatherView alloc]initWeatherViewWithFrame:CGRectMake(0, 0, ScreenWidth, self.currentHeight-60)];
    }
    return _weatherView;
}

-(SJVoiceView *)voiceView{
    if (!_voiceView) {
        _voiceView=[[SJVoiceView alloc]initVoiceViewWithFrame:CGRectMake(0, 0, ScreenWidth, self.currentHeight-60)];
    }
    return _voiceView;
}

-(SJPhotoView *)photoView{
    if (!_photoView) {
        _photoView=[[SJPhotoView alloc]initPhotoViewWithFrame:CGRectMake(0, 0, ScreenWidth, self.currentHeight-60)];
    }
    return _photoView;
}

-(SJAddressView *)addressView{
    if (!_addressView) {
        _addressView=[[SJAddressView alloc]initAddressViewWithFrame:CGRectMake(0, 10, ScreenWidth, self.currentHeight-60)];
    }
    return _addressView;
}



#pragma mark Init Method
-(instancetype)initToolBarViewWithFrame:(CGRect)frame btnImageNamesArray:(NSArray *)imageNames{
    if (self=[super initWithFrame:frame]) {
        _imageNames=imageNames;
        [self addSubview:self.linelabel];
        [self addSubview:self.topView];
        [self setUpViews];
        self.backgroundColor=kWhiteColor;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShow:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillHide:)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self
                                                selector:@selector(getPhotos:)
                                                    name:@"pickPhoto"
                                                  object:nil];
        
        
        
    }
    return self;
}

-(void)getPhotos:(NSNotification*)noti{
    NSMutableArray*array=noti.object;
    self.edgeLabel.text=[NSString stringWithFormat:@"%ld",array.count];
    self.edgeLabel.hidden=array.count>=1?NO:YES;
}
#pragma mark 键盘显示的监听方法
-(void) keyboardWillShow:(NSNotification *) note{
    // 获取键盘的位置和大小
    CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    self.currentHeight = keyboardBounds.size.height + 64;
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.currentHeight);
    [self show];
}
#pragma mark 键盘隐藏的监听方法
-(void) keyboardWillHide:(NSNotification *) note{
    
}
-(void)setUpViews{
    for (int index=0; index<self.imageNames.count; index++) {
        UIButton*btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(20+index*(30+30), 5, 30, 30);
        [btn setBackgroundImage:[UIImage imageNamed:self.imageNames[index]] forState:UIControlStateNormal];
        btn.tag=index;
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self.topView addSubview:btn];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 42, self.frame.size.width, self.frame.size.height-42)];
        view.tag = 100 + index;
        view.hidden = YES;
        [self addSubview:view];
    }
    
    UILabel*edgeLabel=[[UILabel alloc]initWithFrame:CGRectMake(100, 3, 20, 20)];
    edgeLabel.backgroundColor=kRedColor;
    edgeLabel.layer.cornerRadius=10;
    edgeLabel.layer.masksToBounds=YES;
    edgeLabel.textAlignment=1;
    edgeLabel.font=kSfont(14);
    edgeLabel.textColor=kWhiteColor;
    [self addSubview:edgeLabel];
    self.edgeLabel=edgeLabel;
    self.edgeLabel.hidden=YES;
    [self addSubview:self.keyBtn];
}

-(void)click:(UIButton*)sender{
    
    UIView *view = [self viewWithTag:100 + sender.tag];
    view.hidden = NO;
    [self bringSubviewToFront:view];
    self.currentHeight = view.frame.size.height;
    if (view.tag==100) {
        [self.voiceView removeFromSuperview];
        [self.weatherView removeFromSuperview];
        [self.photoView removeFromSuperview];
        [self.addressView removeFromSuperview];
        [view addSubview:self.wallView];
    }else if(view.tag==101){
        [self.wallView removeFromSuperview];
        [self.weatherView removeFromSuperview];
        [self.addressView removeFromSuperview];
        [self.voiceView removeFromSuperview];
        [view addSubview:self.photoView];
    }else if(view.tag==102){
        [self.voiceView removeFromSuperview];
        [self.addressView removeFromSuperview];
        [self.photoView removeFromSuperview];
        [self.wallView removeFromSuperview];
        [view addSubview:self.weatherView];
        
    }else if(view.tag==103){
        [self.voiceView removeFromSuperview];
        [self.photoView removeFromSuperview];
        [self.wallView removeFromSuperview];
        [self.weatherView removeFromSuperview];
        [view addSubview:self.addressView];
    }else{
        [self.photoView removeFromSuperview];
        [self.wallView removeFromSuperview];
        [self.weatherView removeFromSuperview];
        [self.addressView removeFromSuperview];
        [view addSubview:self.voiceView];
    }
    [self show];
    if (self.myBlock) {
        self.myBlock(sender.tag);
    }
}

#pragma mark delegate Method
-(void)dismiss{
    [UIView animateWithDuration:0.25 animations:^{
        self.frame=CGRectMake(0, ScreenHeight - 40 - 64, self.frame.size.width,self.frame.size.height);
    }];
}
-(void)show{
    [UIView animateWithDuration:0.35 animations:^{
        self.frame=CGRectMake(0, ScreenHeight - self.currentHeight - 40, self.frame.size.width, self.currentHeight + 40);
    }];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
