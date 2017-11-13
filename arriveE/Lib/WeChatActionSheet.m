//
//  WeChatActionSheet.m
//  微信弹出
//
//  Created by apple on 16/3/16.
//  Copyright © 2016年 cheniue. All rights reserved.
//

#import "WeChatActionSheet.h"
#define HEADHEIGHT (32.0f)
#define ROWHEIGHT (36.0f)
#define DISTANTHEIGHT (4.0f)
#define MINBLANKHEIGHT (40.0f)

@interface WeChatActionSheet()<UITableViewDataSource,UITableViewDelegate>
{
    UIButton *outSetButton;
    UIView *bottomView;
    UITableView *itemsButtonTable;
    UIButton *cancelButton;
    UILabel *titleLabel;
}
@end
@implementation WeChatActionSheet
+(instancetype)showActionSheet:(NSString *)title buttonTitles:(NSArray *)buttonTitles
{
    WeChatActionSheet *actionSheet = [[WeChatActionSheet alloc]initWithFrame:CGRectZero withTitle:title buttonTitles:buttonTitles];
    [actionSheet setAlpha:0.0f];
    [actionSheet showAnimation];
    return actionSheet;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title buttonTitles:(NSArray *)buttonTitles
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setBackgroundColor:[UIColor colorWithWhite:0.9f alpha:0.5f]];
        outSetButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [outSetButton addTarget:self action:@selector(disMiss) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:outSetButton];
        
        bottomView = [[UIView alloc]initWithFrame:CGRectZero];
        [self addSubview:bottomView];

        
        itemsButtonTable = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        [itemsButtonTable setDelegate:self];
        [itemsButtonTable setDataSource:self];
        [itemsButtonTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [bottomView addSubview:itemsButtonTable];
        
        cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(disMissButton:) forControlEvents:UIControlEventTouchUpInside];
        [cancelButton setBackgroundColor:[UIColor whiteColor]];
        [cancelButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [bottomView addSubview:cancelButton];
        
        titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        [titleLabel setTextAlignment:1];
        [titleLabel setTextColor:[UIColor grayColor]];
        [titleLabel setText:title];
        [titleLabel setBackgroundColor:[UIColor colorWithWhite:0.9988f alpha:1.0f]];
        [titleLabel setFont:[UIFont systemFontOfSize:14]];
        
        _titlesArray = [buttonTitles copy];
        _title = [title copy];
        
    }
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
    [self setupViewRelation];
    return self;
}
-(void)showAnimation
{
    [UIView animateWithDuration:0.26f animations:^{
        [self setAlpha:1.0f];
    }];
}
-(void)disMissButton:(UIButton*)sender
{
    if (self.function != NULL)
    {
        typeof(self) __weak weakself = self;
        self.function(weakself,WECHATCANCELINDEX);
    }
    [self disMiss];
}
-(void)disMiss
{
    [UIView animateWithDuration:0.43f animations:^{
        [bottomView setFrame:CGRectMake(bottomView.frame.origin.x, bottomView.frame.origin.y+bottomView.frame.size.height, bottomView.frame.size.width,bottomView.frame.size.height)];
        [self setBackgroundColor:[UIColor clearColor]];
    }completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
}
-(void)setupViewRelation
{
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSLayoutConstraint *width_self = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeWidth multiplier:1.0f constant:0.0f];
    NSLayoutConstraint *height_self = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeHeight multiplier:1.0f constant:0.0f];
    NSLayoutConstraint *centerX_self = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f];
    NSLayoutConstraint *centerY_self = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.superview attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0.0f];
    [self.superview addConstraints:@[width_self,centerX_self,height_self,centerY_self]];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat maxTableHeight = self.bounds.size.height-ROWHEIGHT-DISTANTHEIGHT-MINBLANKHEIGHT;
    CGFloat needHeight = HEADHEIGHT+ROWHEIGHT*[self.titlesArray count];
    CGFloat realyHeight = MIN(maxTableHeight, needHeight);
    
    [bottomView setFrame:CGRectMake(0.0f, self.bounds.size.height-realyHeight-DISTANTHEIGHT-ROWHEIGHT, self.bounds.size.width, realyHeight+DISTANTHEIGHT+ROWHEIGHT)];
    
    [cancelButton setFrame:CGRectMake(0, bottomView.bounds.size.height-ROWHEIGHT, bottomView.bounds.size.width, ROWHEIGHT)];
    
    [titleLabel setFrame:CGRectMake(0.0f, 0.0f, bottomView.bounds.size.width, HEADHEIGHT)];
    
    [itemsButtonTable setFrame:CGRectMake(0.0f, 0.0f, bottomView.bounds.size.width, realyHeight)];
    
    [outSetButton setFrame:CGRectMake(0.0f, 0.0f, self.bounds.size.width, bottomView.frame.origin.y)];

    if (maxTableHeight > needHeight)
    {
        [itemsButtonTable setScrollEnabled:NO];
    }
    else
    {
        [itemsButtonTable setScrollEnabled:YES];
    }
}
#pragma mark tableView代理方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ROWHEIGHT;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.titlesArray count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ActionSheetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ActionSheetCell"];
    if (!cell)
    {
        cell = [[ActionSheetCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ActionSheetCell"];
    }
    if (indexPath.row == ([self.titlesArray count]-1))
    {
        [cell.lineImageView setHidden:YES];
    }
    else
    {
        [cell.lineImageView setHidden:NO];
    }
    [cell.textLabel setText:[self.titlesArray objectAtIndex:indexPath.row]];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return HEADHEIGHT;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return titleLabel;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.function != NULL)
    {
        typeof(self) __weak weakself = self;
        self.function(weakself,indexPath.row);
    }
    [self disMiss];
}
@end
@implementation ActionSheetCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self.textLabel setFont:[UIFont systemFontOfSize:14]];
        [self.textLabel setTextColor:[UIColor colorWithWhite:0.2f alpha:1.0f]];
        [self.textLabel setTextAlignment:1];
        _lineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, ROWHEIGHT-1.0f/[UIScreen mainScreen].scale, 320.0f, 1.0f/[UIScreen mainScreen].scale)];
        [_lineImageView setBackgroundColor:[UIColor colorWithRed:0.95f green:0.95f blue:0.95f alpha:1.0f]];
        [_lineImageView setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleWidth];
        [self addSubview:_lineImageView];
    }
    return self;
}

@end