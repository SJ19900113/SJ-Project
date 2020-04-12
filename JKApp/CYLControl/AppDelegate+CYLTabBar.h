//
//  AppDelegate+CYLTabBar.h
//  JKApp
//
//  Created by Apple on 2020/2/17.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "AppDelegate.h"
#import <CYLTabBarController/CYLTabBarController.h>

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (CYLTabBar)


@property (strong, nonatomic) UIWindow *window;

/// 配置主窗口
- (void)sj_configureForTabBarController;


@end

NS_ASSUME_NONNULL_END
