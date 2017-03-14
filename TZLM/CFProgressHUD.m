//
//  CFProgressHUD.m
//  CFProgressHUD
//
//  Created by 李旭日 on 15/7/27.
//  Copyright (c) 2015年 Lixuri. All rights reserved.
//

#import "CFProgressHUD.h"
#import "CFLoadingView.h"
#import "UIView+MJExtension.h"
#define message_font [UIFont systemFontOfSize:13]
@interface CFProgressHUD()

/**
 *  判断是否为CFLoadingView
 */
@property (nonatomic, assign) BOOL isLoadingView;

@end

@implementation CFProgressHUD
+ (void)showMessage:(NSString *)message view:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    
    CFProgressHUD *hud = [CFProgressHUD showHUDAddedTo:view animated:YES];
    
    hud.labelText = message;
    
    hud.labelFont = message_font;
    
    hud.mode = MBProgressHUDModeText;
    
    hud.yOffset = view.mj_height/3;
    
    hud.margin = 10;
    
    hud.removeFromSuperViewOnHide = YES;
    
    [hud hide:YES afterDelay:2];
}

+ (void)showMessage:(NSString *)message
{
    [self showMessage:message view:nil];
}
+ (CFProgressHUD *)showLoadingWithView:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    
    CFProgressHUD *hud = [CFProgressHUD showHUDAddedTo:view animated:YES];
    
    CFLoadingView *loadView = [CFLoadingView loadingView];
    
    loadView.mj_size = CGSizeMake(kAutoWEX(55), kAutoHEX(55));
    
    hud.customView = loadView;
    
    hud.isLoadingView = YES;
    
    hud.color = [UIColor clearColor];
    
    hud.square = YES;
    
    hud.mj_size = CGSizeMake(kAutoWEX(55), kAutoHEX(55));
    
    hud.mode = MBProgressHUDModeCustomView;
    
    hud.removeFromSuperViewOnHide = YES;
    
    return hud;
}
+ (CFProgressHUD *)showLoading
{
    return [self showLoadingWithView:nil];
}

+ (void)hideHUDForView:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    [self hideHUDForView:view animated:YES];
}

+ (void)hideHUD
{
    [self hideHUDForView:nil];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.isLoadingView) {
        UIView *parent = self.superview;
        self.center = parent.center;
        self.mj_size = CGSizeMake(0, 0);
    }
}

@end
