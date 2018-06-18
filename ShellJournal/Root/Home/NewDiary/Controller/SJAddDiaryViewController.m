//
//  SJAddDiaryViewController.m
//  ShellJournal
//
//  Created by 刘勇 on 2017/3/6.
//  Copyright © 2017年 liuyong. All rights reserved.

#import "SJAddDiaryViewController.h"
#import "SJToolBarView.h"
#import "ZYQAssetPickerController.h"
#import"iflyMSC/IFlyMSC.h"
#import "IATConfig.h"
#import "ISRDataHelper.h"
#import "iflyMSC/IFlySpeechRecognizer.h"

@interface SJAddDiaryViewController ()<UITextViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,ZYQAssetPickerControllerDelegate,IFlySpeechRecognizerDelegate>
@property(nonatomic,strong)SJToolBarView*toolbarView;
@property(nonatomic,strong)UITextView*contentView;
@property(nonatomic,copy)NSString*imageName;
@property(nonatomic,copy)NSString*weather;
@property(nonatomic,copy)NSString*address;
@property(nonatomic,strong)NSArray*photos;
@property(nonatomic,strong)NSMutableArray*dataSource;
@property (nonatomic, strong) IFlySpeechRecognizer*iFlySpeechRecognizer;//不带界面的识别对象
@property(nonatomic,copy)NSString*voiceStr;
@property(nonatomic,assign)BOOL isCanceled;


@end

@implementation SJAddDiaryViewController

-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource=[NSMutableArray array];
    }
    return _dataSource;
}
-(SJToolBarView *)toolbarView{
    if (!_toolbarView) {
        __weak typeof(SJAddDiaryViewController) *weakself = self;
        NSArray*array=@[@"default_background",@"default_picture",@"default_cloud",@"default_address"];
        
        NSArray*arrayVoice=@[@"default_background",@"default_picture",@"default_cloud",@"default_address",@"default_voice"];
        
        _toolbarView=[[SJToolBarView alloc]initToolBarViewWithFrame:CGRectMake(0, ScreenHeight-64-40, ScreenWidth,40+258) btnImageNamesArray:[[SJDataManager manager]currentInfo].boolVoice?arrayVoice:array];
        _toolbarView.myBlock=^(NSInteger index){
            [weakself.view endEditing:YES];
        };
    }
    return _toolbarView;
}

-(UITextView *)contentView{
    if (!_contentView) {
        _contentView=[[UITextView alloc]initWithFrame:CGRectMake(5, 5, ScreenWidth-10, 300)];
        _contentView.delegate=self;
        _contentView.backgroundColor=kClearColor;
        _contentView.font=kSfont(15);
        _contentView.alpha=0.6;
        _contentView.returnKeyType=UIReturnKeyDone;
    }
    return _contentView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"写日记";
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.contentView];
    [self.view addSubview:self.toolbarView];
    [self setRightItem];
    [self addListener];
}

#pragma mark RightItem
-(void)setRightItem{
    UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(0, 0, 25, 25);
    [button setBackgroundImage:[UIImage imageNamed:@"NavgationBar_ok"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(didWrite) forControlEvents:UIControlEventTouchDown];
    UIBarButtonItem*rightItem=[[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.rightBarButtonItem=rightItem;
}
-(void)didWrite{
    if (![[SJDataManager manager]currentInfo].boolImage) {
        if (self.contentView.text.length&&self.dataSource.count>0) {
            [MBProgressHUD showMessage:@"正在保存"];
            [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(keepOk) userInfo:nil repeats:NO];
        }else if(self.dataSource.count>0){
            [MBProgressHUD showError:@"填写日记内容"];
            
        }else{
             [MBProgressHUD showError:@"至少选一张图片"];
        }
       
    }else{
        if (self.contentView.text.length) {
            [MBProgressHUD showMessage:@"正在保存"];
            [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(keepOk) userInfo:nil repeats:NO];
        }else{
            
            [MBProgressHUD showError:@"填写日记内容"];
        }
        
    }
}

-(void)keepOk{
    [MBProgressHUD hideHUD];
    SJDiaryModel*diary=[[SJDiaryModel alloc]init];
    diary.author=userAccount;
    diary.imageName=self.dataSource.count==0?NULL:[NSString imageTransformWithArray:self.dataSource];
    diary.time=[NSString currentTime];
    diary.week=[NSString currentWeek];
    diary.content=self.contentView.text;
    diary.backgroundImageName=self.imageName;
    diary.address=self.address;
    diary.weather=self.weather;
    diary.enable=@"1";
    [[SJDataManager manager]updateLevelWithDiaryStatus:1];
    SJProcessModel*model=[[SJProcessModel alloc]init];
    model.processtime=[NSString currentTime];
    model.colorStr=[NSString randomString];
    model.desc=@"添加了一篇日记！";
    model.author=userAccount;
    model.score=@"+2";
    [[SJDataManager manager]insertProcessWithProcessModel:model];
    [[SJDataManager manager]insertDiaryWithDiaryModel:diary];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"newDiary" object:nil];
    [MBProgressHUD showSuccess:@"保存成功"];
    [self Pop];
}

-(void)initRecognizer{
    //单例模式，无UI的实例
    if (_iFlySpeechRecognizer == nil) {
        _iFlySpeechRecognizer = [IFlySpeechRecognizer sharedInstance];
        [_iFlySpeechRecognizer setParameter:@"" forKey: [IFlySpeechConstant PARAMS]];
        //设置听写模式
        [_iFlySpeechRecognizer setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
    }
    _iFlySpeechRecognizer.delegate = self;
    if (_iFlySpeechRecognizer != nil) {
        IATConfig *instance = [IATConfig sharedInstance];
        //设置最长录音时间
        [_iFlySpeechRecognizer setParameter:instance.speechTimeout forKey:[IFlySpeechConstant SPEECH_TIMEOUT]];
        //设置后端点
        [_iFlySpeechRecognizer setParameter:instance.vadEos forKey: [IFlySpeechConstant VAD_EOS]];
        //设置前端点
        [_iFlySpeechRecognizer setParameter:instance.vadBos forKey: [IFlySpeechConstant VAD_BOS]];
        //网络等待时间
        [_iFlySpeechRecognizer setParameter:@"20000" forKey:[IFlySpeechConstant NET_TIMEOUT]];
        //设置采样率，推荐使用16K
        [_iFlySpeechRecognizer setParameter:instance.sampleRate forKey:[IFlySpeechConstant SAMPLE_RATE]];
        if ([instance.language isEqualToString:[IATConfig chinese]]) {
            //设置语言
            [_iFlySpeechRecognizer setParameter:instance.language forKey:[IFlySpeechConstant LANGUAGE]];
            //设置方言
            [_iFlySpeechRecognizer setParameter:instance.accent forKey:[IFlySpeechConstant ACCENT]];
            
        }else if ([instance.language isEqualToString:[IATConfig english]]) {
            [_iFlySpeechRecognizer setParameter:instance.language forKey:[IFlySpeechConstant LANGUAGE]];
        }
        //设置是否返回标点符号
        [_iFlySpeechRecognizer setParameter:instance.dot forKey:[IFlySpeechConstant ASR_PTT]];
        
    }
    
}


#pragma mark ZYQAssetPickerControllerDelegate
-(void)assetPickerController:(ZYQAssetPickerController *)picker didFinishPickingAssets:(NSArray *)assets{
    self.photos=[NSArray arrayWithArray:assets];
    for (int i = 0; i < assets.count; i ++) {
        ALAsset *asset = assets[i];
        UIImage *tempImg = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
        [self.dataSource addObject:tempImg];
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:@"pickPhoto" object:self.dataSource];
}

#pragma mark ImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self.dataSource addObject:image];
    [self dismissViewControllerAnimated:YES completion:nil];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"pickPhoto" object:self.dataSource];
}
#pragma NSNotification Method
-(void)change:(NSNotification*)noti{
    UIImage*image=[UIImage imageNamed:noti.userInfo[@"wallname"]];
    self.view.backgroundColor=[UIColor colorWithPatternImage:image];
    self.view.layer.contents=(id)image.CGImage;
    self.imageName=noti.userInfo[@"wallname"];
    NSLog(@"%@",self.imageName);
    
}
-(void)pickImage:(NSNotification*)noti{
    NSString*action=noti.userInfo[@"action"];
    if ([action isEqualToString:@"相册"]) {
                ZYQAssetPickerController *pickerPhoto = [[ZYQAssetPickerController alloc] init];
                pickerPhoto.maximumNumberOfSelection = 9;
                pickerPhoto.assetsFilter = [ALAssetsFilter allPhotos];
                pickerPhoto.showEmptyGroups=NO;
                pickerPhoto.delegate=self;
        pickerPhoto.selectionFilter = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
            if ([[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyType] isEqual:ALAssetTypeVideo]) {
                NSTimeInterval duration = [[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyDuration] doubleValue];
                return duration >= 5;
            } else {
                return YES;
            }
        }];
    [self presentViewController:pickerPhoto animated:YES completion:^{}];
        
    }else{
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self.navigationController presentViewController:picker animated:YES completion:nil];
    }
  }
}

-(void)pickWeather:(NSNotification*)noti{
    self.weather=noti.object[@"weather"];
}
-(void)pickAddress:(NSNotification*)noti{
    self.address=noti.object[@"address"];
}
#pragma mark  textView Delegate
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        [self.toolbarView dismiss];
        return NO;
    }
    return YES;
}
-(void)recordVoice:(NSNotification*)noti{
    if ([noti.object[@"tag"] isEqualToString:@"100"]) {
        //开始录音
        NSLog(@"开始说话");
        if ([IATConfig sharedInstance].haveView == NO) {//无界面
            self.voiceStr = @"";
            self.isCanceled = NO;
            if(_iFlySpeechRecognizer == nil){
                [self initRecognizer];
            }
            [_iFlySpeechRecognizer cancel];
            //设置音频来源为麦克风
            [_iFlySpeechRecognizer setParameter:IFLY_AUDIO_SOURCE_MIC forKey:@"audio_source"];
            //设置听写结果格式为json
            [_iFlySpeechRecognizer setParameter:@"json" forKey:[IFlySpeechConstant RESULT_TYPE]];
            //保存录音文件，保存在sdk工作路径中，如未设置工作路径，则默认保存在library/cache下
            [_iFlySpeechRecognizer setParameter:@"asr.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
            [_iFlySpeechRecognizer setDelegate:self];
            [_iFlySpeechRecognizer startListening];
         }
    }else{
        //结束录音
        NSLog(@"结束录音");
        [_iFlySpeechRecognizer stopListening];
        self.isCanceled=YES;
    }
}
#pragma mark 语音代理方法 IFlySpeechRecognizerDelegate
/**
 无界面，听写结果回调
 results：听写结果
 isLast：表示最后一次
 ****/
- (void) onResults:(NSArray *) results isLast:(BOOL)isLast{
    NSMutableString *resultString = [[NSMutableString alloc] init];
    NSDictionary *dic = results[0];
    for (NSString *key in dic) {
        [resultString appendFormat:@"%@",key];
    }
    NSString * resultFromJson =  [ISRDataHelper  stringFromJson:resultString];
    self.voiceStr = [NSString stringWithFormat:@"%@%@",self.voiceStr,resultFromJson];
    if (isLast){//是否是最后一次回调 因为此方法会调用多次
        self.contentView.text=self.voiceStr;
        NSLog(@"听写结果：%@",self.voiceStr);
    }
}
/**
 听写结束回调（注：无论听写是否正确都会回调）
 error.errorCode =
 0     听写正确
 other 听写出错
 ****/
- (void) onError:(IFlySpeechError *) error{
    NSString *text ;
    if (self.isCanceled) {
        text = @"识别取消";
    } else if (error.errorCode == 0 ) {
        if (self.voiceStr.length == 0) {
            text = @"无识别结果";
        }else {
            text = @"识别成功";
        }
    }else {
        text = [NSString stringWithFormat:@"发生错误:%d %@",error.errorCode,error.errorDesc];
        NSLog(@"%@",text);
    }
}

/**
 音量回调函数
 volume 0－30
 ****/
- (void)onVolumeChanged: (int)volume{
    if (self.isCanceled) {
        return;
    }
    if (volume == 0) {
    //没有检测到声音 做一个静态的麦克风图片
    }else{
    //有检测到声音 做一个动态的麦克风图片
    }
}
-(void)addListener{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(change:) name:@"wall" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pickImage:) name:@"photo" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pickWeather:) name:@"weather" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pickAddress:) name:@"address" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(recordVoice:) name:@"recordVoice" object:nil];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.iFlySpeechRecognizer stopListening];
    [self.iFlySpeechRecognizer cancel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
