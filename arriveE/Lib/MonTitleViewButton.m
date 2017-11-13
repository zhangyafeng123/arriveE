//
//  MonTitleViewButton.m
//  PractiseA
//
//  Created by mibo02 on 16/11/25.
//  Copyright © 2016年 mibo02. All rights reserved.
//

#import "MonTitleViewButton.h"

@implementation MonTitleViewButton

//调整UIButton内部子空间的位置
//
//- (CGRect)titleRectForContentRect:(CGRect)contentRect
//{
//    //将文本空间调整到按钮的左边
//}
////调整按钮内部图片控件的位置
//- (CGRect)imageRectForContentRect:(CGRect)contentRect
//{
//    //将图片空间调整到按钮的右边
//}


- (void)layoutSubviews
{
    [super layoutSubviews];
    //只需要调整一次
    if (self.imageView.x < self.titleLabel.x) {
        //调整UIlabel的位置
        self.titleLabel.x = self.imageView.x;//
        //调整UIimageView
        self.imageView.x = CGRectGetMaxX(self.titleLabel.frame);
        
    }// 在UIButton中，设置titleLabel和imageView时，分别会调用layoutSubviews方法
}
//重写title的setter方法，主要是为了方便别人在外面更改titleView的标题
- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    [self sizeToFit];
    
}

// MARK:- 重写image的setter方法，主要是为了方便别人在外面更改titleView的图片
- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    [self sizeToFit];
}
@end
