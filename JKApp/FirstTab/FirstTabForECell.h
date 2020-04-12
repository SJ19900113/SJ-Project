//
//  FirstTabForECell.h
//  JKApp
//
//  Created by Apple on 2020/2/25.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstTabData.h"

NS_ASSUME_NONNULL_BEGIN

@interface FirstTabForECell : UITableViewCell

@property (weak, nonatomic) FirstTabData * cellData;
- (void)loadSchoolInfoOnCell;

@end

NS_ASSUME_NONNULL_END
