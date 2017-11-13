//
//  changepassnextViewController.m
//  arriveD
//
//  Created by mibo02 on 17/7/13.
//  Copyright © 2017年 mibo02. All rights reserved.
//
#import "arrivesetViewController.h"
#import "changepassnextViewController.h"
#import "tishiview.h"
@interface changepassnextViewController ()
@property (nonatomic, strong)UIView *backV;
@property (nonatomic, strong)tishiview *tishiV;
@end

@implementation changepassnextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   self.title = @"设置密码";
}

- (IBAction)completeaction:(UIButton *)sender {
    UIWindow *window = [UIApplication sharedApplication].windows[0];
    _backV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _backV.backgroundColor =  RGBA(108, 108, 108,0.7);
    [window addSubview:_backV];
    _tishiV = [[[NSBundle mainBundle] loadNibNamed:@"tishiview" owner:nil options:nil] firstObject];
    _tishiV.frame = CGRectMake((SCREEN_WIDTH - 300)/2, (SCREEN_HEIGHT - 150)/2, 300, 150);
    [_backV addSubview:_tishiV];
    [_tishiV.tishibtn addTarget:self action:@selector(tishiaction:) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)tishiaction:(UIButton *)sender
{
    [_backV removeFromSuperview];
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[arrivesetViewController class]]) {
            arrivesetViewController *newvc = (arrivesetViewController *)vc;
            [self.navigationController popToViewController:newvc animated:YES];
        }
        
    }
}
@end
