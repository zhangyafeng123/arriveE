//
//  WeChatActionSheet.h
//  微信弹出
//
//  Created by apple on 16/3/16.
//  Copyright © 2016年 cheniue. All rights reserved.
//

#import <UIKit/UIKit.h>

#define WECHATCANCELINDEX (NSNotFound)

@class WeChatActionSheet;

typedef void (^WeChatActionSheetFunction)(WeChatActionSheet *actionSheet,NSInteger index);

@interface WeChatActionSheet : UIView
@property(nonatomic,strong,readonly)NSArray *titlesArray;
@property(nonatomic,strong,readonly)NSString *title;
@property(nonatomic,copy)WeChatActionSheetFunction function;
+(instancetype)showActionSheet:(NSString*)title buttonTitles:(NSArray*)buttonTitles;
@end


@interface ActionSheetCell : UITableViewCell
@property(nonatomic,strong,readonly)UIImageView *lineImageView;
@end