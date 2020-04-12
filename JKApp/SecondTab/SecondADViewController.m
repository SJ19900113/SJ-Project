//
//  SecondADViewController.m
//  JKApp
//
//  Created by Apple on 2020/3/3.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "SecondADViewController.h"
#import <Masonry.h>
#import "ControllerFunc.h"
#import "Ke1ViewController.h"

@interface SecondADViewController ()

@property (strong, nonatomic) UIView * topView;
@property (strong, nonatomic) UIButton * leftBtn;

@property (strong, nonatomic) UILabel * titleLabel;
@end

@implementation SecondADViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGRect frame = self.view.bounds;
    frame.size.height = 100;
    frame.origin.y = 0;
    
    self.topView = [[UIView alloc] initWithFrame:frame];
    self.topView.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1.0];
    
    [self.view addSubview:self.topView];
    
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [_leftBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _leftBtn.frame = CGRectMake(0, 60, 60, 20);
    _leftBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [_leftBtn addTarget:self action:@selector(topTabButtonBackAction:) forControlEvents:UIControlEventAllEvents];
     [_leftBtn setTitle:@"Back" forState:UIControlStateNormal];
     [self.topView addSubview:_leftBtn];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    self.titleLabel.textColor = [UIColor blueColor];
    [self.titleLabel sizeToFit];
    [self.topView addSubview:self.titleLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.leftBtn).offset(0);
        make.centerX.equalTo(self.topView);
       // make.width.equalTo(@20);
       // make.height.equalTo(@20);
    }];
    
    [self updateTitleLabel];
}

- (void)viewWillAppear:(BOOL)animated {
    [self updateTitleLabel];
}

- (void)updateTitleLabel {
    self.titleLabel.text = [NSString stringWithFormat:@"Choose AD %ld", self.adIndex];
    
}

- (void)topTabButtonBackAction:(id)sender {
    [[ControllerFunc secondK1Controller] closeSecondADViewController];
}


@end
