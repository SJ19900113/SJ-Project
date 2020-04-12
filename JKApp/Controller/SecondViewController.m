//
//  SecondViewController.m
//  JKApp
//
//  Created by Apple on 2020/2/6.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "SecondViewController.h"
#import <Masonry.h>
#import "Ke1ViewController.h"
#import "Ke2ViewController.h"
#import "Ke3ViewController.h"
#import "Ke4ViewController.h"
#import "NabenViewController.h"
#import "SecondTabData.h"

@interface SecondViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIView *customTopTabView;

@property (strong, nonatomic) Ke1ViewController * ke1Controller;
@property (strong, nonatomic) Ke2ViewController * ke2Controller;
@property (strong, nonatomic) Ke3ViewController * ke3Controller;
@property (strong, nonatomic) Ke4ViewController * ke4Controller;
@property (strong, nonatomic) NabenViewController * nabenController;

@property (strong, nonatomic) UIButton * ke1Button;
@property (strong, nonatomic) UIButton * ke2Button;
@property (strong, nonatomic) UIButton * ke3Button;
@property (strong, nonatomic) UIButton * ke4Button;
@property (strong, nonatomic) UIButton * nabenButton;
@property (strong, nonatomic) UILabel * sliderLabel;

@property (strong, nonatomic) UIScrollView * mainScrollView;

- (Ke1ViewController *)ke1VC;
- (Ke2ViewController *)ke2VC;
- (Ke3ViewController *)ke3VC;
- (Ke4ViewController *)ke4VC;
- (NabenViewController *)nabenVC;

@property (strong, nonatomic) NSArray * tableDatasArray;

@end

#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@implementation SecondViewController

#pragma mark 懒加载五个VC
- (Ke1ViewController *)ke1VC {
    if (_ke1Controller == nil) {
        _ke1Controller = [Ke1ViewController new];
        _ke1Controller.navigationController = self.navigationController;
    }
    return _ke1Controller;
}
- (Ke2ViewController *)ke2VC {
    if (_ke2Controller == nil) {
        _ke2Controller = [Ke2ViewController new];
        _ke2Controller.navigationController = self.navigationController;
    }
    return _ke2Controller;
}
- (Ke3ViewController *)ke3VC {
    if (_ke3Controller == nil) {
        _ke3Controller = [Ke3ViewController new];
        _ke3Controller.navigationController = self.navigationController;
    }
    return _ke3Controller;
}
- (Ke4ViewController *)ke4VC {
    if (_ke4Controller == nil) {
        _ke4Controller = [Ke4ViewController new];
        _ke4Controller.navigationController = self.navigationController;
    }
    return _ke4Controller;
}
- (NabenViewController *)nabenVC {
    if (_nabenController == nil) {
        _nabenController = [NabenViewController new];
        _nabenController.navigationController = self.navigationController;
    }
    return _nabenController;
}

- (void)initTableDataArray {
    SecondTabData * data1 = [SecondTabData new];
    data1.cellType = SecondTableCellType_A;
    data1.tableCell_Height = 80;
    data1.adImageNamesArray = @[@"secondTab_ad1",@"secondTab_ad2"];
    data1.selectedIndex = 1;
    
    SecondTabData * data2 = [SecondTabData new];
    data2.cellType = SecondTableCellType_B;
    data2.tableCell_Height = 160;
    
    SecondTabData * data3 = [SecondTabData new];
    data3.cellType = SecondTableCellType_B;
    data3.tableCell_Height = 160;
    
    self.tableDatasArray = @[data1, data2, data3];
}

- (NSArray *)tableSourceArray {
    return _tableDatasArray;
}

#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTableDataArray];
        
    self.topView.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1.0];
    
    self.currentSelectedIndex = 1;
    
    _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.frame.size.height)];
    _mainScrollView.delegate = self;
    _mainScrollView.backgroundColor = [UIColor whiteColor];
    _mainScrollView.pagingEnabled = YES;
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    _mainScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_mainScrollView];
    
    NSArray * views = @[self.ke1VC.view, self.ke2VC.view, self.ke3VC.view, self.ke4VC.view, self.nabenVC.view];
    for (NSInteger i = 0; i < views.count; i++) {
        UIView * pageView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth*i, 0, _mainScrollView.frame.size.width, _mainScrollView.frame.size.height-100)];
        [pageView addSubview:views[i]];
        [_mainScrollView addSubview:pageView];
    }
    _mainScrollView.contentSize = CGSizeMake(kScreenWidth*(views.count), 0);
    //滚动到_currentIndex对应的tab
    [_mainScrollView setContentOffset:CGPointMake((_mainScrollView.frame.size.width)*(_currentSelectedIndex-1), 0) animated:YES];
    

    _customTopTabView.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1.0];
    
    [_customTopTabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(0);
        make.right.equalTo(self.view).with.offset(0);
        make.top.equalTo(self.topView.mas_bottom).offset(0);
        make.height.equalTo(@40);
    }];
    
    [_mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.view).offset(0);
        make.top.equalTo(self.customTopTabView.mas_bottom).offset(0);
    }];
    
    [self initTopTabView];
    
    [self sliderWithTag:self.currentSelectedIndex];     //默认选科1

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Green";
    }
    return self;
}

#pragma mark - top tab

- (void)initTopTabView {
    // 科一
    _ke1Button = [UIButton buttonWithType:UIButtonTypeCustom];
    [_ke1Button setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [_ke1Button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _ke1Button.frame = CGRectMake(0, 0, kScreenWidth/5, _customTopTabView.frame.size.height);
    _ke1Button.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [_ke1Button addTarget:self action:@selector(topTabButtonClickedAction:) forControlEvents:UIControlEventAllEvents];
     [_ke1Button setTitle:@"科一" forState:UIControlStateNormal];
     _ke1Button.tag = 1;
     _ke1Button.selected = YES;
     [_customTopTabView addSubview:_ke1Button];

    // 科二
    _ke2Button = [UIButton buttonWithType:UIButtonTypeCustom];
    [_ke2Button setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [_ke2Button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _ke2Button.frame = CGRectMake(_ke1Button.frame.origin.x+_ke1Button.frame.size.width, 0, kScreenWidth/5, _customTopTabView.frame.size.height);
    _ke2Button.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [_ke2Button addTarget:self action:@selector(topTabButtonClickedAction:) forControlEvents:UIControlEventAllEvents];
     [_ke2Button setTitle:@"科二" forState:UIControlStateNormal];
     _ke2Button.tag = 2;
     [_customTopTabView addSubview:_ke2Button];

    // 科三
    _ke3Button = [UIButton buttonWithType:UIButtonTypeCustom];
    [_ke3Button setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [_ke3Button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _ke3Button.frame = CGRectMake(_ke2Button.frame.origin.x+_ke2Button.frame.size.width, 0, kScreenWidth/5, _customTopTabView.frame.size.height);
    _ke3Button.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [_ke3Button addTarget:self action:@selector(topTabButtonClickedAction:) forControlEvents:UIControlEventAllEvents];
     [_ke3Button setTitle:@"科三" forState:UIControlStateNormal];
     _ke3Button.tag = 3;
     [_customTopTabView addSubview:_ke3Button];
    
    // 科四
    _ke4Button = [UIButton buttonWithType:UIButtonTypeCustom];
    [_ke4Button setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [_ke4Button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _ke4Button.frame = CGRectMake(_ke3Button.frame.origin.x+_ke3Button.frame.size.width, 0, kScreenWidth/5, _customTopTabView.frame.size.height);
    _ke4Button.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [_ke4Button addTarget:self action:@selector(topTabButtonClickedAction:) forControlEvents:UIControlEventAllEvents];
     [_ke4Button setTitle:@"科四" forState:UIControlStateNormal];
     _ke4Button.tag = 4;
     [_customTopTabView addSubview:_ke4Button];
    
    // 拿本
    _nabenButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_nabenButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    [_nabenButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _nabenButton.frame = CGRectMake(_ke4Button.frame.origin.x+_ke4Button.frame.size.width, 0, kScreenWidth/5, _customTopTabView.frame.size.height);
    _nabenButton.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [_nabenButton addTarget:self action:@selector(topTabButtonClickedAction:) forControlEvents:UIControlEventAllEvents];
     [_nabenButton setTitle:@"拿本" forState:UIControlStateNormal];
     _nabenButton.tag = 5;
     [_customTopTabView addSubview:_nabenButton];
    
    CGRect frame = CGRectMake(0, _customTopTabView.bounds.size.height-2, kScreenWidth/5, 4);
    frame = UIEdgeInsetsInsetRect(frame, UIEdgeInsetsMake(0, 30, 0, 30));
    _sliderLabel = [[UILabel alloc] initWithFrame:frame];
    _sliderLabel.backgroundColor = [UIColor blackColor];
    [_customTopTabView addSubview:_sliderLabel];
}
     
// 点击button，所有scrollview要翻页
- (void)topTabButtonClickedAction:(id)sender {
    UIButton * btn = sender;
    if (_currentSelectedIndex == btn.tag) {
        return;
    }
    [self sliderAnimationWithTag:btn.tag];
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.mainScrollView.contentOffset = CGPointMake(kScreenWidth*(btn.tag-1), 0);
    } completion:^(BOOL finished) {
        
    }];
}
     
- (UIButton *)buttonWithTag:(NSInteger )tag {
    UIButton * btn = _ke1Button;
    switch (tag) {
        case 1:
            btn = _ke1Button;
            break;
        case 2:
            btn = _ke2Button;
            break;
        case 3:
            btn = _ke3Button;
            break;
        case 4:
            btn = _ke4Button;
            break;
        case 5:
            btn = _nabenButton;
            break;
            
        default:
            break;
    }
    return btn;
}

// 拖动scrollview，所以直接改变button
- (void)sliderAnimationWithTag:(NSInteger)tag {
    self.currentSelectedIndex = tag;
    _ke1Button.selected = NO;
    _ke2Button.selected = NO;
    _ke3Button.selected = NO;
    _ke4Button.selected = NO;
    _nabenButton.selected = NO;
    UIButton * sender = [self buttonWithTag:tag];
    sender.selected = YES;
    //动画
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        __strong typeof(self) strongSelf = weakSelf;
        strongSelf.sliderLabel.frame = CGRectMake(sender.frame.origin.x+30, strongSelf.sliderLabel.frame.origin.y, strongSelf.sliderLabel.frame.size.width, strongSelf.sliderLabel.frame.size.height);
        
    } completion:^(BOOL finished) {
        __strong typeof(self) strongSelf = weakSelf;
        strongSelf.ke1Button.titleLabel.font = [UIFont systemFontOfSize:15];
        strongSelf.ke2Button.titleLabel.font = [UIFont systemFontOfSize:15];
        strongSelf.ke3Button.titleLabel.font = [UIFont systemFontOfSize:15];
        strongSelf.ke4Button.titleLabel.font = [UIFont systemFontOfSize:15];
        strongSelf.nabenButton.titleLabel.font = [UIFont systemFontOfSize:15];
        sender.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    }];
}

// 无动画，第一次和scrollview结束的时候调用
-(void)sliderWithTag:(NSInteger)tag{
    self.currentSelectedIndex = tag;
    _ke1Button.selected = NO;
    _ke2Button.selected = NO;
    _ke3Button.selected = NO;
    _ke4Button.selected = NO;
    _nabenButton.selected = NO;
    UIButton * sender = [self buttonWithTag:tag];
    sender.selected = YES;
    // 无动画
    _sliderLabel.frame = CGRectMake(sender.frame.origin.x+30, _sliderLabel.frame.origin.y, _sliderLabel.frame.size.width, _sliderLabel.frame.size.height);
    _ke1Button.titleLabel.font = [UIFont systemFontOfSize:15];
    _ke2Button.titleLabel.font = [UIFont systemFontOfSize:15];
    _ke3Button.titleLabel.font = [UIFont systemFontOfSize:15];
    _ke4Button.titleLabel.font = [UIFont systemFontOfSize:15];
    _nabenButton.titleLabel.font = [UIFont systemFontOfSize:15];
    sender.titleLabel.font = [UIFont boldSystemFontOfSize:18];
}

#pragma mark - scrollview Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //实时计算当前位置,实现和titleView上的按钮的联动
    CGFloat contentOffSetX = scrollView.contentOffset.x;
    
    CGFloat X = contentOffSetX/5.0;

    CGRect frame = _sliderLabel.frame;
    frame.origin.x = X;
    
    // 调整一下
    frame.origin.x += 30;
    
    _sliderLabel.frame = frame;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat contentOffSetX = scrollView.contentOffset.x;
        int index_ = contentOffSetX/kScreenWidth;
    [self sliderWithTag:index_+1];
}



- (void)showAlertWithMessage:(NSString *)titleString {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:titleString preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *conform = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];

    [alert addAction:conform];
        
    [self presentViewController:alert animated:YES completion:nil];
}

@end
