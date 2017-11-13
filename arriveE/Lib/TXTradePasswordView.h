//
//  TXTradePasswordView.h
//  TF
//
//  Created by --- on 16/1/3.
//  Copyright © 2016年 吴天祥. All rights reserved.
//

#import <UIKit/UIKit.h>

#define  boxWidth 60 //密码框的宽度

@class TXTradePasswordView;

@protocol TXTradePasswordViewDelegate <NSObject>

@optional

-(void)TXTradePasswordView:(TXTradePasswordView *)view WithPasswordString:(NSString *)Password;

@end




@interface TXTradePasswordView : UIView <UITextFieldDelegate>

@property (nonatomic,assign)id <TXTradePasswordViewDelegate>TXTradePasswordDelegate;



- (id)initWithFrame:(CGRect)frame  success:(void(^)(id reponseObject))success;

///标题
@property (nonatomic,)UILabel *lable_title;
@property (nonatomic,)UILabel *sub_title;
@property (nonatomic,)FMLinkLabel *linklabel;
///  TF
@property (nonatomic,)UITextField *TF;

///  假的输入框
@property (nonatomic,)UIView *view_box;
@property (nonatomic,)UIView *view_box2;
@property (nonatomic,)UIView *view_box3;
@property (nonatomic,)UIView *view_box4;


///   密码点
@property (nonatomic,)UILabel *lable_point;
@property (nonatomic,)UILabel *lable_point2;
@property (nonatomic,)UILabel *lable_point3;
@property (nonatomic,)UILabel *lable_point4;

@property (nonatomic, strong)MZTimerLabel  *timerLab;


@end
