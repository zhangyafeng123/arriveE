//
//  arrCustomAnnotationView.h
//  arriveE
//
//  Created by mibo02 on 17/7/21.
//  Copyright © 2017年 mibo02. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "arrCustomCalloutView.h"
@interface arrCustomAnnotationView : MAAnnotationView

@property (nonatomic, readonly) arrCustomCalloutView *calloutView;

@end
