//
//  LoginViewController.m
//  arriveE
//
//  Created by mibo02 on 17/7/6.
//  Copyright © 2017年 mibo02. All rights reserved.
//

#import "LoginViewController.h"
#import "RegistViewController.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
}
- (IBAction)regist:(UIButton *)sender
{
    RegistViewController *regist = [RegistViewController new];
    [self.navigationController pushViewController:regist animated:YES];
}



@end
