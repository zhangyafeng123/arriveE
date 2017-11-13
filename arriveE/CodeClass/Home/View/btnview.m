//
//  btnview.m
//  arriveE
//
//  Created by mibo02 on 17/7/18.
//  Copyright © 2017年 mibo02. All rights reserved.
//

#import "btnview.h"

@interface btnview ()
@property (nonatomic, strong)NSMutableArray *arr;

@end

@implementation btnview


- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super  initWithFrame:frame]) {
        self.arr = [NSMutableArray new];
        self.backgroundColor = [UIColor whiteColor];
        UIButton *btn1=  [UIButton buttonWithType:(UIButtonTypeCustom)];
        btn1.frame = CGRectMake((SCREEN_WIDTH - 240)/3, 15, 120, 30);
        [btn1 setTitle:@"接单排行榜" forState:(UIControlStateNormal)];
        [btn1 setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        btn1.backgroundColor = [UIColor redColor];
        btn1.titleLabel.font = H14;
        btn1.layer.cornerRadius = 5;
        btn1.layer.masksToBounds = YES;
        btn1.tag = 150;
        [btn1 addTarget:self action:@selector(btnaction:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:btn1];
        
        UIButton *btn11=  [UIButton buttonWithType:(UIButtonTypeCustom)];
        CGFloat i = (SCREEN_WIDTH - 240)/3;
        btn11.frame = CGRectMake(i * 2 + 120, 15, 120, 30);
        btn11.titleLabel.font = H14;
        [btn11 setTitle:@"收入排行榜" forState:(UIControlStateNormal)];
        [btn11 setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        btn11.backgroundColor = [UIColor lightGrayColor];
        btn11.tag = 151;
        btn11.layer.cornerRadius = 5;
        btn11.layer.masksToBounds = YES;
        [btn11 addTarget:self action:@selector(btnaction:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:btn11];
        
        [self.arr addObject:btn1];
        [self.arr addObject:btn11];
        UIView *lineview = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 1, SCREEN_WIDTH, 1)];
        lineview.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self addSubview:lineview];
    }
    return self;
}

- (void)btnaction:(UIButton *)sender
{
    [self unbtnaction:sender.tag];
    if ([self.delggate respondsToSelector:@selector(clickaction:)]) {
        [self.delggate clickaction:sender.tag];
    }
    
}
- (void)unbtnaction:(NSUInteger)tag
{
    for (UIButton *btn in self.arr) {
        if (btn.tag == tag) {
            [btn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
            btn.backgroundColor = [UIColor redColor];
        } else {
            [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
            btn.backgroundColor = [UIColor lightGrayColor];
        }
    }
}

@end
