//
//  btnview.h
//  arriveE
//
//  Created by mibo02 on 17/7/18.
//  Copyright © 2017年 mibo02. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol btnviewDelegate <NSObject>

- (void)clickaction:(NSInteger)tag;

@end

@interface btnview : UIView

@property (nonatomic, assign)id<btnviewDelegate>delggate;
- (instancetype)initWithFrame:(CGRect)frame;


@end
