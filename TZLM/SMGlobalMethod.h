//
//  SMGlobalMethod.h
//  Smios
//
//  Created by hao on 15/11/27.
//  Copyright (c) 2015年 sanmi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SMGlobalMethod : NSObject
//date转时间yyyyMMdd
+(NSString *)getTimeFromTimeDaY:(NSDate *)date;
//时间戳转时间
+(NSString *)getTimeFromTimeSp:(NSString *)timeSp;
//时间戳转时间
+(NSString *)getTimeFromShortTimeSpY:(NSString *)shortTimeSp;
//13位的时间戳转换
+(NSString *)getTimeFrom13TimeSp:(NSString *)timeSp;
//时间戳转时间yyyy-MM-dd
+(NSString *)getTimeFromShortTimeSp:(NSString *)shortTimeSp;
//date转时间
+(NSString *)getTimeFromTimeDa:(NSDate *)date;
+(NSString *)getTimeFromShortTimeDa:(NSDate *)date;
//时间文本转dateShort
+(NSDate *)getTimeDateFromeShortTimeStryy:(NSString *)timeStr;
//将时间转为时间戳
//+ (NSString *)getTimetroWith:

//yyyy年MM月dd日 HH:mm
+ (NSString *)getTimeFromTimeSpToComFormat:(NSString *)timeSp;

//获取当前时间戳
+(NSString *)getTimeSp;
//时间文本转date
+(NSDate *)getTimeDateFromeTimeStr:(NSString *)timeStr;
+(NSDate *)getTimeDateFromeShortTimeStr:(NSString *)timeStr;
+(NSDate *)getTimeDateFromehmStr:(NSString *)timeStr;
//date转时间戳
+(NSString *)getTimeSpFromeTimeDate:(NSDate *)date;
//时间文本转date(YYYYMMddHHmm)
+ (NSDate *)getTimeDateFromeTimeStrWithYYY:(NSString *)timeStr;
//date转时间yyyyMMddHHmm
+(NSString *)getTimeFromTimeDaYY:(NSDate *)date;

//时间文本转为时间戳(YYYY-MM-dd)
+ (NSString *)getTimeSpWithTime:(NSString *)time;

//自动消失的提示框
+(void)showMessage:(NSString *)message;

#pragma mark-- 正则判断
//邮箱
+ (BOOL) validateEmail:(NSString *)email;
//手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile;
//电话号验证
+ (BOOL)validateIsMobileNumber:(NSString *)mobileNum;
//车牌号验证
+ (BOOL) validateCarNo:(NSString *)carNo;
//车型
+ (BOOL) validateCarType:(NSString *)CarType;
//用户名
+ (BOOL) validateUserName:(NSString *)name;
//密码
+ (BOOL) validatePassword:(NSString *)passWord;
//昵称
+ (BOOL) validateNickname:(NSString *)nickname;
//身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard;
//邮编
+ (BOOL) validatePostcode:(NSString *)nickname;
//检测是否含有特殊字符
+(BOOL)isIncludeSpecialCharact:(NSString *)str;

#pragma mark- 各类型数据转换
//字典转data
+(NSData*)returnDataWithDictionary:(NSDictionary*)dict;
//字典转json串
+(NSString*)returnDictionaryToJson:(NSDictionary *)dic;
//转换html标签
+(NSString *)filterHTML:(NSString *)str;

#pragma mark-- 清理缓存
//计算单个文件大小
+(float)fileSizeAtPath:(NSString *)path;
//计算目录大小
+(float)folderSizeAtPath:(NSString *)path;
//清理缓存
+(void)clearCache:(NSString *)path;

#pragma mark --label自适应
+(CGSize)textHeight:(NSString *)str font:(UIFont*)font size:(CGSize)size;
#pragma mark --图片处理
//color转image
+ (UIImage*) createImageWithColor: (UIColor*) color size:(CGSize)size;
#pragma mark 压缩图片
+(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;
#pragma mark --去除小数点后多余的0
+(NSString *)changeFloat:(NSString *)stringFloat;


@end
