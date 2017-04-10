//
//  FinancialListHeaderView.h
//  TZLM
//
//  Created by  sun on 2017/4/6.
//  Copyright © 2017年 上海询通商务咨询有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FinancialListHeaderView : UIView
@property(nonatomic,strong) UIButton *typeBtn;//贷款类型
@property(nonatomic,strong) UIButton *limitBtn;//贷款额度
@property(nonatomic,strong) UIButton *creditBtn;//征信要求
@property(nonatomic,strong) UIButton *userBtn;//针对用户

@property(nonatomic,strong) UIView *botView;

@property(nonatomic,strong) UIButton *provinceBtn;// 省份


@property(nonatomic,copy) void(^typeBlock)();
@property(nonatomic,copy) void(^limitBlock)();
@property(nonatomic,copy) void(^creditBlock)();
@property(nonatomic,copy) void(^userBlock)();

@property(nonatomic,copy) void(^provinceBlock)();

-(void)setView;
-(void)setProvinceView;

@end
