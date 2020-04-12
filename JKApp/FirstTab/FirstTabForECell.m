//
//  FirstTabForECell.m
//  JKApp
//
//  Created by Apple on 2020/2/25.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "FirstTabForECell.h"

@interface FirstTabForECell ()

- (NSDictionary *)currentDic;

@property (weak, nonatomic) IBOutlet UIImageView *schoolImageView;
@property (weak, nonatomic) IBOutlet UIImageView *tagImageView;
@property (weak, nonatomic) IBOutlet UILabel *schoolNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *vipImageView;
@property (weak, nonatomic) IBOutlet UIImageView *huangguanImageView;
@property (weak, nonatomic) IBOutlet UIImageView *pingfenImageView;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *honourLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UIView *commentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *jianImageView;
@property (weak, nonatomic) IBOutlet UILabel *jianLabel;
@property (weak, nonatomic) IBOutlet UIImageView *tryImageView;
@property (weak, nonatomic) IBOutlet UILabel *tryLabel;

@property (weak, nonatomic) IBOutlet UIView *jianView;
@property (weak, nonatomic) IBOutlet UIView *tryView;
@property (weak, nonatomic) IBOutlet UIView *infoView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *jianViewHConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tryViewHConstraint;


@property (strong, nonatomic) CALayer * lineLayer;

@end

@implementation FirstTabForECell

- (void)awakeFromNib {
    [super awakeFromNib];

    [_schoolNameLabel sizeToFit];
    [_scoreLabel sizeToFit];
    [_priceLabel sizeToFit];
    [_jianLabel sizeToFit];
    [_tryLabel sizeToFit];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (NSDictionary *)currentDic {
    return _cellData.schoolDic;
}

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
- (void)loadSchoolInfoOnCell {
    UIView * lineSuperView = _infoView;
    NSDictionary * dic = self.currentDic;
    if (dic) {
        self.schoolImageView.image = [UIImage imageNamed:dic[@"SchoolImageName"]];
        self.tagImageView.image = [UIImage imageNamed:dic[@"TagImageName"]];
        self.schoolNameLabel.text = dic[@"SchoolName"];
        
        BOOL hasV = [dic[@"HasV"] boolValue];
        if (hasV) {
            [self.vipImageView setHidden:NO];
            self.vipImageView.image = [UIImage imageNamed:@"vip_log"];
        } else {
            [self.vipImageView setHidden:YES];
        }
        
        BOOL hasM = [dic[@"HasM"] boolValue];
        if (hasM) {
            [self.huangguanImageView setHidden:NO];
            self.huangguanImageView.image = [UIImage imageNamed:@"huangguan_logo"];
            
            if (hasV==NO) {
                CGRect frame = self.huangguanImageView.frame;
                frame.origin.x = _schoolNameLabel.frame.origin.x+_schoolNameLabel.frame.size.width + 10;
                self.huangguanImageView.frame = frame;
            } else {
                CGRect frame = self.huangguanImageView.frame;
                frame.origin.x = _vipImageView.frame.origin.x+_vipImageView.frame.size.width + 10;
                self.huangguanImageView.frame = frame;
            }

        } else {
            [self.huangguanImageView setHidden:YES];
//            CGRect frame = self.huangguanImageView.frame;
//            frame.size.height = 0;
//            self.huangguanImageView.frame = frame;
        }
        
        self.pingfenImageView.image = [UIImage imageNamed:@"pingfen_logo"];
        self.scoreLabel.text = [NSString stringWithFormat:@"%.1f 分",[dic[@"Score"] floatValue]];
        
        self.honourLabel.text = dic[@"Honour"];
        
        self.priceLabel.text = [NSString stringWithFormat:@"¥ %ld %@ %@", [dic[@"Price"] integerValue], dic[@"Type"], dic[@"Sclass"]];
        
        self.locationLabel.text = [NSString stringWithFormat:@"%@ %ld km", dic[@"Location"],
                              [dic[@"Distance"] integerValue]];
        
        //self.commentLabel.text = dic[@"Comment"];
        [self p_createCommentWithString:dic[@"Comment"]];
        
        NSInteger discount = [dic[@"Discount"] integerValue];
        if (discount == 0) {
            self.jianViewHConstraint.constant = 0;
            [self.jianView setHidden:YES];
        } else {
            self.jianViewHConstraint.constant = 30;

            lineSuperView = _jianView;
            [self.jianView setHidden:NO];
            self.jianImageView.image = [UIImage imageNamed:@"jianmian_logo"];
            self.jianLabel.text = [NSString stringWithFormat:@"学车立减 %ld 元", discount];
        }

        NSInteger tryLearn = [dic[@"TryLearn"] integerValue];
        if (tryLearn == 0) {
            self.tryViewHConstraint.constant = 0;
            [self.tryView setHidden:YES];
        } else {
            self.tryViewHConstraint.constant = 30;

            lineSuperView = _tryView;
            [self.tryView setHidden:NO];
            self.tryImageView.image = [UIImage imageNamed:@"mian_logo"];
            self.tryLabel.text = [NSString stringWithFormat:@"免费试学 %ld 小时", tryLearn];
        }
        
        // todo line显示有问题
        if (lineSuperView) {
            if (self.lineLayer) {
                if (self.lineLayer.superlayer) {
                    [self.lineLayer removeFromSuperlayer];
                }
            }
            CALayer * lineLayer = [CALayer layer];
            lineLayer.backgroundColor = [UIColor colorWithWhite:0.4 alpha:1].CGColor;
            lineLayer.frame = CGRectMake(0, lineSuperView.layer.frame.size.height-1, lineSuperView.layer.frame.size.width-20, 0.5);
            [lineSuperView.layer addSublayer:lineLayer];
            self.lineLayer = lineLayer;
        }
    }
}

- (void)p_createCommentWithString:(NSString *)string {
    NSArray * array = [string componentsSeparatedByString:@" "];

    UIView * superView = _commentLabel;
    NSArray * subarray = [NSArray arrayWithArray:superView.subviews];
    for (UIView * vw in subarray) {
        if ([vw isKindOfClass:UIView.class]) {
            [vw removeFromSuperview];
        }
    }
    
    NSInteger start = 0;
    for (NSString * comm in array) {
        CGRect frame = CGRectMake(start, 4, 100, superView.bounds.size.height);
        CGRect bounds = frame;
        bounds.origin = CGPointMake(0, 0);
        UIView * view = [[UIView alloc] initWithFrame:frame];
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectInset(bounds, 3, 3)];
        label.text = comm;
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = [UIColor colorWithWhite:0.4 alpha:1];
        [label sizeToFit];
        [view addSubview:label];
        
        label.layer.cornerRadius = 3;
        label.layer.borderWidth = 0.5;
        label.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
        [superView addSubview:view];
        
        start += label.bounds.size.width+15;
    }
}

@end
