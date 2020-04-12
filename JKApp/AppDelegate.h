//
//  AppDelegate.h
//  JKApp
//
//  Created by Apple on 2020/2/6.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainViewController;
@class SecondViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow * window;

@property (strong, nonatomic) MainViewController * mainController;
@property (strong, nonatomic) SecondViewController * secondController;

@end

