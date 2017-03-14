//
//  AppDelegate+RootController.h
//  TZLM
//
//  Created by  sun on 2017/2/25.
//  Copyright © 2017年 上海询通商务咨询有限公司. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (RootController)

/**
 首页启动轮播图
 */
-(void)createloadingScrollView;

/**
 tabbar实例
 */
-(void)setTabbarController;


/**
 window实例
 */
-(void)setAppWindows;

/**
 根视图
 */
-(void)setRootViewController;
@end
