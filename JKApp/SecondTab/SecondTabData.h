//
//  SecondTabData.h
//  JKApp
//
//  Created by Apple on 2020/3/3.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, SecondTableCellType) {
    SecondTableCellType_A,
    SecondTableCellType_B,
    SecondTableCellType_C,
    SecondTableCellType_D,
    SecondTableCellType_E,
};

@interface SecondTabData : NSObject

@property (assign, nonatomic) SecondTableCellType cellType;

// a
@property (strong, nonatomic) NSArray * adImageNamesArray;
@property (assign, nonatomic) NSInteger selectedIndex;

@property (assign, nonatomic) float tableCell_Height;

@end

NS_ASSUME_NONNULL_END
