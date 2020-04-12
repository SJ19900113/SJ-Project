//
//  FirstTabData.h
//  JKApp
//
//  Created by Apple on 2020/2/18.
//  Copyright © 2020 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSUInteger, FirstTableCellType) {
    FirstTableCellType_A,
    FirstTableCellType_B,
    FirstTableCellType_C,
    FirstTableCellType_D,
    FirstTableCellType_E,
};

@interface FirstTabData : NSObject

@property (assign, nonatomic) FirstTableCellType cellType;

@property (assign, nonatomic) float tableCell_Height;

// a dic  {Image:  Title:}
@property (strong, nonatomic) NSArray * itemsForA;

// b
@property (assign, nonatomic) NSInteger customerCount;

// c dic (SchoolName: ADInfo:)
@property (strong, nonatomic) NSArray * adsArray;

// d 排序方式
@property (assign, nonatomic) NSInteger sortMode;

// e dic {}
// SchoolImageName
// TagImageName  品牌，热门
// SchoolName
// HasV     有vip
// HasM     有王冠
// Score    4.7
// Honour   综合排名第1名
// Price    5880
// Type     C1
// Sclass   速成班
// Location 松江区
// Distance 574 (km)
// Comment  规模大 有接送 约课方便 自有考场        <=4个
// Discount 300
// TryLearn 1  (hour)
@property (strong, nonatomic) NSDictionary * schoolDic;

@end

NS_ASSUME_NONNULL_END
