//
//  horderdetailViewController.m
//  arriveE
//
//  Created by mibo02 on 17/7/19.
//  Copyright © 2017年 mibo02. All rights reserved.
//

#import "horderdetailViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import "beizhuCell.h"
#import "threelabCell.h"
#import "mapdetailViewController.h"
#import "horderphotoViewController.h"
#import "hzhuandanViewController.h"
@interface horderdetailViewController ()<AMapLocationManagerDelegate,MAMapViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *firstlab;
@property (weak, nonatomic) IBOutlet UILabel *secondlab;
@property (weak, nonatomic) IBOutlet UILabel *threelab;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property(nonatomic,strong)MAMapView *mapView;
@property (nonatomic,strong) AMapLocationManager *locationManager;
@property (nonatomic,assign) CLLocationCoordinate2D currentCoordinate;//用来保存定位到的坐标
@end

@implementation horderdetailViewController
- (IBAction)leftbtnaction:(UIButton *)sender
{
    
}
- (IBAction)centerbtnaction:(UIButton *)sender
{
    
}
- (IBAction)rightbtnaction:(UIButton *)sender
{
    horderphotoViewController *order = [horderphotoViewController new];
    [self.navigationController pushViewController:order animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    self.firstlab.attributedText = [ZLabel attributedTextArray:@[@"13：00\n",@"下单时间"] textColors:@[[UIColor grayColor],[UIColor grayColor]] textfonts:@[H14,H14]];
    self.secondlab.attributedText = [ZLabel attributedTextArray:@[@"¥13.00\n",@"本单收入"] textColors:@[[UIColor redColor],[UIColor grayColor]] textfonts:@[H14,H14]];
    self.threelab.attributedText = [ZLabel attributedTextArray:@[@"60分钟\n",@"希望送达"] textColors:@[[UIColor grayColor],[UIColor grayColor]] textfonts:@[H14,H14]];
    self.navigationController.navigationBar.translucent = NO;
    //设置地图
    [self setmap];
    [self.tableview registerNib:[UINib nibWithNibName:@"beizhuCell" bundle:nil] forCellReuseIdentifier:@"beizhu"];
    [self.tableview registerNib:[UINib nibWithNibName:@"threelabCell" bundle:nil] forCellReuseIdentifier:@"threelab"];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem initWithTitle:@"转单" titleColor:[UIColor grayColor] target:self action:@selector(rightbaraction)];
}
- (void)rightbaraction
{
    hzhuandanViewController *zhuandan = [hzhuandanViewController new];
    [self.navigationController pushViewController:zhuandan animated:YES];
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
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maptouchaction)];
    [self.mapView addGestureRecognizer:tap];
}
- (void)maptouchaction
{
    mapdetailViewController *detail = [mapdetailViewController new];
    [self.navigationController pushViewController:detail animated:YES];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 9;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= 0 && indexPath.row < 3){
        static NSString *str = @"fengfeng1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:str];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = H14;
        cell.detailTextLabel.font = H14;
        if (indexPath.row == 0) {
            cell.textLabel.text = @"配送信息";
        } else if (indexPath.row == 1){
            cell.textLabel.text = @"取货地址";
            cell.detailTextLabel.text = @"深圳市南山区亿利达大厦";
            
        } else if (indexPath.row == 2){
            cell.textLabel.text = @"送货地址";
            cell.detailTextLabel.text = @"深圳市米波科技有限公司";
        }
        cell.detailTextLabel.numberOfLines = 0;
        return cell;
    } else if (indexPath.row >=3 && indexPath.row < 7){
        static NSString *str = @"fengfeng2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:str];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = H14;
        cell.detailTextLabel.font = H14;
        if (indexPath.row == 3) {
            cell.textLabel.text = @"订单详情";
            
        } else if (indexPath.row == 4){
            cell.textLabel.text = @"订单编号";
            cell.detailTextLabel.text = @"123456789";
        } else if (indexPath.row == 5){
            cell.textLabel.text = @"订单金额";
            cell.detailTextLabel.text = @"18元";
        } else if (indexPath.row == 6){
            cell.textLabel.text = @"物品重量";
            cell.detailTextLabel.text = @"<5kg";
        }
        return cell;
    } else if(indexPath.row == 7){
        beizhuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"beizhu" forIndexPath:indexPath];
        return cell;
    } else {
        threelabCell *cell = [tableView dequeueReusableCellWithIdentifier:@"threelab" forIndexPath:indexPath];
        
        cell.leftlab.attributedText = [ZLabel attributedTextArray:@[@"接单\n",@"12:00"] textColors:@[[UIColor grayColor],[UIColor redColor]] textfonts:@[H14,H14]];
        cell.centerlab.attributedText = [ZLabel attributedTextArray:@[@"取货\n",@"12:15"] textColors:@[[UIColor grayColor],[UIColor redColor]] textfonts:@[H14,H14]];
        cell.rightlab.attributedText = [ZLabel attributedTextArray:@[@"完成\n",@"12:40"] textColors:@[[UIColor grayColor],[UIColor redColor]] textfonts:@[H14,H14]];
        return cell;
    }

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 7) {
        return 80;
    } else if(indexPath.row == 8){
        return 50;
    } else {
        return 30;
    }
}


@end
