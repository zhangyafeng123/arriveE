//
//  arrivesetViewController.m
//  arriveD
//
//  Created by mibo02 on 17/7/7.
//  Copyright © 2017年 mibo02. All rights reserved.
//

#import "arrivesetViewController.h"
#import "moneyCell.h"
#import "changepasswordViewController.h"
#import "changephoneViewController.h"
#import "infobackViewController.h"
@interface arrivesetViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic, strong)NSArray *arr0;
@property (nonatomic, strong)NSArray *arr;
@property (nonatomic, strong)NSArray *arr1;
@end

@implementation arrivesetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   self.title = @"设置";
    self.arr0 = @[@"修改手机号",@"修改密码",@"规则说明"];
    self.arr = @[@"当前交通工具",@"开启听单模式",@"常亮模式"];
    self.arr1 = @[@"常见问题",@"意见反馈",@"版本号",@"关于我们"];
    [self.tableview registerNib:[UINib nibWithNibName:@"moneyCell" bundle:nil] forCellReuseIdentifier:@"money"];
}
- (IBAction)loginout:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.arr0.count;
    } else if(section == 1) {
        return self.arr.count;
    } else {
        return self.arr1.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    moneyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"money" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        cell.leftlab.text = self.arr0[indexPath.row];
        [cell.leftimg setImage:[UIImage imageNamed:self.arr0[indexPath.row]] forState:(UIControlStateNormal)];
        
    } else if (indexPath.section == 1){
        cell.leftlab.text = self.arr[indexPath.row];
        [cell.leftimg setImage:[UIImage imageNamed:self.arr[indexPath.row]] forState:(UIControlStateNormal)];
        if (indexPath.row ==2) {
            cell.accessoryType = UITableViewCellAccessoryNone;
            UISwitch *switchnew = [[UISwitch alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 80, 10, 60, 30)];
            [cell.contentView addSubview:switchnew];
        }
    } else {
        cell.leftlab.text = self.arr1[indexPath.row];
        [cell.leftimg setImage:[UIImage imageNamed:self.arr1[indexPath.row]] forState:(UIControlStateNormal)];
    }
    
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    view.backgroundColor= [UIColor clearColor];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            changephoneViewController *change = [changephoneViewController new];
            [self.navigationController pushViewController:change animated:YES];
        } else if (indexPath.row == 1){
            changepasswordViewController *change = [changepasswordViewController new];
            [self.navigationController pushViewController:change animated:YES];
        } else if (indexPath.row == 2){
            
        }
    } else if (indexPath.section == 2){
        if (indexPath.row == 1) {
            infobackViewController *infoback = [infobackViewController new];
            [self.navigationController pushViewController:infoback animated:YES];
        }
    }
}

@end
