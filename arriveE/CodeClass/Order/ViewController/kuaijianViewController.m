//
//  kuaijianViewController.m
//  arriveE
//
//  Created by mibo02 on 17/7/18.
//  Copyright © 2017年 mibo02. All rights reserved.
//

#import "kuaijianViewController.h"
#import "kuanjianCell.h"
#import "twobtnview.h"
#import "kuaijiandetailViewController.h"
#import "myorderViewController.h"
@interface kuaijianViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)twobtnview *twobtnV;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@end

@implementation kuaijianViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
     UIWindow *window = [UIApplication sharedApplication].windows[0];
    self.twobtnV = [[[NSBundle mainBundle] loadNibNamed:@"twobtnview" owner:nil options:nil] firstObject];
    self.twobtnV.frame = CGRectMake(0, SCREEN_HEIGHT - 55, SCREEN_WIDTH, 35);
    [self.twobtnV.leftbtn addTarget:self action:@selector(myorderaction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.twobtnV.rightbtn addTarget:self action:@selector(rightbtnaction:) forControlEvents:(UIControlEventTouchUpInside)];
    [window addSubview:self.twobtnV];
}
- (void)myorderaction:(UIButton *)sender
{
    myorderViewController *order = [myorderViewController new];
    [self.navigationController pushViewController:order animated:YES];
}
- (void)rightbtnaction:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.twobtnV removeFromSuperview];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单列表";
    [self.tableview registerNib:[UINib nibWithNibName:@"kuanjianCell" bundle:nil] forCellReuseIdentifier:@"kuaijian"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    kuanjianCell *cell = [tableView dequeueReusableCellWithIdentifier:@"kuaijian" forIndexPath:indexPath];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    kuaijiandetailViewController *detail = [kuaijiandetailViewController new];
    [self.navigationController pushViewController:detail animated:YES];
}

@end
