//
//  RegistViewController.m
//  arriveE
//
//  Created by mibo02 on 17/7/6.
//  Copyright © 2017年 mibo02. All rights reserved.
//

#import "RegistViewController.h"

@interface RegistViewController ()

@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   self.title = @"注册";
}


- (IBAction)backaction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}





@end
