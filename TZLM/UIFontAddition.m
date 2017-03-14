//
//  UIFontAddition.m
//  PRODUCT
//
//  Created by gaozeng on 15/6/16.
//  Copyright (c) 2015年 gaozeng. All rights reserved.
//

#import "UIFontAddition.h"
@implementation UIFont(Addition)
+ (UIFont *)systemFontOfSize_5:(CGFloat)size
{
    UIFont *font = nil;
    
    CGFloat scale = kSCREEN_WIDTH_RATIO;
    if (scale > 1.2) {
        scale = 1.15f;
    }
    else scale = 1.0f;
    
    font = [UIFont systemFontOfSize:size*scale];

    return font;
}
@end
