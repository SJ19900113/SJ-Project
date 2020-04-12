//
//  FisrtTopView.m
//  JKApp
//
//  Created by Apple on 2020/2/18.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "FisrtTopView.h"

@implementation FisrtTopView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    
    CGContextMoveToPoint(context, 0, self.bounds.size.height);
    CGContextAddLineToPoint(context, self.bounds.size.width, self.bounds.size.height);
    
    CGContextSetRGBStrokeColor(context, 0.81, 0.81, 0.81, 1);
    
    CGContextStrokePath(context);
}


@end
