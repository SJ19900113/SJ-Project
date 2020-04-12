//
//  FirstTabACollectionViewCell.m
//  JKApp
//
//  Created by Apple on 2020/2/20.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "FirstTabACollectionViewCell.h"

@interface FirstTabACollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation FirstTabACollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setImage:(UIImage *)image {
    _imageView.image = image;
}
- (void)setTitle:(NSString *)title {
    _titleLabel.text = title;
}

@end
