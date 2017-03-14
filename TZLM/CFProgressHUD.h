//
//  CFProgressHUD.h
//  CFProgressHUD
//
//  Created by 李旭日 on 15/7/27.
//  Copyright (c) 2015年 Lixuri. All rights reserved.
//

#import "MBProgressHUD.h"

@interface CFProgressHUD : MBProgressHUD

/**
 *  显示信息2秒后自动销毁
 *
 *  @param message 要现实的消息字符串
 *  @param view    显示在哪个View上为nil时在window上显示
 */
+ (void)showMessage:(NSString *)message view:(UIView *)view;

/**
 *  在window上显示信息2秒后自动销毁
 *
 *  @param message 要现实的消息字符串
 */
+ (void)showMessage:(NSString *)message;

/**
 *  显示载入动画
 *
 *  @param view 显示在哪个View上为nil时在window上显示
 */
+ (CFProgressHUD *)showLoadingWithView:(UIView *)view;

/**
 *  在window上显载入动画
 */
+ (CFProgressHUD *)showLoading;

/**
 *  隐藏相应View的HUD
 */
+ (void)hideHUDForView:(UIView *)view;

/**
 *  隐藏相应window上的HUD
 */
+ (void)hideHUD;

@end
