//
//  fabuxingchengViewController.m
//  arriveE
//
//  Created by mibo02 on 17/7/18.
//  Copyright © 2017年 mibo02. All rights reserved.
//

#import "fabuxingchengViewController.h"
#import "fabuCell.h"

@interface fabuxingchengViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic, strong)NSArray *leftarr;
@property (nonatomic, strong)UIView *backV;
@end

@implementation fabuxingchengViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发布行程";
    self.leftarr = @[@"出发地址",@"到达地址",@"出发时间",@"到达时间"];
    [self.tableview registerNib:[UINib nibWithNibName:@"fabuCell" bundle:nil] forCellReuseIdentifier:@"fabu"];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.leftarr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    fabuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"fabu" forIndexPath:indexPath];
    NSInteger i = indexPath.row ;
    if (i % 2 == 0) {
        //偶数
        cell.leftlab.backgroundColor = [UIColor greenColor];
    } else {
        cell.leftlab.backgroundColor = [UIColor redColor];
    }
    if (indexPath.row == 1) {
        cell.textf.enabled = YES;
        cell.textf.placeholder = @"请输入收货地址";
        cell.fabubtn.hidden = YES;
    } else if (indexPath.row == 0){
        cell.textf.enabled = NO;
        cell.textf.text = @"南山区南山大道";
        cell.fabubtn.hidden = YES;
    } else if (indexPath.row == 2){
         cell.textf.enabled = NO;
        cell.textf.text = @"12:00";
        cell.fabubtn.hidden = YES;
    } else if (indexPath.row == 3){
         cell.textf.enabled = NO;
        cell.textf.text = @"14:00";
        cell.fabubtn.hidden = NO;
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==2) {
        fabuCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        UIWindow *window = [UIApplication sharedApplication].windows[0];
        _backV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _backV.backgroundColor =  RGBA(108, 108, 108,0.7);
        [window addSubview:_backV];
        
        [CDZPicker showPickerInView:_backV withStringArrays:@[@[@"今天"],@[@"立即取货",@"10点",@"11点",@"12点"],@[@"00分",@"10分",@"20分"]] confirm:^(NSArray<NSString *> *stringArray) {
            [_backV removeFromSuperview];
            cell.textf.text = [stringArray componentsJoinedByString:@"-"];
        } cancel:^{
            [_backV removeFromSuperview];
        }];
    } else if (indexPath.row == 3){
        fabuCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        UIWindow *window = [UIApplication sharedApplication].windows[0];
        _backV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _backV.backgroundColor =  RGBA(108, 108, 108,0.7);
        [window addSubview:_backV];
        
        [CDZPicker showPickerInView:_backV withStringArrays:@[@[@"今天"],@[@"立即取货",@"10点",@"11点",@"12点"],@[@"00分",@"10分",@"20分"]] confirm:^(NSArray<NSString *> *stringArray) {
            [_backV removeFromSuperview];
            cell.textf.text = [stringArray componentsJoinedByString:@"-"];
        } cancel:^{
            [_backV removeFromSuperview];
        }];
    }
}

@end
