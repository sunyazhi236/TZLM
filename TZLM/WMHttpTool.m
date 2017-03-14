//
//  WMHttpTool.m
//  JLYKitchen
//
//  Created by User on 15/11/23.
//  Copyright © 2015年 iOS.Team. All rights reserved.
//

#import "WMHttpTool.h"
#import "WMResponseData.h"
#import "WMResponseDataCacheTool.h"
#import "NSDictionary+Extension.h"
//#import "NSString+Custom.h"
//#import "WMUser.h"

#define fiveMinutes (5 * 60)
//#define PRODUCTMODE 1
@implementation WMHttpTool
+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 1.获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];//使用这个将得到的是NSData
    [mgr.requestSerializer setValue:@"850226" forHTTPHeaderField:@"Appkey"];
    [mgr.requestSerializer setValue:@"ios" forHTTPHeaderField:@"Os"];
    [mgr.requestSerializer setValue:[[UIDevice currentDevice] systemVersion] forHTTPHeaderField:@"Osversion"];
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    [mgr.requestSerializer setValue:[info objectForKey:@"CFBundleShortVersionString"] forHTTPHeaderField:@"Appversion"];
//    [mgr.requestSerializer setValue:[NSString customUUID] forHTTPHeaderField:@"Unique"];
//    if ([[WMUser sharedInstance] isLogin]) {
//        WMUser *user = [WMUser sharedInstance];
//        [mgr.requestSerializer setValue:user.userID forHTTPHeaderField:@"Userid"];
//        [mgr.requestSerializer setValue:user.session forHTTPHeaderField:@"Usersession"];
//    }
#ifdef PRODUCTMODE
    [mgr.requestSerializer setValue:@"online" forHTTPHeaderField:@"servername"];
#else
    [mgr.requestSerializer setValue:@"ftest" forHTTPHeaderField:@"servername"];
#endif
    
    mgr.requestSerializer.timeoutInterval = 5;
    NSString *fileName = url;
    
    // 2.发送GET请求
    [mgr GET:url parameters:params
     success:^(AFHTTPRequestOperation *operation, id responseObj) {
         
         if (success) {
             NSDictionary *result = [NSDictionary resultWithResponseObj:responseObj];
             [self saveResult:result timeOut:0 fileName:fileName];
             success(result);
         }
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         NSDictionary *permanentResult = [self permanentResultWithFileName:fileName];
         
         if (permanentResult) {
             
             if (success) {
                 success(permanentResult);
             }
         }else if (failure) {
             failure(error);
         }
     }];
}

+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 1.获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];//使用这个将得到的是NSData
    //    mgr.responseSerializer = [AFJSONResponseSerializer serializer];//使用这个将得到的是JSON
//    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    [mgr.requestSerializer setValue:@"850226" forHTTPHeaderField:@"Appkey"];
    [mgr.requestSerializer setValue:@"ios" forHTTPHeaderField:@"Os"];
    [mgr.requestSerializer setValue:[[UIDevice currentDevice] systemVersion] forHTTPHeaderField:@"Osversion"];
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    [mgr.requestSerializer setValue:[info objectForKey:@"CFBundleShortVersionString"] forHTTPHeaderField:@"Appversion"];
//    [mgr.requestSerializer setValue:[NSString customUUID] forHTTPHeaderField:@"Unique"];
//    if ([[WMUser sharedInstance] isLogin]) {
//        WMUser *user = [WMUser sharedInstance];
//        [mgr.requestSerializer setValue:user.userID forHTTPHeaderField:@"Userid"];
//        [mgr.requestSerializer setValue:user.session forHTTPHeaderField:@"Usersession"];
//    }
#ifdef PRODUCTMODE
    [mgr.requestSerializer setValue:@"online" forHTTPHeaderField:@"servername"];
#else
    [mgr.requestSerializer setValue:@"ftest" forHTTPHeaderField:@"servername"];
#endif
    
    mgr.requestSerializer.timeoutInterval = 5;
    NSString *fileName = [self fileNameWithUrl:url params:params];
    
    // 2.发送POST请求
    [mgr POST:url parameters:params
      success:^(AFHTTPRequestOperation *operation, id responseObj) {
          if (success) {
              NSDictionary *result = [NSDictionary resultWithResponseObj:responseObj];
              [self saveResult:result timeOut:0 fileName:fileName];
              success(result);
          }
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          
          NSDictionary *permanentResult = [self permanentResultWithFileName:fileName];
          
          if (permanentResult) {
              if (success) {
                  success(permanentResult);
              }
          }else if (failure) {
              failure(error);
          }
      }];
}

+ (void)noCacheGet:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure
{
    // 1.获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];//使用这个将得到的是NSData
    [mgr.requestSerializer setValue:@"850226" forHTTPHeaderField:@"Appkey"];
    [mgr.requestSerializer setValue:@"ios" forHTTPHeaderField:@"Os"];
    [mgr.requestSerializer setValue:[[UIDevice currentDevice] systemVersion] forHTTPHeaderField:@"Osversion"];
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    [mgr.requestSerializer setValue:[info objectForKey:@"CFBundleShortVersionString"] forHTTPHeaderField:@"Appversion"];
//    [mgr.requestSerializer setValue:[NSString customUUID] forHTTPHeaderField:@"Unique"];
//    if ([[WMUser sharedInstance] isLogin]) {
//        WMUser *user = [WMUser sharedInstance];
//        [mgr.requestSerializer setValue:user.userID forHTTPHeaderField:@"Userid"];
//        [mgr.requestSerializer setValue:user.session forHTTPHeaderField:@"Usersession"];
//    }
#ifdef PRODUCTMODE
    [mgr.requestSerializer setValue:@"online" forHTTPHeaderField:@"servername"];
#else
    [mgr.requestSerializer setValue:@"ftest" forHTTPHeaderField:@"servername"];
#endif
    mgr.requestSerializer.timeoutInterval = 5;
    
    // 2.发送GET请求
    [mgr GET:url parameters:params
     success:^(AFHTTPRequestOperation *operation, id responseObj) {
         if (success) {
             NSDictionary *result = [NSDictionary resultWithResponseObj:responseObj];
             success(result);
         }
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         if (failure) {
             failure(error);
             [CFProgressHUD showMessage:@"网络异常"];
         }
     }];
}
+ (void)noCachePost:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure
{
    // 1.获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    [mgr.requestSerializer setValue:@"850226" forHTTPHeaderField:@"Appkey"];
    [mgr.requestSerializer setValue:@"ios" forHTTPHeaderField:@"Os"];
    [mgr.requestSerializer setValue:[[UIDevice currentDevice] systemVersion] forHTTPHeaderField:@"Osversion"];
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    [mgr.requestSerializer setValue:[info objectForKey:@"CFBundleShortVersionString"] forHTTPHeaderField:@"Appversion"];
//    [mgr.requestSerializer setValue:[NSString customUUID] forHTTPHeaderField:@"Unique"];
//    if ([[WMUser sharedInstance] isLogin]) {
//        WMUser *user = [WMUser sharedInstance];
//        [mgr.requestSerializer setValue:user.userID forHTTPHeaderField:@"Userid"];
//        [mgr.requestSerializer setValue:user.session forHTTPHeaderField:@"Usersession"];
//    }
#ifdef PRODUCTMODE
    [mgr.requestSerializer setValue:@"online" forHTTPHeaderField:@"servername"];
#else
    [mgr.requestSerializer setValue:@"ftest" forHTTPHeaderField:@"servername"];
#endif
    mgr.requestSerializer.timeoutInterval = 5;
    
    // 2.发送POST请求
    [mgr POST:url parameters:params
      success:^(AFHTTPRequestOperation *operation, id responseObj) {
          if (success) {
              NSDictionary *result = [NSDictionary resultWithResponseObj:responseObj];
              success(result);
          }
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          if (failure) {
              failure(error);
              [CFProgressHUD showMessage:@"网络异常"];
          }
      }];
}

+ (void)cacheGet:(NSString *)url cacheTimeInterval:(NSTimeInterval)cacheTimeInterval params:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure
{
    NSString *fileName = [self fileNameWithUrl:url params:params];
    
    NSDictionary *cacheResult = [self resultWithFileName:fileName];
    
    if (cacheResult) {//如果有缓存数据则直接返回缓存数据
        if (success) {
            success(cacheResult);
        }
    }else{
        // 获得请求管理者
        AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
        mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
        [mgr.requestSerializer setValue:@"850226" forHTTPHeaderField:@"Appkey"];
        [mgr.requestSerializer setValue:@"ios" forHTTPHeaderField:@"Os"];
        [mgr.requestSerializer setValue:[[UIDevice currentDevice] systemVersion] forHTTPHeaderField:@"Osversion"];
        NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
        [mgr.requestSerializer setValue:[info objectForKey:@"CFBundleShortVersionString"] forHTTPHeaderField:@"Appversion"];
//        [mgr.requestSerializer setValue:[NSString customUUID] forHTTPHeaderField:@"Unique"];
//        if ([[WMUser sharedInstance] isLogin]) {
//            WMUser *user = [WMUser sharedInstance];
//            [mgr.requestSerializer setValue:user.userID forHTTPHeaderField:@"Userid"];
//            [mgr.requestSerializer setValue:user.session forHTTPHeaderField:@"Usersession"];
//        }
#ifdef PRODUCTMODE
        [mgr.requestSerializer setValue:@"online" forHTTPHeaderField:@"servername"];
#else
        [mgr.requestSerializer setValue:@"ftest" forHTTPHeaderField:@"servername"];
#endif
        mgr.requestSerializer.timeoutInterval = 5;
        
        // 发送POST请求
        [mgr GET:url parameters:params
         success:^(AFHTTPRequestOperation *operation, id responseObj) {
             if (success) {
                 NSDictionary *result = [NSDictionary resultWithResponseObj:responseObj];
                 [self saveResult:result timeOut:cacheTimeInterval fileName:fileName];
                 success(result);
             }
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             
             NSDictionary *permanentResult = [self permanentResultWithFileName:fileName];
             if(permanentResult){
                 if (success) {
                     success(permanentResult);
                 }
             }else if(failure) {
                 failure(error);
             }
         }];
    }
}
+ (void)fiveMinutesCacheGet:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure
{
    [self cacheGet:url cacheTimeInterval:fiveMinutes params:params success:success failure:failure];
}
+ (void)fiveMinutesCachePost:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure
{
    [self cachePost:url cacheTimeInterval:fiveMinutes params:params success:success failure:failure];
}
+ (void)cachePost:(NSString *)url cacheTimeInterval:(NSTimeInterval)cacheTimeInterval params:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure
{
    NSString *fileName = [self fileNameWithUrl:url params:params];
    NSDictionary *cacheResult = [self resultWithFileName:fileName];
    if (cacheResult) {//如果有缓存数据则直接返回缓存数据
        if (success) {
            success(cacheResult);
        }
    }else{
        // 获得请求管理者
        AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
        mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
        [mgr.requestSerializer setValue:@"850226" forHTTPHeaderField:@"Appkey"];
        [mgr.requestSerializer setValue:@"ios" forHTTPHeaderField:@"Os"];
        [mgr.requestSerializer setValue:[[UIDevice currentDevice] systemVersion] forHTTPHeaderField:@"Osversion"];
        NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
        [mgr.requestSerializer setValue:[info objectForKey:@"CFBundleShortVersionString"] forHTTPHeaderField:@"Appversion"];
//        [mgr.requestSerializer setValue:[NSString customUUID] forHTTPHeaderField:@"Unique"];
//        if ([[WMUser sharedInstance] isLogin]) {
//            WMUser *user = [WMUser sharedInstance];
//            [mgr.requestSerializer setValue:user.userID forHTTPHeaderField:@"Userid"];
//            [mgr.requestSerializer setValue:user.session forHTTPHeaderField:@"Usersession"];
//        }
#ifdef PRODUCTMODE
        [mgr.requestSerializer setValue:@"online" forHTTPHeaderField:@"servername"];
#else
        [mgr.requestSerializer setValue:@"ftest" forHTTPHeaderField:@"servername"];
#endif
        mgr.requestSerializer.timeoutInterval = 5;
        
        // 发送POST请求
        [mgr POST:url parameters:params
          success:^(AFHTTPRequestOperation *operation, id responseObj) {
              if (success) {
                  NSDictionary *result = [NSDictionary resultWithResponseObj:responseObj];
                  [self saveResult:result timeOut:cacheTimeInterval fileName:fileName];
                  success(result);
              }
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              
              NSDictionary *permanentResult = [self permanentResultWithFileName:fileName];
              if(permanentResult){//如果有用就行数据先显示永久性数据
                  if (success) {
                      success(permanentResult);
                  }
              }else if(failure) {
                  failure(error);
              }
          }];
    }
}
//带有永久性缓存的get请求
+ (void)permanentCacheGet:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure
{
    NSString *fileName = [self fileNameWithUrl:url params:params];
    
    NSDictionary *cacheResult = [self permanentResultWithFileName:fileName];
    
    if (cacheResult) {//如果有缓存数据则直接返回缓存数据
        if (success) {
            success(cacheResult);
        }
    }else{
        // 获得请求管理者
        AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
        mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
        [mgr.requestSerializer setValue:@"850226" forHTTPHeaderField:@"Appkey"];
        [mgr.requestSerializer setValue:@"ios" forHTTPHeaderField:@"Os"];
        [mgr.requestSerializer setValue:[[UIDevice currentDevice] systemVersion] forHTTPHeaderField:@"Osversion"];
        NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
        [mgr.requestSerializer setValue:[info objectForKey:@"CFBundleShortVersionString"] forHTTPHeaderField:@"Appversion"];
//        [mgr.requestSerializer setValue:[NSString customUUID] forHTTPHeaderField:@"Unique"];
//        if ([[WMUser sharedInstance] isLogin]) {
//            WMUser *user = [WMUser sharedInstance];
//            [mgr.requestSerializer setValue:user.userID forHTTPHeaderField:@"Userid"];
//            [mgr.requestSerializer setValue:user.session forHTTPHeaderField:@"Usersession"];
//        }
#ifdef PRODUCTMODE
        [mgr.requestSerializer setValue:@"online" forHTTPHeaderField:@"servername"];
#else
        [mgr.requestSerializer setValue:@"ftest" forHTTPHeaderField:@"servername"];
#endif
        mgr.requestSerializer.timeoutInterval = 5;
        
        // 发送POST请求
        [mgr GET:url parameters:params
         success:^(AFHTTPRequestOperation *operation, id responseObj) {
             if (success) {
                 NSDictionary *result = [NSDictionary resultWithResponseObj:responseObj];
                 [self saveResult:result timeOut:0 fileName:fileName];
                 success(result);
             }
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             
             if(failure) {
                 failure(error);
             }
         }];
    }
}
//带有永久性缓存的post请求
+ (void)permanentCachePost:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure
{
    NSString *fileName = [self fileNameWithUrl:url params:params];
    
    NSDictionary *cacheResult = [self permanentResultWithFileName:fileName];
    
    if (cacheResult) {//如果有缓存数据则直接返回缓存数据
        if (success) {
            success(cacheResult);
        }
    }else{
        // 获得请求管理者
        AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
        mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
        [mgr.requestSerializer setValue:@"850226" forHTTPHeaderField:@"Appkey"];
        [mgr.requestSerializer setValue:@"ios" forHTTPHeaderField:@"Os"];
        [mgr.requestSerializer setValue:[[UIDevice currentDevice] systemVersion] forHTTPHeaderField:@"Osversion"];
        NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
        [mgr.requestSerializer setValue:[info objectForKey:@"CFBundleShortVersionString"] forHTTPHeaderField:@"Appversion"];
//        [mgr.requestSerializer setValue:[NSString customUUID] forHTTPHeaderField:@"Unique"];
//        if ([[WMUser sharedInstance] isLogin]) {
//            WMUser *user = [WMUser sharedInstance];
//            [mgr.requestSerializer setValue:user.userID forHTTPHeaderField:@"Userid"];
//            [mgr.requestSerializer setValue:user.session forHTTPHeaderField:@"Usersession"];
//        }
#ifdef PRODUCTMODE
        [mgr.requestSerializer setValue:@"online" forHTTPHeaderField:@"servername"];
#else
        [mgr.requestSerializer setValue:@"ftest" forHTTPHeaderField:@"servername"];
#endif
        mgr.requestSerializer.timeoutInterval = 5;
        
        // 发送POST请求
        [mgr POST:url parameters:params
          success:^(AFHTTPRequestOperation *operation, id responseObj) {
              if (success) {
                  NSDictionary *result = [NSDictionary resultWithResponseObj:responseObj];
                  [self saveResult:result timeOut:0 fileName:fileName];
                  success(result);
              }
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              
              if(failure) {
                  failure(error);
              }
          }];
    }
}
//获取有时效性的数据
+ (NSDictionary *)resultWithFileName:(NSString *)fileName
{
    WMResponseData *responseData = [WMResponseDataCacheTool getResponseDataWithFileName:fileName];
    NSLog(@"过期时间%@", responseData.expiredTime);
    return responseData.jsonDictionary;
}
//获取永久性的数据
+ (NSDictionary *)permanentResultWithFileName:(NSString *)fileName
{
    WMResponseData *responseData = [WMResponseDataCacheTool getPermanentResponseDataWithFileName:fileName];
    return responseData.jsonDictionary;
}
+ (void)saveResult:(NSDictionary *)result timeOut:(NSTimeInterval)timeOut fileName:(NSString *)fileName
{
    WMResponseData *responseData = [[WMResponseData alloc] init];
    responseData.jsonDictionary = result;
    responseData.timeOutInterval = timeOut;
    [WMResponseDataCacheTool saveResponseData:responseData fileName:fileName];
}
+ (NSString *)fileNameWithUrl:(NSString *)url params:(NSDictionary *)params
{
    if (params) {
        NSData *paramsData = [NSJSONSerialization dataWithJSONObject:params options:NSJSONWritingPrettyPrinted error:nil];
        NSString *paramsJson = [[NSString alloc] initWithData:paramsData encoding:NSUTF8StringEncoding];
        return [url stringByAppendingString:paramsJson];
    }else{
        return url;
    }
}

@end
