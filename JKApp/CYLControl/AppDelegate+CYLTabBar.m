//
//  AppDelegate+CYLTabBar.m
//  JKApp
//
//  Created by Apple on 2020/2/17.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "AppDelegate+CYLTabBar.h"
#import "MainViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FouthViewController.h"
#import "CYLPlusButtonSubclass.h"

@interface AppDelegate () <CYLTabBarControllerDelegate,UITabBarControllerDelegate>

@end

@implementation AppDelegate (CYLTabBar)

- (void)sj_configureForTabBarController {
    // 设置主窗口，并设置根视图控制器
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    // 💡💡💡 注册加号按钮
    [CYLPlusButtonSubclass registerPlusButton];
    
    // 初始化 CYLTabBarController 对象
    CYLTabBarController *tabBarController =
    [CYLTabBarController tabBarControllerWithViewControllers:[self viewControllers]
                                       tabBarItemsAttributes:[self tabBarItemsAttributes]];
    // 设置遵守委托协议
    tabBarController.delegate = self;
    // 将 CYLTabBarController 设置为 window 的 RootViewController
    self.window.rootViewController = tabBarController;
    
    [self customizeTabBarInterface];
}

/// 控制器数组
- (NSArray *)viewControllers {
    // 首页
    MainViewController * homeVC = [[MainViewController alloc] init];
    homeVC.navigationItem.title = @"首页";
    CYLBaseNavigationController * homeNC = [[CYLBaseNavigationController alloc] initWithRootViewController:homeVC];
    [homeNC cyl_setHideNavigationBarSeparator:YES];
    homeNC.navigationBarHidden = YES;
    self.mainController = homeVC;
    
   // homeNC.tabBarItem.badgeValue = @"20";
    // 同城
    SecondViewController * myCityVC = [[SecondViewController alloc] init];
    myCityVC.navigationItem.title = @"同城";
    CYLBaseNavigationController *myCityNC = [[CYLBaseNavigationController alloc] initWithRootViewController:myCityVC];
    [myCityNC cyl_setHideNavigationBarSeparator:YES];
    myCityNC.navigationBarHidden = YES;
    self.secondController = myCityVC;
    
    // 消息
    ThirdViewController * messageVC = [[ThirdViewController alloc] init];
    messageVC.navigationItem.title = @"消息";
    CYLBaseNavigationController *messageNC = [[CYLBaseNavigationController alloc] initWithRootViewController:messageVC];
    [messageNC cyl_setHideNavigationBarSeparator:YES];
   // messageVC.tabBarItem.badgeValue = @"20";
    // 我的
    FouthViewController * accountVC = [[FouthViewController alloc] init];
    accountVC.navigationItem.title = @"我的";
    CYLBaseNavigationController *accountNC = [[CYLBaseNavigationController alloc] initWithRootViewController:accountVC];
    [accountNC cyl_setHideNavigationBarSeparator:YES];
    
    NSArray * viewControllersArray = @[homeNC, myCityNC, messageVC, accountVC];
    return viewControllersArray;
}

/// tabBar 属性数组
- (NSArray *)tabBarItemsAttributes {
    NSDictionary *homeTabBarItemsAttributes = @{
                                                CYLTabBarItemTitle: @"首页",
                                                CYLTabBarItemImage: @"home_normal",
                                                CYLTabBarItemSelectedImage: @"home_highlight",
                                                };
    NSDictionary *myCityTabBarItemsAttributes = @{
                                                  CYLTabBarItemTitle: @"同城",
                                                  CYLTabBarItemImage: @"fishpond_normal",
                                                  CYLTabBarItemSelectedImage: @"fishpond_highlight",
                                                  };
    NSDictionary *messageTabBarItemsAttributes = @{
                                                   CYLTabBarItemTitle: @"消息",
                                                   CYLTabBarItemImage: @"message_normal",
                                                   CYLTabBarItemSelectedImage: @"message_highlight",
                                                   };
    NSDictionary *accountTabBarItemsAttributes = @{
                                                   CYLTabBarItemTitle: @"我的",
                                                   CYLTabBarItemImage: @"account_normal",
                                                   CYLTabBarItemSelectedImage: @"account_highlight",
                                                   };
    
    NSArray *tabBarItemsAttributes = @[
                                       homeTabBarItemsAttributes,
                                       myCityTabBarItemsAttributes,
                                       messageTabBarItemsAttributes,
                                       accountTabBarItemsAttributes
                                       ];
    return tabBarItemsAttributes;
}



/// 自定义 TabBar 字体、背景、阴影
- (void)customizeTabBarInterface {
    // 设置文字属性
    if (@available(iOS 10.0, *)) {
        [self cyl_tabBarController].tabBar.unselectedItemTintColor = [UIColor cyl_systemGrayColor];
        [self cyl_tabBarController].tabBar.tintColor = [UIColor cyl_labelColor];
    } else {
        UITabBarItem *tabBar = [UITabBarItem appearance];
        // 普通状态下的文字属性
        [tabBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor cyl_systemGrayColor]}
                              forState:UIControlStateNormal];
        // 选中状态下的文字属性
        [tabBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor cyl_labelColor]}
                              forState:UIControlStateSelected];
    }
    
    // 设置 TabBar 背景颜色：白色
    // 💡[UIImage imageWithColor] 表示根据指定颜色生成图片，该方法来自 <YYKit> 框架
    [[UITabBar appearance] setBackgroundImage:[AppDelegate imageWithColor:[UIColor whiteColor]]];
    
    // 去除 TabBar 自带的顶部阴影
    [[self cyl_tabBarController] hideTabBarShadowImageView];
    
    // 设置 TabBar 阴影，无效
    // [[UITabBar appearance] setShadowImage:[UIImage imageNamed:@"tabBar_background_shadow"]];
    
    // 设置 TabBar 阴影
    CYLTabBarController *tabBarController = [self cyl_tabBarController];
    tabBarController.tabBar.layer.shadowColor = [UIColor blackColor].CGColor;
    tabBarController.tabBar.layer.shadowRadius = 15.0;
    tabBarController.tabBar.layer.shadowOpacity = 0.2;
    tabBarController.tabBar.layer.shadowOffset = CGSizeMake(0, 3);
    tabBarController.tabBar.layer.masksToBounds = NO;
    tabBarController.tabBar.clipsToBounds = NO;
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}



#pragma mark - delegate animation

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    // 确保 PlusButton 的选中状态
    [[self cyl_tabBarController] updateSelectionStatusIfNeededForTabBarController:tabBarController shouldSelectViewController:viewController];
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectControl:(UIControl *)control {
    UIView *animationView;
    NSLog(@"🔴\n 类名与方法名：%@，\n 第 %@ 行，\n description : %@，\n tabBarChildViewControllerIndex: %@， tabBarItemVisibleIndex : %@", @(__PRETTY_FUNCTION__), @(__LINE__), control, @(control.cyl_tabBarChildViewControllerIndex), @(control.cyl_tabBarItemVisibleIndex));
    
    // 即使 PlusButton 也添加了点击事件，点击 PlusButton 后也会触发该代理方法。
    if ([control cyl_isPlusButton]) {
        UIButton *button = CYLExternPlusButton;
        animationView = button.imageView;
        // 为加号按钮添加「缩放动画」
        [self addScaleAnimationOnView:animationView repeatCount:1];
    } else if ([control isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
        for (UIView *subView in control.subviews) {
            if ([subView isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
                animationView = subView;
                // 为其他按钮添加「旋转动画」
                [self addRotateAnimationOnView:animationView];
            }
        }
    }
}

/// 缩放动画
- (void)addScaleAnimationOnView:(UIView *)animationView repeatCount:(float)repeatCount {
    //需要实现的帧动画，这里根据需求自定义
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.scale";
    animation.values = @[@1.0,@1.3,@0.9,@1.15,@0.95,@1.02,@1.0];
    animation.duration = 0.5;
    animation.repeatCount = repeatCount;
    animation.calculationMode = kCAAnimationCubic;
    [animationView.layer addAnimation:animation forKey:nil];
}

/// 旋转动画
- (void)addRotateAnimationOnView:(UIView *)animationView {
    [UIView animateWithDuration:0.32 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        animationView.layer.transform = CATransform3DMakeRotation(M_PI, 0, 1, 0);
    } completion:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.70 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0.2 options:UIViewAnimationOptionCurveEaseOut animations:^{
            animationView.layer.transform = CATransform3DMakeRotation(2 * M_PI, 0, 1, 0);
        } completion:nil];
    });
}

@end
