//
//  moneyhead.m
//  arriveE
//
//  Created by mibo02 on 17/7/19.
//  Copyright © 2017年 mibo02. All rights reserved.
//

#import "moneyhead.h"

@implementation moneyhead

- (instancetype)initWithFrame:(CGRect)frame leftstr:(NSString *)leftstr rightstr:(NSString *)rightstr
{
    if ([super initWithFrame:frame]) {
        self.backgroundColor = [UIColor redColor];
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(30, 30, 60, 25)];
        lab.text = @"余额";
        lab.font = H15;
        lab.textColor = [UIColor whiteColor];
        [self addSubview:lab];
        //
        UILabel *seclab = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 + 30, 30, 60, 25)];
        seclab.font = H15;
        seclab.textColor = [UIColor whiteColor];
        seclab.text = @"押金";
        [self addSubview:seclab];
        //
        UILabel *leftlab = [[UILabel alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(lab.frame) + 30, 90, 30)];
        leftlab.attributedText = [ZLabel attributedTextArray:@[@"¥",leftstr,@".00"] textColors:@[[UIColor whiteColor],[UIColor whiteColor],[UIColor whiteColor]] textfonts:@[H13,H20,H15]];
        [self addSubview:leftlab];
        UILabel *leftlab1 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 + 30, CGRectGetMaxY(seclab.frame) + 30, 90, 30)];
        leftlab1.attributedText = [ZLabel attributedTextArray:@[@"¥",rightstr,@".00"] textColors:@[[UIColor whiteColor],[UIColor whiteColor],[UIColor whiteColor]] textfonts:@[H13,H20,H15]];
        [self addSubview:leftlab1];
        UIView *linev  = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2 - 0.5, CGRectGetMaxY(lab.frame) + 30, 1, 30)];
        linev.backgroundColor = [UIColor whiteColor];
        [self addSubview:linev];
        
    }
    return self;
}

@end
