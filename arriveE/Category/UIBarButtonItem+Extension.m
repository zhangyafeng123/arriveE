//
//  UIBarButtonItem+Extension.m
//  weibo
//
//  Created by ZpyZp on 15/3/16.
//  Copyright (c) 2015年 Zpy. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"
#import "UIView+exten.h"
@implementation UIBarButtonItem (Extension)

+(UIBarButtonItem *)CreateItemWithTarget:(id)target ForAction:(SEL)action WithImage:(NSString *)Image WithHighlightImage :(NSString *)highlightImage
{
    UIButton *Btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Btn setBackgroundImage:[UIImage imageNamed:Image] forState:UIControlStateNormal];
    [Btn setBackgroundImage:[UIImage imageNamed:highlightImage] forState:UIControlStateHighlighted] ;
    [Btn addTarget:target action:action  forControlEvents:UIControlEventTouchUpInside];
    //设置尺寸
    // CGSize size = backBtn.currentBackgroundImage.size;
    // [backBtn setFrame:CGRectMake(0, 0, size.width, size.height)];
    Btn.size = Btn.currentBackgroundImage.size;
    
    //注：一个控件出不来两个原因：1.没设置尺寸，2.没设置图片
    return [[UIBarButtonItem alloc] initWithCustomView:Btn];
}

+ (UIBarButtonItem *)initWithTitle:(NSString *)title titleColor:(UIColor *)titleColor target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(10, 0, 80, 40);
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    btn.backgroundColor = [UIColor clearColor];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return item;
}





@end
