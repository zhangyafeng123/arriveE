//
//  TXTradePasswordView.m
//  TF
//
//  Created by --- on 16/1/3.
//  Copyright © 2016年 吴天祥. All rights reserved.
//

#import "TXTradePasswordView.h"

@implementation TXTradePasswordView

//当视图将要消失的时候销毁定时器

- (id)initWithFrame:(CGRect)frame  success:(void(^)(id reponseObject))success;
{
    self = [super initWithFrame:frame];// 先调用父类的initWithFrame方法
    if (self)
    {
        ///标题
        _lable_title = [[UILabel alloc]init];
        _lable_title.frame = CGRectMake(0, 20, SCREEN_WIDTH, 20);
        _lable_title.text = @"请输入验证码";
        _lable_title.textAlignment=1;
        _lable_title.font = H20;
        _lable_title.textColor = [UIColor blackColor];
        [self addSubview:_lable_title];
        //
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, 40)];
        lab.numberOfLines = 2;
        lab.textColor = [UIColor grayColor];
        lab.font = H13;
        lab.textAlignment=1;
        [self addSubview:lab];
        _timerLab = [[MZTimerLabel alloc] initWithLabel:lab andTimerType:(MZTimerLabelTypeTimer)];
        [_timerLab setCountDownTime:60];
        _timerLab.timeFormat = @"验证码已发送至110\nss秒后重发";
        [_timerLab start];
        
        ///  TF
        _TF = [[UITextField alloc]init];
        _TF.frame = CGRectMake(0, 0, 0, 0);
        _TF.delegate = self;
        _TF.keyboardType=UIKeyboardTypeNumberPad;
        [_TF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [self addSubview:_TF];
        
        
        ///  假的输入框
        _view_box = [[UIView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 270)/2, 120, boxWidth, boxWidth)];
        [_view_box.layer setBorderWidth:1.0];
        _view_box.layer.borderColor = [[UIColor grayColor]CGColor];
        _view_box.layer.cornerRadius = 4;
        _view_box.layer.masksToBounds = YES;
        [self addSubview:_view_box];
        _view_box2 = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_view_box.frame) + 10, _view_box.frame.origin.y, boxWidth, boxWidth)];
        [_view_box2.layer setBorderWidth:1.0];
        _view_box2.layer.borderColor = [[UIColor grayColor]CGColor];
        _view_box2.layer.cornerRadius = 4;
        _view_box2.layer.masksToBounds = YES;
        [self addSubview:_view_box2];
        _view_box3 = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_view_box2.frame) + 10, _view_box.frame.origin.y, boxWidth, boxWidth)];
        [_view_box3.layer setBorderWidth:1.0];
        _view_box3.layer.borderColor = [[UIColor grayColor]CGColor];
        _view_box3.layer.cornerRadius = 4;
        _view_box3.layer.masksToBounds = YES;
        [self addSubview:_view_box3];
        _view_box4 = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_view_box3.frame) + 10, _view_box.frame.origin.y, boxWidth, boxWidth)];
        [_view_box4.layer setBorderWidth:1.0];
        _view_box4.layer.borderColor = [[UIColor grayColor]CGColor];
        _view_box4.layer.cornerRadius = 4;
        _view_box4.layer.masksToBounds = YES;
        [self addSubview:_view_box4];
       
        //
        _linklabel = [[FMLinkLabel alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 270)/2, CGRectGetMaxY(_view_box.frame) + 10, 270, 20)];
        _linklabel.text = @"输入验证码表示同意《直到法律申明及协议》";
        _linklabel.font = H13;
        _linklabel.textColor = [UIColor grayColor];
        [_linklabel addClickText:@"直到法律申明及协议" attributeds:@{NSForegroundColorAttributeName : [UIColor blueColor]} transmitBody:(id)@"" clickItemBlock:^(id transmitBody) {
            
            success(transmitBody);
            
        }];
        [self addSubview:_linklabel];
        ///   密码点
        _lable_point = [[UILabel alloc]init];
        _lable_point.frame = CGRectMake((_view_box.frame.size.width-10)/2, (_view_box.frame.size.width-10)/2, 10, 10);
        [_lable_point.layer setCornerRadius:5];
        [_lable_point.layer setMasksToBounds:YES];
        _lable_point.backgroundColor = [UIColor blackColor];
        [_view_box addSubview:_lable_point];
        
        _lable_point2 = [[UILabel alloc]init];
        _lable_point2.frame = CGRectMake((_view_box.frame.size.width-10)/2, (_view_box.frame.size.width-10)/2, 10, 10);
        [_lable_point2.layer setCornerRadius:5];
        [_lable_point2.layer setMasksToBounds:YES];
        _lable_point2.backgroundColor = [UIColor blackColor];
        [_view_box2 addSubview:_lable_point2];
        
        
        _lable_point3 = [[UILabel alloc]init];
        _lable_point3.frame = CGRectMake((_view_box.frame.size.width-10)/2, (_view_box.frame.size.width-10)/2, 10, 10);
        [_lable_point3.layer setCornerRadius:5];
        [_lable_point3.layer setMasksToBounds:YES];
        _lable_point3.backgroundColor = [UIColor blackColor];
        [_view_box3 addSubview:_lable_point3];
        
        _lable_point4 = [[UILabel alloc]init];
        _lable_point4.frame = CGRectMake((_view_box.frame.size.width-10)/2, (_view_box.frame.size.width-10)/2, 10, 10);
        [_lable_point4.layer setCornerRadius:5];
        [_lable_point4.layer setMasksToBounds:YES];
        _lable_point4.backgroundColor = [UIColor blackColor];
        [_view_box4 addSubview:_lable_point4];
        
        
        _lable_point.hidden=YES;
        _lable_point2.hidden=YES;
        _lable_point3.hidden=YES;
        _lable_point4.hidden=YES;
    }
    return self;
}
- (void) textFieldDidChange:(id) sender
{
    
    UITextField *_field = (UITextField *)sender;
    
    switch (_field.text.length) {
        case 0:
        {
            _lable_point.hidden=YES;
            _lable_point2.hidden=YES;
            _lable_point3.hidden=YES;
            _lable_point4.hidden=YES;
           
        }
            break;
        case 1:
        {
            _lable_point.hidden=NO;
            _lable_point2.hidden=YES;
            _lable_point3.hidden=YES;
            _lable_point4.hidden=YES;
           
        }
            break;
        case 2:
        {
            _lable_point.hidden=NO;
            _lable_point2.hidden=NO;
            _lable_point3.hidden=YES;
            _lable_point4.hidden=YES;
            
        }
            break;
        case 3:
        {
            _lable_point.hidden=NO;
            _lable_point2.hidden=NO;
            _lable_point3.hidden=NO;
            _lable_point4.hidden=YES;
           
        }
            break;
        case 4:
        {
            _lable_point.hidden=NO;
            _lable_point2.hidden=NO;
            _lable_point3.hidden=NO;
            _lable_point4.hidden=NO;
            
        }
            break;
         
        default:
            break;
    }
    
    
    if (_field.text.length==4)
    {        
        [self.TXTradePasswordDelegate TXTradePasswordView:self WithPasswordString:_field.text];
        
}
    
    
    
    
    
    
    
}
@end
