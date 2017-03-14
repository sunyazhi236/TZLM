//
//  NSDictionary+Extension.h
//  JLYKitchen
//
//  Created by User on 15/11/23.
//  Copyright © 2015年 iOS.Team. All rights reserved.
//

#import "NSDictionary+Extension.h"

@implementation NSDictionary (Extension)

+ (id)resultWithResponseObj:(id)responseObj
{
    NSData *data = responseObj;
    
    NSMutableString *json = [[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding] mutableCopy];
//    去掉首尾空格和换行
    json = [[json stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] mutableCopy];
    
    NSRange range = {0,json.length};
    [json replaceOccurrencesOfString:@"\n" withString:@"\\n" options:NSLiteralSearch range:range];//转义换行
    NSRange range1 = {0, json.length};
    [json replaceOccurrencesOfString:@"\r" withString:@"\\r" options:NSLiteralSearch range:range1];//转义换行
    NSRange range2 = {0, json.length};
    [json replaceOccurrencesOfString:@"\t" withString:@" " options:NSLiteralSearch range:range2];//转义空格
    NSData *result = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSDictionary *response = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingAllowFragments error:&error];
    
    if (error) {
        NSLog(@"json解析---error----%@", error.description);
    }
    return response;
}

@end
