//
//  changephoneViewController.m
//  arriveD
//
//  Created by mibo02 on 17/7/13.
//  Copyright © 2017年 mibo02. All rights reserved.
//

#import "changephoneViewController.h"
#import "changephonetwoViewController.h"
@interface changephoneViewController ()

@end

@implementation changephoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   self.title = @"修改手机号";
}
- (IBAction)bangdingbtn:(UIButton *)sender {
    
    changephonetwoViewController *two = [changephonetwoViewController new];
    [self.navigationController pushViewController:two animated:YES];
}



@end
