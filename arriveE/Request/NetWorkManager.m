//
//  NetWorkManager.m
//  ProjectA
//
//  Created by mibo02 on 16/9/2.
//  Copyright © 2016年 mibo02. All rights reserved.
//

#import "NetWorkManager.h"

@implementation NetWorkManager

+ (NetWorkManager *)sharedManager{
    static NetWorkManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[NetWorkManager alloc]init];
    });
    return manager;
}
/**
 *  json转字符串
 */
+ (NSString *)jsonToString:(id)data
{
    if(!data) { return nil; }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:nil];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

+ (void)requestForGetWithUrl:(NSString *)url
                   parameter:(NSDictionary *)dic
                     success:(void(^)(id reponseObject))success
                     failure:(void(^)(NSError *error))aError{
    /**创建一个网络请求管理对象*/
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    /**设置可接受的数据类型*/
    manager.responseSerializer.acceptableContentTypes =[NSSet setWithObjects:@"text/html",@"application/json", nil];
    /**开始网络请求*/
    [manager GET:url parameters:dic progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",[self jsonToString:responseObject]);
        //将请求成功返回的结果会调回去
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //回调请求失败的错误信息
        aError(error);
    }];
}


+ (void)requestForPostWithUrl:(NSString *)url
                    parameter:(NSDictionary *)dic
                      success:(void(^)(id reponseObject))success
                      failure:(void(^)(NSError *error))aError{
    //创建网络请求类管理对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //设置可接受的数据类型
    manager.responseSerializer.acceptableContentTypes =[NSSet setWithObjects:@"text/html",@"application/json",@"text/json",@"text/javascript", nil];
    
    
    [manager POST:url parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",[self jsonToString:responseObject]);
        //请求成功结果的回调
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //请求失败结果的回调
        aError(error);
    }];
}
// 上传单张图片
+ (void)uploadPOST:(NSString *)url
        parameters:(NSDictionary *)parameters
         consImage:(UIImage *)consImage
           success:(void(^)(id responObject))successBlock
           failure:(void(^)(NSError *error))failureBlock progress:(void(^)(NSProgress *progress))progressBlock {
    
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //设置可接受的数据类型
    manager.responseSerializer.acceptableContentTypes =[NSSet setWithObjects:@"text/html",@"application/json", nil];
    
    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        if (consImage) {
            //1.转成NSData类型
            NSData *data = UIImageJPEGRepresentation(consImage, 1);
            //2.加时间
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            //转成文件格式
            NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
            [formData appendPartWithFileData:data name:@"file"  fileName:fileName mimeType:@"png"];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        progressBlock(uploadProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        successBlock(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failureBlock(error);
        
    }];
    
}

// 上传多张图片
+ (void)uploadPOST:(NSString *)url
        parameters:(NSDictionary *)parameters
        consImages:(NSArray<UIImage *> *)consImages
           success:(void(^)(id responObject))successBlock
           failure:(void(^)(NSError *error))failureBlock {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", nil];
    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        if (consImages) {
            for (int i = 0; i < consImages.count; i++) {
                //1.转成NSData类型
                NSData *imageData = UIImageJPEGRepresentation(consImages[i], 1);
                //2.加时间
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                formatter.dateFormat = @"yyyyMMddHHmmss";
                NSString *str = [formatter stringFromDate:[NSDate date]];
                //转成文件格式
                NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
                [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"supplyFile%d",i]  fileName:fileName mimeType:@"png"];
                
                
            }
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        successBlock(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
        
    }];
}



@end
