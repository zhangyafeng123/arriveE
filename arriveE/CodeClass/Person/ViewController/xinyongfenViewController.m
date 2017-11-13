//
//  xinyongfenViewController.m
//  arriveE
//
//  Created by mibo02 on 17/7/20.
//  Copyright © 2017年 mibo02. All rights reserved.
//

#import "xinyongfenViewController.h"

@interface xinyongfenViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@end

@implementation xinyongfenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"信用分";
    self.navigationController.navigationBar.translucent = NO;
    [self createhead];
}

- (void)createhead
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 80)/2, 60, 80, 80)];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.layer.cornerRadius = 40;
    lab.layer.masksToBounds = YES;
    lab.backgroundColor = [UIColor redColor];
    lab.attributedText = [ZLabel attributedTextArray:@[@"100\n",@"当前信用分"] textColors:@[[UIColor whiteColor],[UIColor whiteColor]] textfonts:@[H20,H14]];
    lab.numberOfLines = 0;
    [view addSubview:lab];
    self.tableview.tableHeaderView = view;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str  = @"fengfeng";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:str];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.attributedText = [ZLabel attributedTextArray:@[@"今天\n",@"06-08"] textColors:@[[UIColor blackColor],[UIColor grayColor]] textfonts:@[H14,H10]];
    cell.detailTextLabel.attributedText = [ZLabel attributedTextArray:@[@"-10.00\n",@"订单支出"] textColors:@[[UIColor redColor],[UIColor grayColor]] textfonts:@[H14,H10]];
    cell.textLabel.numberOfLines = 0;
    cell.detailTextLabel.numberOfLines = 0;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

@end
