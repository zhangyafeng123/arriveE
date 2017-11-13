//
//  kuaijiandetailViewController.m
//  arriveE
//
//  Created by mibo02 on 17/7/18.
//  Copyright © 2017年 mibo02. All rights reserved.
//

#import "kuaijiandetailViewController.h"
#import "detailfirstCell.h"
#import "beizhuCell.h"
#import "myorderViewController.h"
@interface kuaijiandetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic, assign)BOOL isopen;
@end

@implementation kuaijiandetailViewController
- (IBAction)myorder:(UIButton *)sender {
    myorderViewController *order = [myorderViewController new];
    [self.navigationController pushViewController:order animated:YES];
}
- (IBAction)shougong:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
   self.title = @"订单详情";
    self.navigationController.navigationBar.translucent = NO;
    self.isopen = YES;
    [self.tableview registerNib:[UINib nibWithNibName:@"detailfirstCell" bundle:nil] forCellReuseIdentifier:@"first"];
    [self.tableview registerNib:[UINib nibWithNibName:@"beizhuCell" bundle:nil] forCellReuseIdentifier:@"beizhu"];
    [self setfooterview];
}
- (void)setfooterview
{
    UIView *footv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    self.tableview.tableFooterView = footv;
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    btn.frame = CGRectMake((SCREEN_WIDTH - 35)/2, 0, 35, 30);
    [btn setImage:[UIImage imageNamed:@"返回 (1) 副本"] forState:(UIControlStateNormal)];
    [btn addTarget:self action:@selector(btnaction:) forControlEvents:(UIControlEventTouchUpInside)];
    [footv addSubview:btn];
}
- (void)btnaction:(UIButton *)sender
{
    self.isopen = !self.isopen;
    [self.tableview reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.isopen) {
        return 9;
    } else {
        return 1;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        detailfirstCell *cell = [tableView dequeueReusableCellWithIdentifier:@"first" forIndexPath:indexPath];
        return cell;
    } else if (indexPath.row > 0 && indexPath.row < 4){
        static NSString *str = @"fengfeng1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:str];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = H14;
        cell.detailTextLabel.font = H14;
        if (indexPath.row == 1) {
            cell.textLabel.text = @"配送信息";
        } else if (indexPath.row == 2){
            cell.textLabel.text = @"送达时间";
            cell.detailTextLabel.text = @"深圳市南山区亿利达大厦";
            
        } else if (indexPath.row == 3){
            cell.textLabel.text = @"收货方式";
            cell.detailTextLabel.text = @"深圳市米波科技有限公司";
        }
        cell.detailTextLabel.numberOfLines = 0;
        return cell;
    } else if (indexPath.row >3 && indexPath.row < 8){
        static NSString *str = @"fengfeng2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:str];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = H14;
        cell.detailTextLabel.font = H14;
        if (indexPath.row == 4) {
            cell.textLabel.text = @"订单详情";
            
        } else if (indexPath.row == 5){
            cell.textLabel.text = @"期望送达";
            cell.detailTextLabel.text = @"12：00";
        } else if (indexPath.row == 6){
            cell.textLabel.text = @"物品重量";
            cell.detailTextLabel.text = @"<5公斤";
        } else if (indexPath.row == 7){
            cell.textLabel.text = @"物品类型";
            cell.detailTextLabel.text = @"文件";
        }
        return cell;
    } else {
        beizhuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"beizhu" forIndexPath:indexPath];
        return cell;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isopen) {
        if (indexPath.row == 0) {
            return 80;
        } else if (indexPath.row == 8){
            return 80;
        } else {
            return 45;
        }
    } else {
        return 80;
    }
    
}



@end
