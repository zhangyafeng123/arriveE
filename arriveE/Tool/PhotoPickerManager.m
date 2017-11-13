//
//  PhotoPickerManager.m
//  Shopping
//
//  Created by xiangguohe on 16/7/26.
//  Copyright © 2016年 XGH. All rights reserved.
//

#import "PhotoPickerManager.h"
#import <CTAssetsPickerController/CTAssetsPickerController.h>

@interface PhotoPickerManager () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, CTAssetsPickerControllerDelegate>

// 视图控制器
@property (nonatomic, strong) UIViewController *vc;
// 选择单张图片的block回调
@property (nonatomic, copy) void(^successBlock)(UIImage *image);
// 选择多张图片的block回调
@property (nonatomic, copy) void(^successBlocks)(NSMutableArray<UIImage *> *images);
// 选择多张图片时的最大张数
@property (nonatomic, assign) NSInteger maxCount;

@property (nonatomic, strong) PHFetchResult<PHAsset *> *createAssets;



@end

@implementation PhotoPickerManager


+ (instancetype)sharedManager {

    static PhotoPickerManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[PhotoPickerManager alloc] init];
    });
    return manager;
}

// 保存图片到相片胶卷
- (void)saveImage:(UIImage *)image toPhotoRoll:(void(^)())successSave fail:(void(^)())failBlock {

    __block NSString *createdAssetId = nil;
    // 添加图片到相机胶卷
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        createdAssetId = [PHAssetChangeRequest creationRequestForAssetFromImage:image].placeholderForCreatedAsset.localIdentifier;
    } error:nil];
    if (createdAssetId == nil) {
        if (failBlock) {
            failBlock();
        }
    } else {
        if (successSave) {
            successSave();
        }
    }

}

// 保存图片到自定义相册
- (void)saveImage:(UIImage *)image toPhotosName:(NSString *) name success:(void (^)())successSave fail:(void (^)())failBlock {

    [self saveImage:image toPhotoRoll:nil fail:nil];
    // 获得相片
    PHFetchResult<PHAsset *> *createdAssets = self.createAssets;
    // 获得相册
    PHAssetCollection * createdCollection = [self createdCollectionWithName:name];
    if (createdAssets == nil || createdCollection == nil) {
        if (failBlock) {
            failBlock();
        }
        return;
    }

    // 将相片添加到相册
    NSError * error = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        PHAssetCollectionChangeRequest * request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:createdCollection];
        [request insertAssets:createdAssets atIndexes:[NSIndexSet indexSetWithIndex:0]];
    } error:&error];
    // 保存结果
    if (error) {
        if (failBlock) {
            failBlock();
        }
    } else {
        if (successSave) {
            successSave();
        }
    }

}

// 获得自定义相册
- (PHAssetCollection *)createdCollectionWithName:(NSString *)name {

    // 获取软件的名字作为相册的标题(如果需求不是要软件名称作为相册名字就可以自己把这里改成想要的名称)
    NSString *title = [NSBundle mainBundle].infoDictionary[(NSString *)kCFBundleNameKey];
    if (name) {
        title = name;
    }

    // 获得所有的自定义相册
    PHFetchResult<PHAssetCollection *> *collections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];

    for (PHAssetCollection *collection in collections) {
        if ([collection.localizedTitle isEqualToString:title]) {
            return collection;
        }
    }

    // 代码执行到这里， 说明还没有自定义相册
    __block NSString *createdCollectionId = nil;
    // 创建一个新的相册
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        createdCollectionId = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:title].placeholderForCreatedAssetCollection.localIdentifier;
    } error:nil];

    if (createdCollectionId == nil) {
        return nil;
    }
    // 创建完毕后再取出相册
    return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[createdCollectionId] options:nil].firstObject;
    
}



#pragma mark - ================================选择单张图片
// 选择单张图片
- (void)getImageInView:(UIViewController *)vc successBlock:(void(^)(UIImage *image))successBlock {

    self.vc = vc;
    self.successBlock = successBlock;
    WeChatActionSheet *sheetv = [WeChatActionSheet showActionSheet:@"图片选择" buttonTitles:@[@"拍照",@"图库"]];
    [sheetv setFunction:^(WeChatActionSheet *actionSheet,NSInteger index)
     {
         if (index == WECHATCANCELINDEX)
         {
             NSLog(@"点击了取消按钮");
         }
         else
         {
             
             if (index == 0) {
                 [self readImageFromCamera];
             } else {
                 [self readImageFromLibrary];
             }
         }
     }];
//    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"获取照片" preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//        
//
//    }];
//
//    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//        
//
//    }];
//    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
//
//    [alertVC addAction:action1];
//    [alertVC addAction:action2];
//    [alertVC addAction:action3];
//
//    [vc presentViewController:alertVC animated:YES completion:nil];

}

//UIImagePickerControllerSourceTypePhotoLibrary, 从所有相册中选择图片
//UIImagePickerControllerSourceTypeCamera, 利用照相机拍一张图片（自定义照相机AVCaptureSession）
//UIImagePickerControllerSourceTypeSavedPhotosAlbum 从Moments相册中选择图片

//从图库中读取照片
- (void)readImageFromLibrary {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];//创建对象
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;//（选择类型）表示仅仅从相册中选取照片
    imagePicker.delegate = self;//指定代理，因此我们要实现UIImagePickerControllerDelegate,  UINavigationControllerDelegate协议
    imagePicker.allowsEditing = YES;//设置在相册选完照片后，是否跳到编辑模式进行图片剪裁。(允许用户编辑)
    [self.vc presentViewController:imagePicker animated:YES completion:nil];//显示相册

}

//拍照
- (void)readImageFromCamera {
    //判断选择的模式是否为相机模式，如果没有弹窗警告
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.allowsEditing = YES;//允许编辑
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.delegate = self;
        [self.vc presentViewController:imagePicker animated:YES completion:nil];
    } else {
        //弹出窗口响应点击事件

        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"警告" message:@"未检测到摄像头" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alertVC addAction:action1];
        [self.vc presentViewController:alertVC animated:YES completion:nil];
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {

    // 关闭图片选择界面
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = info[UIImagePickerControllerEditedImage];
        NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
        NSData *data;
        //当选择的类型是图片
        if ([type isEqualToString:@"public.image"])
        {
            
            //先把图片转成NSData
            UIImage* image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
           
            if (UIImagePNGRepresentation(image) == nil)
            {
                data = UIImageJPEGRepresentation(image, 1.0);
            }
            else
            {
                data = UIImagePNGRepresentation(image);
            }
            
        }
//            //图片保存的路径
//            //这里将图片放在沙盒的documents文件夹中
//            NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
//    
//            //文件管理器
//            NSFileManager *fileManager = [NSFileManager defaultManager];
//    
//            //把刚刚图片转换的data对象拷贝至沙盒中 并保存为image.png
//            [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
//            [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:@"/image.png"] contents:data attributes:nil];
//    
//            //得到选择后沙盒中图片的完整路径
//           NSString  *filePath = [[NSString alloc]initWithFormat:@"%@%@",DocumentsPath,  @"/image.png"];

        if (self.successBlock) {
            self.successBlock(image);
        }
   

}

#pragma mark - =========================选择多张图片
// 选择多张图片  0为不限张数
- (void)getImagesInView:(UIViewController *)vc maxCount:(NSInteger)maxCount successBlock:(void(^)(NSMutableArray<UIImage *> *images))successBlock {

    self.vc = vc;
    self.maxCount = maxCount;
    
    self.successBlocks = successBlock;
    
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status != PHAuthorizationStatusAuthorized) {
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            CTAssetsPickerController *picker = [[CTAssetsPickerController alloc] init];
            picker.delegate = self;
            // 显示选择的索引
            picker.showsSelectionIndex = YES;
            // 显示相册的类型： 相机胶卷+自定义相册
            picker.assetCollectionSubtypes = @[@(PHAssetCollectionSubtypeAny)];
            // 不需要显示空的相册
            picker.showsEmptyAlbums = NO;
            [vc presentViewController:picker animated:YES completion:nil];

        });
    }];

}

#pragma mark - CTAssetsPickerControllerDelegate
- (BOOL)assetsPickerController:(CTAssetsPickerController *)picker shouldSelectAsset:(PHAsset *)asset {

    if (self.maxCount != 0) {
        if (picker.selectedAssets.count >= self.maxCount) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"最多选择%ld张照片", self.maxCount] preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil]];
            [picker presentViewController:alert animated:YES completion:nil];
            return NO;
        }
    }
    return YES;

}

- (void)assetsPickerController:(CTAssetsPickerController *)picker didFinishPickingAssets:(NSArray<PHAsset *> *)assets {
    
    // 关闭图片选择界面
    [picker dismissViewControllerAnimated:YES completion:nil];
    // 基本配置
    CGFloat scale = [UIScreen mainScreen].scale;
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.resizeMode = PHImageRequestOptionsResizeModeExact;
    options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;

    NSMutableArray *images = [NSMutableArray new];
    // 遍历选择所有的图片
    for (NSInteger i = 0; i < assets.count; i++) {
        PHAsset *asset = assets[i];
        CGSize size = CGSizeMake(asset.pixelWidth / scale, asset.pixelHeight / scale);
        // 获取图片
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            UIImage *image = result;
            [images addObject:image];
           
            
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (i == assets.count - 1) {
                
                if (self.successBlocks) {
                    self.successBlocks(images);
                    
                    
                }
            }
        });
    
        }];
    }
    
}





//判断时间（是否是特价）
+ (NSInteger)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
   
    if (result == NSOrderedDescending) {
        //NSLog(@"Date1  is in the future");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"Date1 is in the past");
        return -1;
    }
    //NSLog(@"Both dates are the same");
    return 0;
    
}

#pragma mark -得到当前时间
+ (NSDate *)getCurrentTime{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
    NSString *dateTime=[formatter stringFromDate:[NSDate date]];
    NSDate *date = [formatter dateFromString:dateTime];
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    
    NSInteger interval = [zone secondsFromGMTForDate: date];
    
    NSDate *bijiaoDate = [date  dateByAddingTimeInterval: interval];
    
    NSLog(@"---------- currentDate == %@",date);
    return bijiaoDate;
}





@end
