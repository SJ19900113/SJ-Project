//
//  SecondTabBCell.m
//  JKApp
//
//  Created by Apple on 2020/3/4.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "SecondTabBCell.h"
#import "ControllerFunc.h"
#import "SecondViewController.h"

@interface SecondTabBCell ()

@property (weak, nonatomic) IBOutlet UIImageView *LeftTopImageView;


@end

@implementation SecondTabBCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)startVipImageViewAnimation {
    
    // 1
  //  [CATransaction begin];
    CABasicAnimation * rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    rotationAnimation.byValue = [NSNumber numberWithFloat:M_PI];
    rotationAnimation.duration = 1;
    rotationAnimation.removedOnCompletion = NO;
    rotationAnimation.fillMode = kCAFillModeForwards;
 //   rotationAnimation.repeatCount = MAXFLOAT;
    
    [_LeftTopImageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
 //   [CATransaction commit];
    
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf startVipImageViewAnimation];
    });

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSUInteger numTaps = touches.anyObject.tapCount;
    
    if (numTaps < 1) {
        return;
    }
    
    UITouch * touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    if (CGRectContainsPoint(_LeftTopImageView.frame, point)) {
        [[ControllerFunc secondController] showAlertWithMessage:@"点击了_LeftTopImageView"];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
