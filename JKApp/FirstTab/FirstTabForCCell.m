//
//  FirstTabForCCell.m
//  JKApp
//
//  Created by Apple on 2020/2/21.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "FirstTabForCCell.h"

@interface FirstTabForCCell ()

@property (weak, nonatomic) IBOutlet UILabel *schoolNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *schoolADInfo;

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIView *firstADView;
@property (weak, nonatomic) IBOutlet UILabel *firstLabel1;
@property (weak, nonatomic) IBOutlet UILabel *firstLabel2;

@property (weak, nonatomic) IBOutlet UIView *secondADView;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel1;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel2;

@property (assign, nonatomic) NSInteger currentShowIndex;

@property (strong, nonatomic) NSRecursiveLock * adLock;

@end

@implementation FirstTabForCCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _adLock = [NSRecursiveLock new];
    
    self.currentShowIndex = 0;
    
    [_containerView addSubview:_firstADView];
    [_containerView addSubview:_secondADView];
    
    [_firstLabel1 sizeToFit];
    [_secondLabel1 sizeToFit];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)addViewOnContainer {

    CGRect frame = _containerView.bounds;
    _firstADView.frame = frame;
    
    CGRect secondFrame = frame;
    secondFrame.origin.y += frame.size.height;
    _secondADView.frame = secondFrame;

    // 更新
    _currentShowIndex %= self.cellData.adsArray.count;
    
    NSInteger current = _currentShowIndex;
    // 显示view
    NSDictionary * dic = self.cellData.adsArray[current];
    if (dic) {
        _firstLabel1.text = dic[@"SchoolName"];
        _firstLabel2.text = dic[@"ADInfo"];
    }

    // 后备view
    NSInteger next = (_currentShowIndex+1)%self.cellData.adsArray.count;
    NSDictionary * dic2 = self.cellData.adsArray[next];
    if (dic2) {
        _secondLabel1.text = dic2[@"SchoolName"];
        _secondLabel2.text = dic2[@"ADInfo"];
    }
}

- (void)updateSchoolADShow {
    [self addViewOnContainer];
    
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        __strong typeof(self) strongSelf = weakSelf;
        CGRect toRect = strongSelf.containerView.bounds;
        CGRect oldRect = toRect;
        toRect.origin.y -= toRect.size.height;
        [UIView animateWithDuration:0.5 animations:^{
            strongSelf.firstADView.frame = toRect;
            strongSelf.secondADView.frame = oldRect;
        } completion:^(BOOL finished) {
            strongSelf.currentShowIndex ++;
            [strongSelf updateSchoolADShow];
        }];
    });
}

@end
