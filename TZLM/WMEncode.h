//
//  WMEncode.h
//  JLYKitchen
//
//  Created by User on 15/11/26.
//  Copyright © 2015年 iOS.Team. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WMEncode : NSObject
/*
 转换成UTF-8
 */
+ (NSString *)encodeUTF8:(NSString *)string;

/*
 转换成GBK
 */
+ (NSString *)encodeGBK:(NSString *)string;

/*
 URL
 */
+ (NSString *)encodeURL:(NSString *)string;

@end
