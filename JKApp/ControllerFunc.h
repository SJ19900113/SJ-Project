//
//  ControllerFunc.h
//  JKApp
//
//  Created by Apple on 2020/2/20.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class AppDelegate;
@class MainViewController;
@class SecondViewController;
@class Ke1ViewController;

@interface ControllerFunc : NSObject

+ (AppDelegate *)appDelegate;
+ (MainViewController *)mainController;
+ (SecondViewController *)secondController;
+ (Ke1ViewController *)secondK1Controller;
@end


@interface NSSortDescriptor (JKHelper)

+ (NSArray *)sortDescriptorsWithKeys:(NSArray *)key;
+ (NSArray *)sortDescriptorsDescendingWithKeys:(NSArray *)keys;

@end

NS_ASSUME_NONNULL_END
