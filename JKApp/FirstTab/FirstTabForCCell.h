//
//  FirstTabForCCell.h
//  JKApp
//
//  Created by Apple on 2020/2/21.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstTabData.h"

NS_ASSUME_NONNULL_BEGIN

@interface FirstTabForCCell : UITableViewCell

@property (weak, nonatomic) FirstTabData * cellData;
- (void)updateSchoolADShow;

@end

NS_ASSUME_NONNULL_END
