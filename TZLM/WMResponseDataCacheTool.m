//
//  WMResponseDataCacheTool.m
//  JLYKitchen
//
//  Created by User on 15/11/23.
//  Copyright © 2015年 iOS.Team. All rights reserved.
//

#import "WMResponseDataCacheTool.h"
#import "WMResponseData.h"
#import "CFMD5.h"

#define file_path [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.archive", [CFMD5 md5:fileName]]]

@implementation WMResponseDataCacheTool
+ (BOOL)saveResponseData:(WMResponseData *)responseData fileName:(NSString *)fileName
{
    return [NSKeyedArchiver archiveRootObject:responseData toFile:file_path];
}

+ (WMResponseData *)getResponseDataWithFileName:(NSString *)fileName
{
    WMResponseData *responseData = [NSKeyedUnarchiver unarchiveObjectWithFile:file_path];
    
    NSDate *expiredTime = responseData.expiredTime;
    
    NSDate *now = [NSDate date];
    
    if ([expiredTime compare:now] == NSOrderedDescending) {//降序(过期时间大于当前时间)
        return [NSKeyedUnarchiver unarchiveObjectWithFile:file_path];
    }else{//升序(已过期)
        return nil;
    }
}
+ (WMResponseData *)getPermanentResponseDataWithFileName:(NSString *)fileName
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:file_path];
}

@end
