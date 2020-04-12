//
//  FirstTabForBCell.m
//  JKApp
//
//  Created by Apple on 2020/2/20.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "FirstTabForBCell.h"
#import "ControllerFunc.h"
#import "MainViewController.h"
#import <UICountingLabel.h>

@interface FirstTabForBCell ()

@property (weak, nonatomic) IBOutlet UICountingLabel *countLabel;


@end

@implementation FirstTabForBCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _countLabel.method = UILabelCountingMethodLinear;
    _countLabel.format = @"%ld";
    [_countLabel sizeToFit];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateCustomerCount {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [_countLabel countFrom:0 to:self.cellData.customerCount withDuration:2.0f];
    });
}

- (IBAction)chooseSchoolButtonAction:(id)sender {
    [[ControllerFunc mainController] showChooseSchoolViewController];
}

@end
