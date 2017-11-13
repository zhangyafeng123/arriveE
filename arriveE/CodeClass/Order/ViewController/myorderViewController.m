//
//  myorderViewController.m
//  arriveE
//
//  Created by mibo02 on 17/7/19.
//  Copyright © 2017年 mibo02. All rights reserved.
//

#import "myorderViewController.h"
#import "myorderCell.h"
#import "myallorderViewController.h"
#import "horderdetailViewController.h"
@interface myorderViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@end

@implementation myorderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的订单";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem initWithTitle:@"查看全部" titleColor:[UIColor grayColor] target:self action:@selector(rightbaraction)];
    [self.tableview registerNib:[UINib nibWithNibName:@"myorderCell" bundle:nil] forCellReuseIdentifier:@"myorder"];
}
- (void)rightbaraction
{
    myallorderViewController *order = [myallorderViewController new];
    [self.navigationController pushViewController:order animated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    myorderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myorder" forIndexPath:indexPath];
    cell.leftbtn.layer.borderColor = [UIColor grayColor].CGColor;
    cell.leftbtn.layer.borderWidth = 0.5;
    cell.rightbtn.layer.borderColor = [UIColor redColor].CGColor;
    cell.rightbtn.layer.borderWidth = 0.5;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    horderdetailViewController *order = [horderdetailViewController new];
    [self.navigationController pushViewController:order animated:YES];
}

@end
