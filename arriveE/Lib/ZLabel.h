//
//  ZLabel.h
//  ProjectA
//
//  Created by mibo02 on 16/10/20.
//  Copyright © 2016年 mibo02. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLabel : UILabel

- (void)labelText:(NSString *)text
      lineSpacing:(CGFloat)l_spacing;


- (void)labelText:(NSString *)text
   sectionSpacing:(CGFloat)s_spacing
      lineSpacing:(CGFloat)l_spacing;


+ (NSAttributedString *)attributedTextArray:(NSArray *)texts
                                 textColors:(NSArray *)colors
                                  textfonts:(NSArray *)fonts;


+ (NSAttributedString *)attributedTextArray:(NSArray *)texts
                                 textColors:(NSArray *)colors
                                  textfonts:(NSArray *)fonts
                                lineSpacing:(CGFloat)l_spacing;


+ (CGSize)sizeLabelWidth:(CGFloat)width
          attributedText:(NSAttributedString *)attributted;


+ (CGSize)sizeLabelWidth:(CGFloat)width
                    text:(NSString *)text
                    font:(UIFont *)font;


+ (CGSize)sizeLabelWidth:(CGFloat)width
                    text:(NSString *)text
                    font:(UIFont *)font
             lineSpacing:(CGFloat)l_spacing;





@end
