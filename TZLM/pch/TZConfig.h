//
//  TZConfig.h
//  TZLM
//
//  Created by  sun on 2017/2/25.
//  Copyright © 2017年 上海询通商务咨询有限公司. All rights reserved.
//

#ifndef TZConfig_h
#define TZConfig_h



//屏幕的长宽
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height

//------------------------全局的通知 Notifications---------------------------
#define TZNotificationCenter [NSNotificationCenter defaultCenter];
#define TZUserDafault [NSUserDefaults standardUserDefaults];

#define SZNotificationCenter [NSNotificationCenter defaultCenter]
//------------------------全局的颜色------------------------------------
#define Main_Color [UIColor colorWithRed:(36)/255.0 green:(167)/255.0 blue:(146)/255.0 alpha:1.0]
#define BackGround_Color [UIColor colorWithRed:(235)/255.0 green:(235)/255.0 blue:(241)/255.0 alpha:1.0]
#define VTColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define RGBColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define SZUserDefault [NSUserDefaults standardUserDefaults]

/*代码适配等比例拉伸（纯代码适配也可以用masonry）*/
#define kSCREEN_WIDTH_RATIO (kScreenW >= 375.0f ? kScreenW/320.0f : 1)
#define kSCREEN_HEIGHT_RATIO (kScreenH >= 667.0f ? kScreenH/568.0f : 1)
#define kAutoWEX(w) ((w)*kSCREEN_WIDTH_RATIO)
#define kAutoHEX(h) ((h)*kSCREEN_HEIGHT_RATIO)

//! ----------------------判断机型及系统---------------------------------------
#define isiPhone4 CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(320, 480)) ? YES:NO
#define isiPhone5 CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(320, 568)) ? YES:NO
#define isiPhone6 CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(375, 667)) ? YES:NO
#define isiPhone6p CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(414, 736)) ? YES:NO

#define IOSSystemVersion [[[UIDevice currentDevice] systemVersion] floatValue]

#endif /* TZConfig_h */
