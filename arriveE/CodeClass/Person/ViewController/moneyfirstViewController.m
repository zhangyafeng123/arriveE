//
//  moneyfirstViewController.m
//  arriveE
//
//  Created by mibo02 on 17/7/19.
//  Copyright © 2017年 mibo02. All rights reserved.
//

#import "moneyfirstViewController.h"
#import "moneyhead.h"
#import "threelabCell.h"
#import "tuiyajinViewController.h"
@interface moneyfirstViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic, strong)moneyhead *moneyH;
@property (nonatomic, strong)NSArray *arr;
@end

@implementation moneyfirstViewController
- (IBAction)tixianbtn:(UIButton *)sender
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"钱包";
    self.navigationController.navigationBar.translucent = NO;
    self.arr = @[@"绑定账号",@"交易明细",@"规则说明"];
    [self.tableview registerNib:[UINib nibWithNibName:@"threelabCell" bundle:nil] forCellReuseIdentifier:@"threelab"];
     self.navigationItem.rightBarButtonItem = [UIBarButtonItem initWithTitle:@"退押金" titleColor:[UIColor grayColor] target:self action:@selector(rightbaraction)];
    [self sethead];
}
- (void)sethead
{
    self.moneyH = [[moneyhead alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150) leftstr:@"18" rightstr:@"200"];
    self.tableview.tableHeaderView = self.moneyH;
}
- (void)rightbaraction
{
    tuiyajinViewController *yajin = [tuiyajinViewController new];
    [self.navigationController pushViewController:yajin animated:YES];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    } else {
        return 3;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        threelabCell *cell = [tableView dequeueReusableCellWithIdentifier:@"threelab" forIndexPath:indexPath];
        cell.leftlab.attributedText = [ZLabel attributedTextArray:@[@"累计提现(元)\n",@"0.00"] textColors:@[[UIColor grayColor],[UIColor redColor]] textfonts:@[H14,H13]];
        cell.centerlab.attributedText = [ZLabel attributedTextArray:@[@"即将到账(元)\n",@"0.00"] textColors:@[[UIColor grayColor],[UIColor redColor]] textfonts:@[H14,H13]];
        cell.rightlab.attributedText = [ZLabel attributedTextArray:@[@"累计收入(元)\n",@"0.00"] textColors:@[[UIColor grayColor],[UIColor redColor]] textfonts:@[H14,H13]];
        return cell;
    } else {
        static NSString *str = @"fengfeng";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:str];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = H14;
        cell.textLabel.text = self.arr[indexPath.row];
        
        return cell;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view= [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 50;
    } else {
        return 45;
    }
}

@end
