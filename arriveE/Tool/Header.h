//
//  Header.h
//  arriveE
//
//  Created by mibo02 on 17/7/6.
//  Copyright © 2017年 mibo02. All rights reserved.
//

#ifndef Header_h
#define Header_h

//判断是否为iPhone
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)


//判断是否为iPad
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)


//判断是否为ipod
#define IS_IPOD ([[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"])

// 根据屏幕分辨率判断设备，是则返回YES，不是返回NO
#define isiPhone5or5sor5c ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define isiPhone6or6s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define isiPhone6plusor6splus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

//获取系统版本
//这个方法不是特别靠谱
#define IOS_SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
//建议使用这个方法
#define IOS_SYSTEM_STRING [[UIDevice currentDevice] systemVersion]

//判断 iOS 8 或更高的系统版本
#define IOS_VERSION_8_OR_LATER (([[[UIDevice currentDevice] systemVersion] floatValue] >=8.0)? (YES):(NO))


//self
#define WS(weakSelf) __weak  __typeof(&*self)weakSelf = self;

/**随机颜色*/
#define RandomColor [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1.0]

//颜色
#define XYColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

//浅蓝色导航栏
#define NavBarColor XYColor(47,169,59)
#define GrayBarColor XYColor(240,240,240)

#define BackgroundColor XYColor(233,233,233)
//定位颜色
#define LocateColor XYColor(61,181,230)
//获取通知中心
#define LRNotificationCenter [NSNotificationCenter defaultCenter]
//尺寸
#define SCREEN_WIDTH     [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT    [UIScreen mainScreen].bounds.size.height
#define TabBarHeight 49
///正常字体
#define H30 [UIFont systemFontOfSize:30]
#define H29 [UIFont systemFontOfSize:29]
#define H28 [UIFont systemFontOfSize:28]
#define H27 [UIFont systemFontOfSize:27]
#define H26 [UIFont systemFontOfSize:26]
#define H25 [UIFont systemFontOfSize:25]
#define H24 [UIFont systemFontOfSize:24]
#define H23 [UIFont systemFontOfSize:23]
#define H22 [UIFont systemFontOfSize:22]
#define H20 [UIFont systemFontOfSize:20]
#define H19 [UIFont systemFontOfSize:19]
#define H18 [UIFont systemFontOfSize:18]
#define H17 [UIFont systemFontOfSize:17]
#define H16 [UIFont systemFontOfSize:16]
#define H15 [UIFont systemFontOfSize:15]
#define H14 [UIFont systemFontOfSize:14]
#define H13 [UIFont systemFontOfSize:13]
#define H12 [UIFont systemFontOfSize:12]
#define H11 [UIFont systemFontOfSize:11]
#define H10 [UIFont systemFontOfSize:10]
#define H8 [UIFont systemFontOfSize:8]
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#endif /* Header_h */
