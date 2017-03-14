//
//  NSDictionary+Extension.h
//  JLYKitchen
//
//  Created by User on 15/11/23.
//  Copyright © 2015年 iOS.Team. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Extension)

/**
 *  用于将网络请求返回带有换行空格的json数据转换为字典
 *
 *  @param responseObj 相应参数
 *
 *  @return 转换结果
 */
//+ (NSDictionary *)resultWithResponseObj:(id)responseObj;
+ (id)resultWithResponseObj:(id)responseObj;
@end
