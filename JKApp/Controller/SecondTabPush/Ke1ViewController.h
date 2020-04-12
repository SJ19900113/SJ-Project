//
//  Ke1ViewController.h
//  JKApp
//
//  Created by Apple on 2020/3/2.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SecondADViewController;

@interface Ke1ViewController : UIViewController

@property (nonatomic, strong) UINavigationController * navigationController;
@property (nonatomic, strong) SecondADViewController * secondADController;

- (void)showSecondADViewControllerWithADIndex:(NSInteger)index;
- (void)closeSecondADViewController;

@end

NS_ASSUME_NONNULL_END
