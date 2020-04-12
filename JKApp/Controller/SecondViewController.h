//
//  SecondViewController.h
//  JKApp
//
//  Created by Apple on 2020/2/6.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class Ke1ViewController;

@interface SecondViewController : UIViewController

// 选中哪个tab
@property (nonatomic , assign) NSInteger currentSelectedIndex;
- (NSArray *)tableSourceArray;

- (Ke1ViewController *)ke1VC;


- (void)showAlertWithMessage:(NSString *)titleString;

@end

NS_ASSUME_NONNULL_END
