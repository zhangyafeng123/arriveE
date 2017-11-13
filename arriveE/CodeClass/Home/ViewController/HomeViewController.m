//
//  HomeViewController.m
//  arriveE
//
//  Created by mibo02 on 17/7/6.
//  Copyright © 2017年 mibo02. All rights reserved.
//

#import "HomeViewController.h"
#import "PersonViewController.h"
#import "MessageViewController.h"
#import "adverView.h"
#import "adverViewController.h"
#import "firstCell.h"
#import "secondCell.h"
#import "btnview.h"
#import "fabuxingchengViewController.h"
#import "renzhengView.h"
#import "kuaijianViewController.h"
#import "myorderViewController.h"
#import "wanshanziliaoViewController.h"
@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,btnviewDelegate>
@property (nonatomic, strong)adverView *adverV;
@property (nonatomic, strong)UIView *backV;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic, strong)btnview *btnV;
@property (nonatomic, strong)renzhengView *renzhengV;
@end

@implementation HomeViewController

- (IBAction)kaigongbtn:(UIButton *)sender
{
    kuaijianViewController *kuaijian = [kuaijianViewController new];
    [self.navigationController pushViewController:kuaijian animated:YES];
}
- (IBAction)fabubtn:(UIButton *)sender
{
    fabuxingchengViewController *fabu = [fabuxingchengViewController new];
    [self.navigationController pushViewController:fabu animated:YES];
}
- (IBAction)dongdanbtn:(UIButton *)sender
{
    myorderViewController *order = [myorderViewController new];
    [self.navigationController pushViewController:order animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    [self.tableview registerNib:[UINib nibWithNibName:@"firstCell" bundle:nil] forCellReuseIdentifier:@"first"];
    [self.tableview registerNib:[UINib nibWithNibName:@"secondCell" bundle:nil] forCellReuseIdentifier:@"second"];
    [self createNav];
    [self createadver];
}
- (void)createNav
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem CreateItemWithTarget:self ForAction:@selector(leftBarButtonItemaction) WithImage:@"点击跳转至个人中心" WithHighlightImage:@""];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem CreateItemWithTarget:self ForAction:@selector(rightBarButtonItemaction) WithImage:@"信息列表" WithHighlightImage:@""];
}
- (void)leftBarButtonItemaction
{
    PersonViewController *person = [PersonViewController new];
    [self.navigationController pushViewController:person animated:YES];
}
- (void)rightBarButtonItemaction
{
    MessageViewController *message = [MessageViewController new];
    [self.navigationController pushViewController:message animated:YES];
}

- (void)createadver
{
    UIWindow *window = [UIApplication sharedApplication].windows[0];
    _backV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _backV.backgroundColor =  RGBA(108, 108, 108,0.7);
    [window addSubview:_backV];
//    _adverV = [[[NSBundle mainBundle] loadNibNamed:@"adverView" owner:nil options:nil] firstObject];
//    [_adverV.deletebtn addTarget:self action:@selector(deletebtnaction:) forControlEvents:(UIControlEventTouchUpInside)];
//    [_adverV.imgbtn addTarget:self action:@selector(imgbtnaction:) forControlEvents:(UIControlEventTouchUpInside)];
//    _adverV.frame = CGRectMake((SCREEN_WIDTH - 300)/2, 100, 300, 450);
//    [_backV addSubview:_adverV];
    _renzhengV = [[[NSBundle mainBundle] loadNibNamed:@"renzhengView" owner:nil options:nil] firstObject];
    _renzhengV.frame = CGRectMake((SCREEN_WIDTH - 300)/2, (SCREEN_HEIGHT - 400)/2, 300, 400);
    _renzhengV.leftlab.layer.borderWidth = 0.5;
    _renzhengV.leftlab.layer.borderColor = [UIColor redColor].CGColor;
    _renzhengV.rightlab.layer.borderWidth = 0.5;
    _renzhengV.rightlab.layer.borderColor = [UIColor redColor].CGColor;
    _renzhengV.titlelab.text = [NSString stringWithFormat:@"亲\n还差两步就可以接单了哟!"];
    [_renzhengV.renzhengremovebtn addTarget:self action:@selector(renzhengremovebtnaction) forControlEvents:(UIControlEventTouchUpInside)];
    [_renzhengV.renzhengbtn addTarget:self action:@selector(renzhengbtnaction) forControlEvents:(UIControlEventTouchUpInside)];
    [_backV addSubview:_renzhengV];
    
    
}
//认证点击事件
- (void)renzhengbtnaction
{
    [_backV removeFromSuperview];
    wanshanziliaoViewController *wanshan = [wanshanziliaoViewController new];
    [self.navigationController pushViewController:wanshan animated:YES];
}
//认证删除
- (void)renzhengremovebtnaction
{
    [_backV removeFromSuperview];
}
//广告点击事件
- (void)imgbtnaction:(UIButton *)sender
{
    [_backV removeFromSuperview];
    adverViewController *adver = [adverViewController new];
    [self.navigationController pushViewController:adver animated:YES];
}
//删除事件
- (void)deletebtnaction:(UIButton *)sender
{
    [_backV removeFromSuperview];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    } else if(section == 1){
        return 0;
    } else {
        return 3;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            static NSString *str = @"fengfeng";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:str];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.text = @"07-05 星期三 在线一分钟";
            cell.textLabel.font = H14;
            return cell;
        } else {
            firstCell *cell = [tableView dequeueReusableCellWithIdentifier:@"first" forIndexPath:indexPath];
            cell.leftlab.attributedText = [ZLabel attributedTextArray:@[@"0",@"单"] textColors:@[[UIColor redColor],[UIColor blackColor]] textfonts:@[H17,H13]];
            cell.centerlab.attributedText = [ZLabel attributedTextArray:@[@"0.00",@"公里"] textColors:@[[UIColor redColor],[UIColor blackColor]] textfonts:@[H17,H13]];
            cell.rightlab.attributedText = [ZLabel attributedTextArray:@[@"0.00",@"元"] textColors:@[[UIColor redColor],[UIColor blackColor]] textfonts:@[H17,H13]];
            return cell;
        }
    } else if (indexPath.section == 2){
        secondCell *cell = [tableView dequeueReusableCellWithIdentifier:@"second" forIndexPath:indexPath];
        cell.numlab.text = [NSString stringWithFormat:@"%ld",indexPath.row + 1];
        return cell;
    } else {
        return [UITableViewCell new];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 45;
        } else {
            return 170;
        }
    } else if (indexPath.section == 1){
        return 0;
    } else {
        return 60;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    self.btnV = [[btnview alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    return self.btnV;
}
- (void)clickaction:(NSInteger)tag
{
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 60;
    } else {
        return 0;
    }
}

@end
