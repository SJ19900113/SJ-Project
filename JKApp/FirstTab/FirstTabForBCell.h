//
//  FirstTabForBCell.h
//  JKApp
//
//  Created by Apple on 2020/2/20.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstTabData.h"

NS_ASSUME_NONNULL_BEGIN

@interface FirstTabForBCell : UITableViewCell

@property (weak, nonatomic) FirstTabData * cellData;
- (void)updateCustomerCount;

@end

NS_ASSUME_NONNULL_END
