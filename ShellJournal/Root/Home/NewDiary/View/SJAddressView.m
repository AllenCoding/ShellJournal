//
//  SJAddressView.m
//  ShellJournal
//
//  Created by 刘勇 on 2017/3/27.
//  Copyright © 2017年 liuyong. All rights reserved.
//

#import "SJAddressView.h"


@interface SJAddressView ()<BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>

@property(nonatomic,strong)UILabel*ipLabel;
@property(nonatomic,strong)UILabel*addressLabel;
@property(nonatomic,strong)BMKLocationService *locService;  //定位
@property(nonatomic,strong)BMKGeoCodeSearch *geocodesearch; //地理编码主类，用来查询、返回结果信息
@property(nonatomic,copy)NSString*address;
@end

@implementation SJAddressView

-(BMKGeoCodeSearch *)geocodesearch{
    if (!_geocodesearch) {
        _geocodesearch = [[BMKGeoCodeSearch alloc] init];
        _geocodesearch.delegate = self;
    }
    return _geocodesearch;
}
-(UILabel *)ipLabel{
    if (!_ipLabel) {
        _ipLabel=[[UILabel alloc]initWithFrame:CGRectMake(15, 10, 300, 30)];
        _ipLabel.text=@"告诉我你在哪里？";
        _ipLabel.textAlignment=NSTextAlignmentLeft;
        _ipLabel.font=kBfont(15);
        _ipLabel.textColor=kBlackColor;
    }
    return _ipLabel;
}

-(UILabel *)addressLabel{
    if (!_addressLabel) {
        _addressLabel=[[UILabel alloc]initWithFrame:CGRectMake(15, 40, 300, 30)];
        _addressLabel.textAlignment=NSTextAlignmentLeft;
        _addressLabel.font=kSfont(14);
        _addressLabel.textColor=kLightGrayColor;
        _addressLabel.numberOfLines=0;
        _addressLabel.text=@"正在定位...";
    }
    return _addressLabel;
}
-(instancetype)initAddressViewWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self addSubview:self.ipLabel];
        [self addSubview:self.addressLabel];
        [self startLocation];
    }
    return self;
}
-(void)startLocation{
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    _locService.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    //启动LocationService
    [_locService startUserLocationService];
}
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    //地理反编码
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint = userLocation.location.coordinate;
    BOOL flag = [self.geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
    if(flag){
        NSLog(@"反geo检索发送成功");
        [_locService stopUserLocationService];
    }else{
        NSLog(@"反geo检索发送失败");
    }
}
-(void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    NSLog(@"address:%@----%@%@",result.addressDetail,result.address,result.businessCircle);
    self.address=[NSString stringWithFormat:@"%@%@",result.address,result.businessCircle];
    self.addressLabel.text=self.address;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"address" object:@{@"address":self.address}];

}
//定位失败
- (void)didFailToLocateUserWithError:(NSError *)error{
    NSLog(@"error:%@",error);
}

@end
