//
//  nextViewController.m
//  arriveD
//
//  Created by mibo02 on 17/7/5.
//  Copyright © 2017年 mibo02. All rights reserved.
//

#import "nextViewController.h"
#import "TXTradePasswordView.h"
#import "arrivesetViewController.h"
@interface nextViewController ()<TXTradePasswordViewDelegate>


@end

@implementation nextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"验证码";
    
    
    TXTradePasswordView *TXView = [[TXTradePasswordView alloc]initWithFrame:CGRectMake(0, 100,SCREEN_WIDTH, 350)  success:^(id reponseObject) {
        
    }];
    TXView.TXTradePasswordDelegate = self;
    if (![TXView.TF becomeFirstResponder])
    {
        //成为第一响应者。弹出键盘
        [TXView.TF becomeFirstResponder];
    }
    
    [self.view addSubview:TXView];
    
}

#pragma mark  密码输入结束后调用此方法
-(void)TXTradePasswordView:(TXTradePasswordView *)view WithPasswordString:(NSString *)Password
{
    NSLog(@"密码 = %@",Password);
    [MBProgressHUD showError:@"修改成功"];
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[arrivesetViewController class]]) {
            arrivesetViewController *newvc = (arrivesetViewController *)vc;
            [self.navigationController popToViewController:newvc animated:YES];
        }
        
    }
}


@end
