//
//  FirstTabForDCell.h
//  JKApp
//
//  Created by Apple on 2020/2/23.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstTabData.h"

NS_ASSUME_NONNULL_BEGIN

@interface FirstTabForDCell : UITableViewCell

@property (weak, nonatomic) FirstTabData * cellData;
- (void)updateCurrentSortMode;

@end

NS_ASSUME_NONNULL_END
