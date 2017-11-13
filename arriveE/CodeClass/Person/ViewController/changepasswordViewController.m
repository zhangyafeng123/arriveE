//
//  changepasswordViewController.m
//  arriveD
//
//  Created by mibo02 on 17/7/13.
//  Copyright © 2017年 mibo02. All rights reserved.
//

#import "changepasswordViewController.h"
#import "changepassnextViewController.h"
@interface changepasswordViewController ()

@end

@implementation changepasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置密码";
}
- (IBAction)btnaction:(UIButton *)sender {
    changepassnextViewController *next = [changepassnextViewController new];
    [self.navigationController pushViewController:next animated:YES];
}

@end
