//
//  WMResponseData.h
//  JLYKitchen
//
//  Created by User on 15/11/23.
//  Copyright © 2015年 iOS.Team. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WMResponseData : NSObject<NSCoding>
/**
 *  请求响应数据
 */
@property (nonatomic, strong) NSDictionary *jsonDictionary;

/**
 *  存储时间
 */
@property (nonatomic, strong) NSDate *storageTime;

/**
 *  过期时间
 */
@property (nonatomic, strong) NSDate *expiredTime;

/**
 *  超时
 */
@property (nonatomic, assign) NSTimeInterval timeOutInterval;

@end
