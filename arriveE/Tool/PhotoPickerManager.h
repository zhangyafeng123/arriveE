//
//  PhotoPickerManager.h
//  Shopping
//
//  Created by xiangguohe on 16/7/26.
//  Copyright © 2016年 XGH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoPickerManager : NSObject

/**
    创建单例类
 */
+ (instancetype)sharedManager;

/**
    保存图片到相片胶卷
 */
- (void)saveImage:(UIImage *)image toPhotoRoll:(void(^)())successSave fail:(void(^)())failBlock;

/**
 保存图片到自定义相册
 */
- (void)saveImage:(UIImage *)image toPhotosName:(NSString *) name success:(void (^)())successSave fail:(void (^)())failBlock;

/**
    选择单张图片
 */
- (void)getImageInView:(UIViewController *)vc successBlock:(void(^)(UIImage *image))successBlock;

/**
    选择多张图片   0为不限张数
 */
- (void)getImagesInView:(UIViewController *)vc maxCount:(NSInteger)maxCount successBlock:(void(^)(NSMutableArray<UIImage *> *images))successBlock;


//判断时间
+ (NSInteger)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay;

#pragma mark -得到当前时间
+ (NSDate *)getCurrentTime;










@end
