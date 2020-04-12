//
//  SecondTabACell.m
//  JKApp
//
//  Created by Apple on 2020/3/3.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "SecondTabACell.h"
#import <Masonry.h>
#import "SecondTabData.h"
#import "ControllerFunc.h"
#import "Ke1ViewController.h"

@interface SecondTabACell () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) UIImageView * imageView1;
@property (strong, nonatomic) UIImageView * imageView2;
@property (strong, nonatomic) UILabel * label1;
@property (strong, nonatomic) UILabel * label2;

@property (assign, nonatomic) NSInteger selectedIndex;

@end

@implementation SecondTabACell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectedIndex = 0;
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.contentView).offset(0);
    }];
    
    CGRect frame = self.scrollView.bounds;
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    
    float gwidth = [UIScreen mainScreen].bounds.size.width;
    frame.size.width = gwidth;
    self.imageView1 = [[UIImageView alloc] initWithFrame:frame];
    self.imageView1.image = [UIImage imageNamed:@"secondTab_ad1"];
    [_scrollView addSubview:self.imageView1];
    
    frame.origin.x += gwidth;
    self.imageView2 = [[UIImageView alloc] initWithFrame:frame];
    self.imageView2.image = [UIImage imageNamed:@"secondTab_ad2"];
    [_scrollView addSubview:self.imageView2];
    
    _scrollView.contentSize = CGSizeMake(gwidth*2, 0);
    [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    
    // labels
    
    CGRect labelFrame = CGRectMake(0, 0, 20, 4);
    
    self.label1 = [[UILabel alloc] initWithFrame:labelFrame];
    _label1.backgroundColor = [UIColor blackColor];
    [self.contentView addSubview:_label1];
    
    self.label2 = [[UILabel alloc] initWithFrame:labelFrame];
    _label2.backgroundColor = [UIColor blackColor];
    [self.contentView addSubview:_label2];
    
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView).offset(-15);
        make.width.equalTo(@20);
        make.height.equalTo(@4);
        make.bottom.equalTo(self.contentView).offset(-8);
    }];
    
    [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView).offset(15);
        make.width.equalTo(@20);
        make.height.equalTo(@4);
        make.bottom.equalTo(self.contentView).offset(-8);
    }];
    
    [self sliderWithCurrentIndex:0];
    
    UITapGestureRecognizer * singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapOnScrollView)];
    singleTap.numberOfTouchesRequired = 1;
    singleTap.numberOfTapsRequired = 1;
    [self.scrollView addGestureRecognizer:singleTap];
}

- (void)sliderWithCurrentIndex:(NSInteger)tag {
    self.selectedIndex = tag;
    if (tag == 0) {
        self.label1.backgroundColor = [UIColor blackColor];
        self.label2.backgroundColor = [UIColor grayColor];
    } else {
        self.label1.backgroundColor = [UIColor grayColor];
        self.label2.backgroundColor = [UIColor blackColor];
    }
}

#pragma mark - scroll

- (void)reloadCellScrollView {
    self.selectedIndex = self.cellData.selectedIndex;
    [self sliderWithCurrentIndex:self.selectedIndex];
    
    float gwidth = [UIScreen mainScreen].bounds.size.width;
    [_scrollView setContentOffset:CGPointMake(self.selectedIndex*gwidth, 0) animated:YES];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat contentOffSetX = scrollView.contentOffset.x;
    float gwidth = [UIScreen mainScreen].bounds.size.width;
    NSInteger index = contentOffSetX >= gwidth ? 1 : 0;
    [self sliderWithCurrentIndex:index];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat contentOffSetX = scrollView.contentOffset.x;
    float gwidth = [UIScreen mainScreen].bounds.size.width;
    int index = contentOffSetX/gwidth;
    [self sliderWithCurrentIndex:index];
}

#pragma mark - gesture

- (void)singleTapOnScrollView {
    NSLog(@"clieck selectedIndex === %ld",self.selectedIndex);
    [[ControllerFunc secondK1Controller] showSecondADViewControllerWithADIndex:self.selectedIndex];
}

@end
