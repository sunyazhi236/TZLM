//
//  SMGlobalDevices.m
//  XinPaiZuoWen
//
//  Created by mac_leo on 16/3/23.
//  Copyright © 2016年 三秒. All rights reserved.
//

#import "SMGlobalDevices.h"
#import "SMGlobalMethod.h"
#import <ifaddrs.h>
#import <arpa/inet.h>

@implementation SMGlobalDevices

//获取app名称
+(NSString *)getAppName{
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    CFShow((__bridge CFTypeRef)(infoDictionary));
    // app名称
    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    
    return app_Name;
}

//获取app版本号
+(NSString *)getAppVersion{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    return app_Version;
}
//获取appBuild版本
+(NSString *)getAppBuild{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app build版本
    NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
    
    return app_build;
}
//获取 手机别名： 用户定义的名称
+(NSString *)getUserPhoneName{
    //手机别名： 用户定义的名称
    NSString* userPhoneName = [[UIDevice currentDevice] name];
    return userPhoneName;
}

//设备名称
+(NSString *)getDeviceName{

    //设备名称
    NSString* deviceName = [[UIDevice currentDevice] systemName];
    return deviceName;
    
}

//手机系统版本
+(NSString *)getPhoneVersion{
    //手机系统版本
    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
    return [SMGlobalMethod changeFloat:phoneVersion];
}

//手机型号
+(NSString *)getPhoneModel{
    //手机型号
    NSString* phoneModel = [[UIDevice currentDevice] model];
    return phoneModel;
    
}
//地方型号  （国际化区域名称）
+(NSString *)getLocalPhoneModel{
    //地方型号  （国际化区域名称）
    NSString* localPhoneModel = [[UIDevice currentDevice] localizedModel];
    return localPhoneModel;
}

#pragma mark --获取手机信息
//手机IP
+ (NSString *)deviceIPAdress {
    NSString *address = @"错误的IP地址";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    success = getifaddrs(&interfaces);
    
    if (success == 0) { // 0 表示获取成功
        
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            if( temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    freeifaddrs(interfaces);
//    
//    NSLog(@"手机的IP是：%@", address);
    return address;
}

//判断是否是ipad
+(BOOL)isIpad{
    #ifdef UI_USER_INTERFACE_IDIOM
        return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
    #else
        return NO;
    #endif
}

@end
