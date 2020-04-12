//
//  FouthViewController.m
//  JKApp
//
//  Created by Apple on 2020/2/17.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "FouthViewController.h"

@interface FouthViewController ()

@end

@implementation FouthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Fouth";
        //        UIImage *image = [UIImage imageNamed:@"2.png"];
        //        CGImageRef imageRef = image.CGImage;
        //        self.tabBarItem.image = [[UIImage imageWithCGImage:imageRef scale:2 orientation:UIImageOrientationDown] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        //
    }
    return self;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
