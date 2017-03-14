//
//  SMGlobalDevices.h
//  XinPaiZuoWen
//
//  Created by mac_leo on 16/3/23.
//  Copyright © 2016年 三秒. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SMGlobalDevices : NSObject

//获取app名称
+(NSString *)getAppName;
//获取app版本号
+(NSString *)getAppVersion;
//获取appBuild版本
+(NSString *)getAppBuild;
//获取 手机别名： 用户定义的名称
+(NSString *)getUserPhoneName;
//设备名称
+(NSString *)getDeviceName;
//手机系统版本
+(NSString *)getPhoneVersion;
//手机型号
+(NSString *)getPhoneModel;
//地方型号  （国际化区域名称）
+(NSString *)getLocalPhoneModel;
#pragma mark --获取手机信息
//手机IP
+ (NSString *)deviceIPAdress;

//判断是否是ipad
+(BOOL)isIpad;
@end
