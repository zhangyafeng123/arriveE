//
//  NetWorkManager.h
//  ProjectA
//
//  Created by mibo02 on 16/9/2.
//  Copyright © 2016年 mibo02. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
@interface NetWorkManager : NSObject


+ (NetWorkManager *)sharedManager;

/**
 *  GET网络请求
 *
 *  @param url     请求的网址
 *  @param dic     请求需要的参数
 *  @param success 请求成功的回调
 *  @param error   请求失败的回调
 */
+ (void)requestForGetWithUrl:(NSString *)url
                   parameter:(NSDictionary *)dic
                     success:(void(^)(id reponseObject))success
                     failure:(void(^)(NSError *error))aError;

/**
 *  POST网络请求
 *
 *  @param url     请求的网址
 *  @param dic     请求需要的参数
 *  @param success 请求成功的回调
 *  @param error   请求失败的回调
 */
+ (void)requestForPostWithUrl:(NSString *)url
                    parameter:(NSDictionary *)dic
                      success:(void(^)(id reponseObject))success
                      failure:(void(^)(NSError *error))aError;

/** 上传单张图片 */
+ (void)uploadPOST:(NSString *)url
        parameters:(NSDictionary *)parameters
         consImage:(UIImage *)consImage
           success:(void(^)(id responObject))successBlock
           failure:(void(^)(NSError *error))failureBlock progress:(void(^)(NSProgress *progress))progressBlock;

/** 上传多张图片 */
+ (void)uploadPOST:(NSString *)url
        parameters:(NSDictionary *)parameters
        consImages:(NSArray<UIImage *> *)consImages
           success:(void(^)(id responObject))successBlock
           failure:(void(^)(NSError *error))failureBlock;

@end
