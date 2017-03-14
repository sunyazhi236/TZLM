//
//  WMHttpTool.h
//  JLYKitchen
//
//  Created by User on 15/11/23.
//  Copyright © 2015年 iOS.Team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface WMHttpTool : NSObject
/**
 *  发送一个自动缓存的GET请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;

/**
 *  发送一个自动缓存的POST请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;

/**
 *  发送一个GET请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)noCacheGet:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;

/**
 *  发送一个POST请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)noCachePost:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;

/**
 *  发送一个有时效性的get请求
 *
 *  @param url               请求路径
 *  @param cacheTimeInterval 超时时间
 *  @param params            请求参数
 *  @param success           请求成功后的回调
 *  @param failure           请求失败后的回调
 */
+ (void)cacheGet:(NSString *)url cacheTimeInterval:(NSTimeInterval)cacheTimeInterval params:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;

/**
 *  发送一个有时效性的post请求
 *
 *  @param url               请求路径
 *  @param cacheTimeInterval 超时时间
 *  @param params            请求参数
 *  @param success           请求成功后的回调
 *  @param failure           请求失败后的回调
 */
+ (void)cachePost:(NSString *)url cacheTimeInterval:(NSTimeInterval)cacheTimeInterval params:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;

/**
 *  发送一个有永久性的get请求
 *
 *  @param url               请求路径
 *  @param params            请求参数
 *  @param success           请求成功后的回调
 *  @param failure           请求失败后的回调
 */
+ (void)permanentCacheGet:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;
/**
 *  发送一个有永久性的post请求
 *
 *  @param url               请求路径
 *  @param params            请求参数
 *  @param success           请求成功后的回调
 *  @param failure           请求失败后的回调
 */
+ (void)permanentCachePost:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;

/**
 *  5分钟缓存get请求
 */
+ (void)fiveMinutesCacheGet:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;
/**
 *  5分钟缓存post请求
 */
+ (void)fiveMinutesCachePost:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;
@end
