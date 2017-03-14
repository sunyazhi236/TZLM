//
//  CityViewController.h
//  TZLM
//
//  Created by  sun on 2017/3/4.
//  Copyright © 2017年 上海询通商务咨询有限公司. All rights reserved.
//

#import "TZRootViewController.h"

@interface CityViewController : TZRootViewController

@property (nonatomic,strong) NSArray *cityArray;
@property (nonatomic,strong) NSString *cityStr;
+(CityViewController *)shareInstance;
@end
