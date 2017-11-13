//
//  addressselectViewController.m
//  arriveE
//
//  Created by mibo02 on 17/7/21.
//  Copyright © 2017年 mibo02. All rights reserved.
//

#import "addressselectViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
@interface addressselectViewController ()<AMapLocationManagerDelegate,MAMapViewDelegate>
@property (nonatomic,strong) AMapLocationManager *locationManager;
@property (nonatomic,assign) CLLocationCoordinate2D currentCoordinate;//用来保存定位到的坐标
@property(nonatomic,strong)MAMapView *mapView;

@end

@implementation addressselectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"填写地址";
    self.navigationController.navigationBar.translucent = NO;
    
    //设置地图
    [self setmap];
}

- (void)setmap
{
    ///地图需要v4.5.0及以上版本才必须要打开此选项（v4.5.0以下版本，需要手动配置info.plist）
    [AMapServices sharedServices].enableHTTPS = YES;
    ///初始化地图
    _mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    _mapView.delegate = self;
    //地图的缩放
    [_mapView setZoomLevel:18 animated:YES];
    //把地图放在底层
    [self.view insertSubview:self.mapView atIndex:0];
    
    //是否显示用户的位置
    _mapView.showsUserLocation = YES;
    //持续定位
    self.locationManager = [[AMapLocationManager alloc] init];
    self.locationManager.delegate = self;
    //开启持续定位
    [self.locationManager startUpdatingLocation];
}

//代理方法
-(void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location{
    //输出的是模拟器的坐标
    CLLocationCoordinate2D coordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
    _currentCoordinate = coordinate2D;
    _mapView.centerCoordinate = coordinate2D;
    
}
- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error{
    //定位错误
    NSLog(@"定位失败");
    NSLog(@"%s, amapLocationManager = %@, error = %@", __func__, [manager class], error);
}

@end
