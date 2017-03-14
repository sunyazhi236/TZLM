//
//  TZRootViewController.h
//  TZLM
//
//  Created by  sun on 2017/2/25.
//  Copyright © 2017年 上海询通商务咨询有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSAlertController.h"
#define ProgressColor VTColor(9,287,7)

@interface TZRootViewController : UIViewController

-(void)messageBar;


/**
 是否显示tabbar
 */
@property(nonatomic,assign) Boolean isShowTabbar;

/**
 需要登录的提示创窗口
 */
@property(nonatomic,strong) MSAlertController *actionSheet;

-(void)createNavBar;

/**
 显示没有数据页面
 */
-(void)showNoDataImage;

/**
 移除无数据页面
 */
-(void)removeNoDataImage;

/**
 需要登录
 */
-(void)showShouldLoginPoint;

/**
 加载视图
 */
//-(void)showLoadingAnimation;

/**
 停止加载
 */
//-(void)stopLoadingAnimation;


- (void)goLogin;

@end
