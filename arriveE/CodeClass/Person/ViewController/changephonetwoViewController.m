//
//  changephonetwoViewController.m
//  arriveD
//
//  Created by mibo02 on 17/7/13.
//  Copyright © 2017年 mibo02. All rights reserved.
//

#import "changephonetwoViewController.h"
#import "nextViewController.h"
@interface changephonetwoViewController ()

@end

@implementation changephonetwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   self.title = @"修改手机号";
}
- (IBAction)nextbtn:(UIButton *)sender {
    nextViewController *next  = [nextViewController new];
    [self.navigationController pushViewController:next animated:YES];
}




@end
