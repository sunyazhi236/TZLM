//
//  AppDelegate.h
//  TZLM
//
//  Created by  sun on 2017/2/24.
//  Copyright © 2017年 上海询通商务咨询有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(strong,nonatomic)UIViewController *viewController;


+(UINavigationController *)rootNavigationController;

@end

