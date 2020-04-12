//
//  SecondTabACell.h
//  JKApp
//
//  Created by Apple on 2020/3/3.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SecondTabData;

@interface SecondTabACell : UITableViewCell

@property (weak, nonatomic) SecondTabData * cellData;

- (void)reloadCellScrollView;

@end

NS_ASSUME_NONNULL_END
