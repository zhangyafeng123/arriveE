//
//  addressViewController.m
//  arriveE
//
//  Created by mibo02 on 17/7/21.
//  Copyright © 2017年 mibo02. All rights reserved.
//

#import "addressViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import "addressselectViewController.h"
#import <AMapSearchKit/AMapSearchKit.h>
#import "arrCustomAnnotationView.h"
@interface addressViewController ()<AMapLocationManagerDelegate,MAMapViewDelegate,AMapSearchDelegate,UIGestureRecognizerDelegate>
@property (nonatomic,strong) AMapLocationManager *locationManager;
@property (nonatomic, strong)AMapSearchAPI *search;
@property(nonatomic,strong)MAMapView *mapView;
@property (weak, nonatomic) IBOutlet UITextField *textf;
@property (weak, nonatomic) IBOutlet UILabel *addresslab;
@property (weak, nonatomic) IBOutlet UIButton *savebtnaction;
@property (nonatomic,retain) UILongPressGestureRecognizer *longPressGesture;//长按手势
@property (nonatomic,retain) MAPointAnnotation *destinationPoint;//目标点
@end

@implementation addressViewController
- (IBAction)nextbtn:(UIButton *)sender
{
    addressselectViewController *select = [addressselectViewController new];
    [self.navigationController pushViewController:select animated:YES];
}

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
    [self addGesture];
}
//添加手势
- (void)addGesture
{
   
    _longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    _longPressGesture.delegate = self;
    [_mapView addGestureRecognizer:_longPressGesture];
}
//长按手势相应
- (void)handleLongPress:(UILongPressGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan)
    {
        CGPoint p = [gesture locationInView:_mapView];
        NSLog(@"press on (%f, %f)", p.x, p.y);
    }
    CLLocationCoordinate2D coordinate = [_mapView convertPoint:[gesture locationInView:_mapView] toCoordinateFromView:_mapView];
    
    // 添加标注
    if (_destinationPoint != nil) {
        // 清理
        [_mapView removeAnnotation:_destinationPoint];
        _destinationPoint = nil;
    }
    _destinationPoint = [[MAPointAnnotation alloc] init];
    _destinationPoint.coordinate = coordinate;
    _destinationPoint.title = @"目标点";
    [_mapView addAnnotation:_destinationPoint];
    
}

//代理方法
-(void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location{
    
    //输出的是模拟器的坐标
    CLLocationCoordinate2D coordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
     _mapView.centerCoordinate = coordinate2D;
    [self searchactionfirst:location.coordinate.latitude second:location.coordinate.longitude];
}
//逆地理编码
- (void)searchactionfirst:(CLLocationDegrees)first second:(CLLocationDegrees)second
{
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
    
    regeo.location  = [AMapGeoPoint locationWithLatitude:first longitude:second];
    regeo.requireExtension  = YES;
    
    //画线(驾车)
    AMapDrivingRouteSearchRequest *navi = [[AMapDrivingRouteSearchRequest alloc] init];
    navi.requireExtension = YES;
    navi.strategy = 5;
    navi.origin = [AMapGeoPoint locationWithLatitude:first longitude:second];
    
    /* 目的地. */
    navi.destination = [AMapGeoPoint locationWithLatitude:_destinationPoint.coordinate.latitude
                                                longitude:_destinationPoint.coordinate.longitude];
    //逆地址编码查询
    [self.search AMapReGoecodeSearch:regeo];
    //发起驾车路线规划
    [self.search AMapDrivingRouteSearch:navi];
}

/* 逆地理编码回调. */
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    if (response.regeocode != nil)
    {
        NSString *myaddress = [NSString stringWithFormat:@"%@%@%@%@%@%@",response.regeocode.addressComponent.province,response.regeocode.addressComponent.city,response.regeocode.addressComponent.district,response.regeocode.addressComponent.township,response.regeocode.addressComponent.neighborhood,response.regeocode.addressComponent.building];
        NSLog(@"%@",myaddress);
        
        self.addresslab.text = myaddress;
       
    }
}
//当检索失败时，会进入 didFailWithError 回调函数，通过该回调函数获取产生的失败的原因。
- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error
{
    NSLog(@"Error: %@", error);
}
- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error{
    //定位错误
    NSLog(@"定位失败");
    NSLog(@"%s, amapLocationManager = %@, error = %@", __func__, [manager class], error);
}
//大头针
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        arrCustomAnnotationView *annotationView = (arrCustomAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[arrCustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
        }
        annotationView.image = [UIImage imageNamed:@"矢量智能对象"];
        annotationView.annotation.title = @"送货了亲";
        annotationView.annotation.subtitle = self.addresslab.text;
        // 设置为NO，用以调用自定义的calloutView
        annotationView.canShowCallout = NO;
        
        // 设置中心点偏移，使得标注底部中间点成为经纬度对应点
        annotationView.centerOffset = CGPointMake(0, -18);
        return annotationView;
    }
    return nil;
}
//路径规划回调
- (void)onRouteSearchDone:(AMapRouteSearchBaseRequest *)request response:(AMapRouteSearchResponse *)response
{
    if (response.route == nil)
    {
        return;
    }
    NSString *route = [NSString stringWithFormat:@"Navi: %@", response.route];
    
    AMapPath *path = response.route.paths[0]; //选择一条路径
    AMapStep *step = path.steps[0]; //这个路径上的导航路段数组
    NSLog(@"%@",step.polyline);   //此路段坐标点字符串
    
   
    //解析response获取路径信息，具体解析见 Demo
}



@end
