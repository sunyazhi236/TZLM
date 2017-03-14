//
//  ProvinceViewController.h
//  TZLM
//
//  Created by  sun on 2017/3/4.
//  Copyright © 2017年 上海询通商务咨询有限公司. All rights reserved.
//

#import "TZRootViewController.h"

@interface ProvinceViewController : TZRootViewController

@property(nonatomic,strong) NSArray *provinceArr;//所有省名数组
@property(nonatomic,strong) NSDictionary *provinceDict; //省份字典
@property(nonatomic,strong) NSArray *cityArr; //单个省份 城市名数组


@end
