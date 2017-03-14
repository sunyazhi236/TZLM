//
//  WMEncode.m
//  JLYKitchen
//
//  Created by User on 15/11/26.
//  Copyright © 2015年 iOS.Team. All rights reserved.
//

#import "WMEncode.h"

@implementation WMEncode
/*
 转换成UTF-8
 */
+ (NSString *)encodeUTF8:(NSString *)string {
    return [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

/*
 转换成GBK
 */
+ (NSString *)encodeGBK:(NSString *)string {
    NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    return [string stringByAddingPercentEscapesUsingEncoding:gbkEncoding];
}

/*
 URL
 */
+ (NSString *)encodeURL:(NSString *)string {
    CFStringRef ref = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)string, NULL, CFSTR("!*'();:@&=+$,/?%#[]"), kCFStringEncodingUTF8);
    NSString *strURL = [NSString stringWithFormat:@"%@",(__bridge NSString *)ref];
    CFRelease(ref);
    return strURL;
}

@end
