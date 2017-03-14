//
//  WMResponseData.m
//  JLYKitchen
//
//  Created by User on 15/11/23.
//  Copyright © 2015年 iOS.Team. All rights reserved.
//

#import "WMResponseData.h"

@interface WMResponseData()

@property (assign, nonatomic) BOOL isDecoder;

@end

@implementation WMResponseData
- (void)setJsonDictionary:(NSDictionary *)jsonDictionary
{
    _jsonDictionary = jsonDictionary;
    
    if (!self.isDecoder) {
        self.storageTime = [NSDate date];
    }
}
- (void)setTimeOutInterval:(NSTimeInterval)timeOutInterval
{
    _timeOutInterval = timeOutInterval;
    
    if (!self.isDecoder) {
        self.expiredTime = [NSDate dateWithTimeInterval:timeOutInterval sinceDate:self.storageTime];
        NSLog(@"%@", self.expiredTime);
    }
}
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.isDecoder = YES;
        self.jsonDictionary = [decoder decodeObjectForKey:@"jsonDictionary"];
        self.timeOutInterval = [decoder decodeFloatForKey:@"timeOutInterval"];
        self.storageTime = [decoder decodeObjectForKey:@"storageTime"];
        self.expiredTime = [decoder decodeObjectForKey:@"expiredTime"];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.jsonDictionary forKey:@"jsonDictionary"];
    [encoder encodeObject:self.storageTime forKey:@"storageTime"];
    [encoder encodeObject:self.expiredTime forKey:@"expiredTime"];
    [encoder encodeFloat:self.timeOutInterval forKey:@"timeOutInterval"];
}

@end
