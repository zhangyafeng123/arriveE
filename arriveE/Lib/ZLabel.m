//
//  ZLabel.m
//  ProjectA
//
//  Created by mibo02 on 16/10/20.
//  Copyright © 2016年 mibo02. All rights reserved.
//

#import "ZLabel.h"

@implementation ZLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}


- (void)labelText:(NSString *)text
      lineSpacing:(CGFloat)l_spacing
{
    if(l_spacing<0){
        self.text = text;
        return;
    }
    self.numberOfLines = 0;
    
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = l_spacing;
    
    [attributedStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, text.length)];
    [attributedStr addAttribute:NSForegroundColorAttributeName value:self.textColor range:NSMakeRange(0, text.length)];
    [attributedStr addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, text.length)];
    
    self.attributedText = attributedStr;
}



- (void)labelText:(NSString *)text
   sectionSpacing:(CGFloat)s_spacing
      lineSpacing:(CGFloat)l_spacing
{
    if(s_spacing<=0 && l_spacing<=0){
        self.text = text;
        return;
    }
    
    self.numberOfLines = 0;
    
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = l_spacing; // lineSpacing
    paragraphStyle.paragraphSpacing = s_spacing; // paragraphSpacing
    [attributedStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, text.length)];
    [attributedStr addAttribute:NSForegroundColorAttributeName value:self.textColor range:NSMakeRange(0, text.length)];
    [attributedStr addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, text.length)];
    
    self.attributedText = attributedStr;
}


+ (NSAttributedString *)attributedTextArray:(NSArray *)texts
                                 textColors:(NSArray *)colors
                                  textfonts:(NSArray *)fonts
{
    if(texts.count == 0){
        return nil;
    }
    
    NSMutableAttributedString *resultAttributedStr = [[NSMutableAttributedString alloc] init];
    for(int i=0; i<texts.count; i++)
    {
        NSString *text = texts[i];
        NSMutableAttributedString *mAttributedStr = [[NSMutableAttributedString alloc] initWithString:text];
        [mAttributedStr addAttribute:NSForegroundColorAttributeName value:colors[i] range:NSMakeRange(0, text.length)];
        [mAttributedStr addAttribute:NSFontAttributeName value:fonts[i] range:NSMakeRange(0, text.length)];
        [resultAttributedStr appendAttributedString:mAttributedStr];
    }
    
    return resultAttributedStr;
    
}


+ (NSAttributedString *)attributedTextArray:(NSArray *)texts
                                 textColors:(NSArray *)colors
                                  textfonts:(NSArray *)fonts
                                lineSpacing:(CGFloat)l_spacing
{
    if(texts.count == 0){
        return nil;
    }
    
    NSMutableAttributedString *resultAttributedStr = [[NSMutableAttributedString alloc] init];
    
    for(int i=0; i<texts.count; i++)
    {
        NSString *text = texts[i];
        NSMutableAttributedString *mAttributedStr = [[NSMutableAttributedString alloc] initWithString:text];
        [mAttributedStr addAttribute:NSForegroundColorAttributeName value:colors[i] range:NSMakeRange(0, text.length)];
        [mAttributedStr addAttribute:NSFontAttributeName value:fonts[i] range:NSMakeRange(0, text.length)];
        [resultAttributedStr appendAttributedString:mAttributedStr];
    }
    
    if(l_spacing>0){
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = l_spacing;
        [resultAttributedStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, resultAttributedStr.length)];
    }
    
    
    return resultAttributedStr;
}



+ (CGSize)sizeLabelWidth:(CGFloat)width
          attributedText:(NSAttributedString *)attributted
{
    if(width<=0){
        return CGSizeZero;
    }
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 1000)];
    lab.attributedText = attributted;
    lab.numberOfLines = 0;
    
    CGSize labSize = [lab sizeThatFits:lab.bounds.size];
    return labSize;
}


+ (CGSize)sizeLabelWidth:(CGFloat)width
                    text:(NSString *)text
                    font:(UIFont *)font
{
    if(width<=0 || text.length == 0){
        return CGSizeZero;
    }
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 1000)];
    lab.text = text;
    if(font){
        lab.font = font;
    }
    
    CGSize labSize = [lab sizeThatFits:lab.bounds.size];
    return labSize;
}


+ (CGSize)sizeLabelWidth:(CGFloat)width
                    text:(NSString *)text
                    font:(UIFont *)font
             lineSpacing:(CGFloat)l_spacing
{
    if(width<=0 || text.length == 0){
        return CGSizeZero;
    }
    
    if(l_spacing<=0){
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 1000)];
        lab.text = text;
        lab.numberOfLines = 0;
        if(font){
            lab.font = font;
        }
        
        CGSize labSize = [lab sizeThatFits:lab.bounds.size];
        return labSize;
    }
    else
    {
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 1000)];
        lab.numberOfLines = 0;
        if(font){
            lab.font = font;
        }
        NSMutableAttributedString *mAttriStr = [[NSMutableAttributedString alloc] initWithString:text];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = l_spacing;
        [mAttriStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, text.length)];
        lab.attributedText = mAttriStr;
        
        CGSize labSize = [lab sizeThatFits:lab.bounds.size];
        return labSize;
    }
}

@end
