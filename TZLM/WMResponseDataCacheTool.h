//
//  WMResponseDataCacheTool.h
//  JLYKitchen
//
//  Created by User on 15/11/23.
//  Copyright © 2015年 iOS.Team. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WMResponseData;

@interface WMResponseDataCacheTool : NSObject

/**
 *　存入数据
 */
+ (BOOL)saveResponseData:(WMResponseData *)responseData fileName:(NSString *)fileName;
/**
 *  获取有有效期的数据
 */
+ (WMResponseData *)getResponseDataWithFileName:(NSString *)fileName;

/**
 *  获取永久性数据
 */
+ (WMResponseData *)getPermanentResponseDataWithFileName:(NSString *)fileName;


@end
