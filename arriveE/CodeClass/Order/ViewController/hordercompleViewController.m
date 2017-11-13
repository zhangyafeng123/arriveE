//
//  hordercompleViewController.m
//  arriveE
//
//  Created by mibo02 on 17/7/19.
//  Copyright © 2017年 mibo02. All rights reserved.
//

#import "hordercompleViewController.h"
#import "hshensuViewController.h"
#import "beizhuCell.h"
#import "threelabCell.h"
@interface hordercompleViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@end

@implementation hordercompleViewController
- (IBAction)complete:(UIButton *)sender
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"完成订单";
    self.navigationController.navigationBar.translucent = NO;
    [self.tableview registerNib:[UINib nibWithNibName:@"beizhuCell" bundle:nil] forCellReuseIdentifier:@"beizhu"];
    [self.tableview registerNib:[UINib nibWithNibName:@"threelabCell" bundle:nil] forCellReuseIdentifier:@"threelab"];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem initWithTitle:@"申诉" titleColor:[UIColor grayColor] target:self action:@selector(rightbaraction)];
}
- (void)rightbaraction
{
    hshensuViewController *shensu = [hshensuViewController new];
    [self.navigationController pushViewController:shensu animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 12;
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
    } else if (indexPath.row >=3 && indexPath.row < 9){
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
            cell.textLabel.text = @"预计收入";
            cell.detailTextLabel.text = @"15.00元";
        } else if (indexPath.row == 7){
            cell.textLabel.text = @"期望送达";
            cell.detailTextLabel.text = @"12:00";
        } else {
            cell.textLabel.text = @"物品重量";
            cell.detailTextLabel.text = @"<15kg";
        }
        return cell;
    } else if(indexPath.row > 8 && indexPath.row < 11){
        beizhuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"beizhu" forIndexPath:indexPath];
        if (indexPath.row == 9) {
            cell.titilelab.text = @"备注";
        } else {
            cell.titilelab.text = @"你拍的物品";
        }
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
    if (indexPath.row == 9) {
        return 80;
    } else if(indexPath.row == 10){
        return 80;
    } else if (indexPath.row == 11){
        return 50;
    } else {
        return 40;
    }
}




@end
