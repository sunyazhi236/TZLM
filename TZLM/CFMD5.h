//
//  CFMD5.h
//  CFNet
//
//  Created by 李旭日 on 15/7/23.
//  Copyright (c) 2015年 Lixuri. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CFMD5 : NSObject

+ (NSString *)md5:(NSString *)str;
+ (NSString *)md5WithString:(NSString *)string;

@end
