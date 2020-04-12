//
//  MainViewController.h
//  JKApp
//
//  Created by Apple on 2020/2/6.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ChooseSchoolViewController;

@interface MainViewController : UIViewController

@property (strong, nonatomic) ChooseSchoolViewController * chooseSchoolController;

- (void)showChooseSchoolViewController;
- (void)closeChooseSchoolViewController;

- (void)reloadTableViewWhenSortChanged;

@end

NS_ASSUME_NONNULL_END
