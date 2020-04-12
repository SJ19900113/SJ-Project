//
//  FirstTabForDCell.m
//  JKApp
//
//  Created by Apple on 2020/2/23.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "FirstTabForDCell.h"
#import "ControllerFunc.h"
#import "MainViewController.h"

@interface FirstTabForDCell ()

@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UILabel *label5;

- (UIFont *)selectedFont;
- (UIFont *)regularFont;
- (UIColor *)selectedColor;
- (UIColor *)regularColor;
- (NSArray *)labelArray;

@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;
@property (weak, nonatomic) IBOutlet UIButton *button5;


@end

@implementation FirstTabForDCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _label5.textColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1];
    _label5.font = self.regularFont;
}

- (UIFont *)selectedFont {
    return [UIFont boldSystemFontOfSize:15];
}

- (UIFont *)regularFont {
    return [UIFont systemFontOfSize:15];
}

- (UIColor *)selectedColor {
    return [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
}
- (UIColor *)regularColor {
    return [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSArray *)labelArray {
    return @[_label1, _label2, _label3, _label4, _label5];
}

- (void)updateCurrentSortMode {
    for (NSInteger i = 0; i < self.labelArray.count; i++) {
        UILabel * lab = self.labelArray[i];
        if (i == self.cellData.sortMode) {
            lab.font = self.selectedFont;
            lab.textColor = self.selectedColor;
        } else {
            lab.font = self.regularFont;
            lab.textColor = self.regularColor;
        }
    }
}

#pragma mark - action

- (IBAction)button1Action:(id)sender {
    self.cellData.sortMode = 0;
    [[ControllerFunc mainController] reloadTableViewWhenSortChanged];
}
- (IBAction)button2Action:(id)sender {
    self.cellData.sortMode = 1;
    [[ControllerFunc mainController] reloadTableViewWhenSortChanged];
}
- (IBAction)button3Action:(id)sender {
    self.cellData.sortMode = 2;
    [[ControllerFunc mainController] reloadTableViewWhenSortChanged];
}
- (IBAction)button4Action:(id)sender {
    self.cellData.sortMode = 3;
    [[ControllerFunc mainController] reloadTableViewWhenSortChanged];
}

- (IBAction)button5Action:(id)sender {
    self.cellData.sortMode = 4;
    [[ControllerFunc mainController] reloadTableViewWhenSortChanged];
    NSLog(@"show 筛选");
}

@end
