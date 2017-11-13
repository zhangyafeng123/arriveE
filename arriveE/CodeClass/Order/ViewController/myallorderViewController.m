//
//  myallorderViewController.m
//  arriveE
//
//  Created by mibo02 on 17/7/19.
//  Copyright © 2017年 mibo02. All rights reserved.
//

#import "myallorderViewController.h"
#import "myorderCell.h"
@interface myallorderViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation myallorderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"全部订单";
     [self.tableview registerNib:[UINib nibWithNibName:@"myorderCell" bundle:nil] forCellReuseIdentifier:@"myorder"];
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

@end
