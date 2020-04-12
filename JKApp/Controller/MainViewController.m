//
//  MainViewController.m
//  JKApp
//
//  Created by Apple on 2020/2/6.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "MainViewController.h"
#import "FisrtTopView.h"
#import "FirstTabData.h"
#import "FirstTabForACell.h"
#import "FirstTabForBCell.h"
#import "FirstTabForCCell.h"
#import "FirstTabForDCell.h"
#import "FirstTabForECell.h"
#import <MJRefresh.h>
#import "ControllerFunc.h"
#import <MBProgressHUD.h>

#import "ChooseSchoolViewController.h"

static NSString * FirstTabCellForA_Identifier = @"firsttabfora";
static NSString * FirstTabCellForB_Identifier = @"firsttabforb";
static NSString * FirstTabCellForC_Identifier = @"firsttabforc";
static NSString * FirstTabCellForD_Identifier = @"firsttabford";
static NSString * FirstTabCellForE_Identifier = @"firsttabfore";

@interface MainViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet FisrtTopView *topView;
@property (weak, nonatomic) IBOutlet UIView *topContainerView;
@property (weak, nonatomic) IBOutlet UIView *topControlView;
@property (assign, nonatomic) float scrollOffsetY;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topControlConstraintBottom;
@property (weak, nonatomic) IBOutlet UIView *topInsiderDownView;

@property (weak, nonatomic) IBOutlet UIView *searchContainerView;
@property (weak, nonatomic) IBOutlet UIView *searchDefaultNameContainerView;
@property (strong, nonatomic) UILabel * firstSearachLabel;
@property (strong, nonatomic) UILabel * secondSearachLabel;
@property (assign, nonatomic) NSInteger currentShowSearchIndex;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray * tableDatasArray;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initFirstTabDatas];
    
    self.topView.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1.0];
    self.topControlView.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1.0];
    self.topInsiderDownView.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1.0];

    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FirstTabForACell class]) bundle:nil] forCellReuseIdentifier:@"firsttabfora"];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FirstTabForBCell class]) bundle:nil] forCellReuseIdentifier:@"firsttabforb"];

    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FirstTabForCCell class]) bundle:nil] forCellReuseIdentifier:@"firsttabforc"];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FirstTabForDCell class]) bundle:nil] forCellReuseIdentifier:@"firsttabford"];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([FirstTabForECell class]) bundle:nil] forCellReuseIdentifier:@"firsttabfore"];
    
    // search
    _searchDefaultNameContainerView.backgroundColor = [UIColor clearColor];
    CGRect frame = _searchDefaultNameContainerView.bounds;
    self.firstSearachLabel = [[UILabel alloc] initWithFrame:frame];
    _firstSearachLabel.textColor = [UIColor colorWithWhite:0.4 alpha:1];
    _firstSearachLabel.font = [UIFont systemFontOfSize:13];
    frame.origin.y += frame.size.height;
    self.secondSearachLabel = [[UILabel alloc] initWithFrame:frame];
    _secondSearachLabel.textColor = [UIColor colorWithWhite:0.4 alpha:1];
    _secondSearachLabel.font = [UIFont systemFontOfSize:13];
    [_searchDefaultNameContainerView addSubview:_firstSearachLabel];
    [_searchDefaultNameContainerView addSubview:_secondSearachLabel];
    self.currentShowSearchIndex = 0;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self showDefaultSearchSchoolName];
    });
    
    // tableview
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //进行数据刷新操作
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    }];
   //  [self.tableView.mj_header beginRefreshing];
    

    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    // 设置文字
    [footer setTitle:@"Click or drag up to refresh" forState:MJRefreshStateIdle];
    [footer setTitle:@"Loading more ..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"No more data" forState:MJRefreshStateNoMoreData];

    // 设置字体
    footer.stateLabel.font = [UIFont systemFontOfSize:14];
    
    // 设置footer
    self.tableView.mj_footer = footer;
    
    self.searchContainerView.backgroundColor = [UIColor clearColor];
    UIImage * image = [UIImage imageNamed:@"Search_container.png"];
    self.searchContainerView.layer.contents = (__bridge_transfer id)image.CGImage;
    
    [self updateScrollOffsetY];
    
    [self changeTopToLocationSearchMode];
}

- (void)updateScrollOffsetY {
    float height = 0;
    for (int i = 0; i < 4; i ++) {
        FirstTabData * tab = _tableDatasArray[i];
        height += tab.tableCell_Height;
    }
    self.scrollOffsetY = height;
}

- (void)loadMoreData {
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf importMoreDataOnTable];
        [strongSelf.tableView reloadData];
        [strongSelf.tableView.mj_footer endRefreshingWithNoMoreData];
    });
}
- (void)importMoreDataOnTable {
    NSMutableArray * array = [_tableDatasArray mutableCopy];
    
    FirstTabData * data1 = [FirstTabData new];
    data1.cellType = FirstTableCellType_E;
    data1.tableCell_Height = 172;
    
    NSDictionary * sdic1 = @{@"SchoolImageName":@"shunan_school",
                             @"TagImageName":@"pingpai_logo",
                             @"SchoolName":@"武昌驾校",
                             @"HasV":@(YES),
                             @"HasM":@(NO),
                             @"Score":@(4),
                             @"Honour":@"综合排名第1名",
                             @"Price":@(5880),
                             @"Type":@"C1",
                             @"Sclass":@"速成班",
                             @"Location":@"松江区",
                             @"Distance":@(900),
                             @"Comment":@"规模大 有接送 自有考场",
                             @"Discount":@(0),
                             @"TryLearn":@(0),
    };
    data1.schoolDic = sdic1;
    if ([sdic1[@"Discount"] integerValue] == 0) {
        data1.tableCell_Height -= 30;
    }
    if ([sdic1[@"TryLearn"] integerValue] == 0) {
        data1.tableCell_Height -= 30;
    }
    
    FirstTabData * data2 = [FirstTabData new];
    data2.cellType = FirstTableCellType_E;
    data2.tableCell_Height = 172;
    
    NSDictionary * sdic2 = @{@"SchoolImageName":@"shunan_school",
                             @"TagImageName":@"pingpai_logo",
                             @"SchoolName":@"武汉驾校",
                             @"HasV":@(NO),
                             @"HasM":@(YES),
                             @"Score":@(4),
                             @"Honour":@"综合排名第1名",
                             @"Price":@(3000),
                             @"Type":@"C1",
                             @"Sclass":@"速成班",
                             @"Location":@"松江区",
                             @"Distance":@(200),
                             @"Comment":@"规模大 有接送 自有考场",
                             @"Discount":@(800),
                             @"TryLearn":@(0),
    };
    data2.schoolDic = sdic2;
    if ([sdic2[@"Discount"] integerValue] == 0) {
        data1.tableCell_Height -= 30;
    }
    if ([sdic2[@"TryLearn"] integerValue] == 0) {
        data2.tableCell_Height -= 30;
    }
    
    [array addObject:data1];
    [array addObject:data2];
    _tableDatasArray = array;
    [self p_sortWithScore];

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Red";
//        UIImage *image = [UIImage imageNamed:@"2.png"];
//        CGImageRef imageRef = image.CGImage;
//        self.tabBarItem.image = [[UIImage imageWithCGImage:imageRef scale:2 orientation:UIImageOrientationDown] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//
    }
    return self;
}

- (void)initFirstTabDatas {
    

    // for a
    
    FirstTabData * fisrtData = [FirstTabData new];
    fisrtData.cellType = FirstTableCellType_A;
    fisrtData.tableCell_Height = 170.0;
    
    NSDictionary * dic1 = @{@"Title":@"驾校排行", @"ImageName":@"demo_tab_first_a"};
    NSDictionary * dic2 = @{@"Title":@"教练排行", @"ImageName":@"demo_tab_first_a"};
    NSDictionary * dic3 = @{@"Title":@"陪练服务", @"ImageName":@"demo_tab_first_a"};
    NSDictionary * dic4 = @{@"Title":@"班型选择", @"ImageName":@"demo_tab_first_a"};
    NSDictionary * dic5 = @{@"Title":@"学车流程", @"ImageName":@"demo_tab_first_a"};
    NSDictionary * dic6 = @{@"Title":@"免费试学", @"ImageName":@"demo_tab_first_a"};
    NSDictionary * dic7 = @{@"Title":@"学车立减", @"ImageName":@"demo_tab_first_a"};
    NSDictionary * dic8 = @{@"Title":@"好友驾校", @"ImageName":@"demo_tab_first_a"};
    NSDictionary * dic9 = @{@"Title":@"驾考指南", @"ImageName":@"demo_tab_first_a"};
    NSDictionary * dic10 = @{@"Title":@"智能推荐", @"ImageName":@"demo_tab_first_a"};
    fisrtData.itemsForA = @[dic1,dic2,dic3,dic4,dic5,dic6,dic7,dic8,dic9,dic10];
    
    // for b
    
    FirstTabData * secondData = [FirstTabData new];
    secondData.cellType = FirstTableCellType_B;
    secondData.tableCell_Height = 80;
    secondData.customerCount = 23129763;
    
    // for c
    
    FirstTabData * thirdData = [FirstTabData new];
    thirdData.cellType = FirstTableCellType_C;
    thirdData.tableCell_Height = 60;
    
    NSDictionary * adDic1 = @{@"SchoolName":@"建安驾校", @"ADInfo":@"限时报名，学费立减1000元"};
    NSDictionary * adDic2 = @{@"SchoolName":@"申通驾校", @"ADInfo":@"限时报名，学费立减300元"};
    NSDictionary * adDic3 = @{@"SchoolName":@"高发驾校", @"ADInfo":@"限时报名，学费立减500元"};
    NSDictionary * adDic4 = @{@"SchoolName":@"光明驾校分校", @"ADInfo":@"限时报名，学费立减600元"};
    NSDictionary * adDic5 = @{@"SchoolName":@"建设驾校光谷基地分校", @"ADInfo":@"限时报名，学费立减800元"};
    thirdData.adsArray = @[adDic1,adDic2,adDic3,adDic4,adDic5];
    
    // for d
    
    FirstTabData * fouthData = [FirstTabData new];
    fouthData.cellType = FirstTableCellType_D;
    fouthData.sortMode = 0;
    fouthData.tableCell_Height = 50;

    // for e
    
    FirstTabData * fifthData = [FirstTabData new];
    fifthData.cellType = FirstTableCellType_E;
    fifthData.tableCell_Height = 172;
    
    NSDictionary * sdic1 = @{@"SchoolImageName":@"shunan_school",
                             @"TagImageName":@"pingpai_logo",
                             @"SchoolName":@"顺安驾校",
                             @"HasV":@(YES),
                             @"HasM":@(YES),
                             @"Score":@(4.7),
                             @"Honour":@"综合排名第1名",
                             @"Price":@(5880),
                             @"Type":@"C1",
                             @"Sclass":@"速成班",
                             @"Location":@"松江区",
                             @"Distance":@(574),
                             @"Comment":@"规模大 有接送 约课方便 自有考场",
                             @"Discount":@(300),
                             @"TryLearn":@(1),
    };
    fifthData.schoolDic = sdic1;
    if ([sdic1[@"Discount"] integerValue] == 0) {
        fifthData.tableCell_Height -= 30;
    }
    if ([sdic1[@"TryLearn"] integerValue] == 0) {
        fifthData.tableCell_Height -= 30;
    }
    
    FirstTabData * sixthData = [FirstTabData new];
    sixthData.cellType = FirstTableCellType_E;
    sixthData.tableCell_Height = 172;
    NSDictionary * sdic2 = @{@"SchoolImageName":@"shunan_school",
                             @"TagImageName":@"remen_logo",
                             @"SchoolName":@"建安驾校新安基地分校",
                             @"HasV":@(YES),
                             @"HasM":@(YES),
                             @"Score":@(5),
                             @"Honour":@"综合排名第2名",
                             @"Price":@(5880),
                             @"Type":@"C1",
                             @"Sclass":@"速成班",
                             @"Location":@"松江区",
                             @"Distance":@(374),
                             @"Comment":@"规模大 有接送 约课方便 自有考场",
                             @"Discount":@(0),
                             @"TryLearn":@(1),
    };
    sixthData.schoolDic = sdic2;
    if ([sdic2[@"Discount"] integerValue] == 0) {
        sixthData.tableCell_Height -= 30;
    }
    if ([sdic2[@"TryLearn"] integerValue] == 0) {
        sixthData.tableCell_Height -= 30;
    }

    FirstTabData * seven7Data = [FirstTabData new];
    seven7Data.cellType = FirstTableCellType_E;
    seven7Data.tableCell_Height = 172;
    NSDictionary * sdic3 = @{@"SchoolImageName":@"shunan_school",
                             @"TagImageName":@"pingpai_logo",
                             @"SchoolName":@"申通驾校",
                             @"HasV":@(NO),
                             @"HasM":@(NO),
                             @"Score":@(4.7),
                             @"Honour":@"综合排名第3名",
                             @"Price":@(5880),
                             @"Type":@"C1",
                             @"Sclass":@"速成班",
                             @"Location":@"松江区",
                             @"Distance":@(1574),
                             @"Comment":@"规模大 有接送 约课方便 自有考场",
                             @"Discount":@(300),
                             @"TryLearn":@(1),
    };
    seven7Data.schoolDic = sdic3;
    if ([sdic3[@"Discount"] integerValue] == 0) {
        seven7Data.tableCell_Height -= 30;
    }
    if ([sdic3[@"TryLearn"] integerValue] == 0) {
        seven7Data.tableCell_Height -= 30;
    }
    
    //
    _tableDatasArray = @[fisrtData, secondData, thirdData, fouthData, fifthData,
                         sixthData, seven7Data];
    [self p_sortWithScore];
}

#pragma mark - table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return MAX(0, _tableDatasArray.count);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FirstTabData * data = _tableDatasArray[indexPath.row];

    if (data.cellType == FirstTableCellType_A) {
        FirstTabForACell * cell = [tableView dequeueReusableCellWithIdentifier:FirstTabCellForA_Identifier
        forIndexPath:indexPath];
        
        cell.cellData = data;
        [cell reloadCellCollectionView];
        
        return cell;
    } else if (data.cellType == FirstTableCellType_B) {
        FirstTabForBCell * cell = [tableView dequeueReusableCellWithIdentifier:FirstTabCellForB_Identifier
        forIndexPath:indexPath];
        cell.cellData = data;
        [cell updateCustomerCount];
        return cell;
    } else if (data.cellType == FirstTableCellType_C) {
        FirstTabForCCell * cell = [tableView dequeueReusableCellWithIdentifier:FirstTabCellForC_Identifier forIndexPath:indexPath];
        cell.cellData = data;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [cell updateSchoolADShow];
        });
        return cell;
    } else if (data.cellType == FirstTableCellType_D) {
        FirstTabForDCell * cell = [tableView dequeueReusableCellWithIdentifier:FirstTabCellForD_Identifier forIndexPath:indexPath];
        cell.cellData = data;
        [cell updateCurrentSortMode];
        return cell;
    } else if (data.cellType == FirstTableCellType_E) {
        FirstTabForECell * cell = [tableView dequeueReusableCellWithIdentifier:FirstTabCellForE_Identifier forIndexPath:indexPath];
        cell.cellData = data;
        [cell loadSchoolInfoOnCell];
        return cell;
    }

    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    FirstTabData * data = _tableDatasArray[indexPath.row];
    if (data) {
        return data.tableCell_Height;
    }
    return 50;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.tableView reloadData];
    NSLog(@"apperar11111");
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    float cur = scrollView.contentOffset.y;
    if (cur >= self.scrollOffsetY) {
        self.topControlConstraintBottom.constant = 0;
    } else {
        self.topControlConstraintBottom.constant = -50;
    }
    
   // if (cur > self.scrollOffsetY-100 && cur < self.scrollOffsetY+100) {
//        [UIView animateWithDuration:0 animations:^{
//            __strong typeof(self) strongSelf = weakSelf;
//
//            if (cur >= strongSelf.scrollOffsetY) {
//                strongSelf.topControlConstraintBottom.constant = 0;
//            } else {
//                strongSelf.topControlConstraintBottom.constant = -50;
//            }
//        }];
   // }

}
#pragma mark -

- (void)changeTopToLocationSearchMode {
    CGRect rect = _topControlView.frame;
  //  rect.origin.y = -50;
    _topControlView.frame = rect;
    
    _topControlConstraintBottom.constant = -50;
}

#pragma mark - controllers

- (void)showChooseSchoolViewController {

    if (self.chooseSchoolController == nil) {
        self.chooseSchoolController = [ChooseSchoolViewController new];
    }
    [self.navigationController pushViewController:self.chooseSchoolController animated:YES];
}


- (void)closeChooseSchoolViewController {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - sort


- (void)reloadTableViewWhenSortChanged {
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = @"加载中...";
    hud.animationType = MBProgressHUDAnimationZoomIn;
    [self.view addSubview:hud];
    
    [hud showAnimated:YES];
    
    __weak typeof(self) weakSelf = self;
     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
          __strong typeof(self) strongSelf = weakSelf;
         // 移除HUD
         [hud hideAnimated:YES];
         [hud removeFromSuperview];
         
         FirstTabData * data = strongSelf.tableDatasArray[3];
         NSInteger sortMode = data.sortMode;
         switch (sortMode) {
             case 0:  // 推荐
                 [strongSelf p_sortWithScore];
                 break;
             case 1:  // 距离
                 [strongSelf p_sortWithDistance];
                 break;
             case 2:  // 合格率
                 break;
             case 3:  // 足迹
                 break;
             case 4:  // 筛选
                 break;
             default:
                 break;
         }
         
         [strongSelf.tableView reloadData];
     });

}

- (void)p_sortWithDistance {
    NSMutableArray * array = [_tableDatasArray mutableCopy];
    NSArray * firstArray = [array subarrayWithRange:NSMakeRange(0, 4)];
    NSArray * secondArray = [array subarrayWithRange:NSMakeRange(4, array.count-4)];
    NSMutableArray * resultAry = [NSMutableArray arrayWithArray:[secondArray sortedArrayUsingDescriptors:[NSSortDescriptor sortDescriptorsWithKeys:@[@"schoolDic.Distance"]]]];
    NSMutableArray * newArray = [NSMutableArray arrayWithArray:firstArray];
    [newArray addObjectsFromArray:resultAry];
    _tableDatasArray = newArray;
}

- (void)p_sortWithScore {
    NSMutableArray * array = [_tableDatasArray mutableCopy];
    NSArray * firstArray = [array subarrayWithRange:NSMakeRange(0, 4)];
    NSArray * secondArray = [array subarrayWithRange:NSMakeRange(4, array.count-4)];
    NSMutableArray * resultAry = [NSMutableArray arrayWithArray:[secondArray sortedArrayUsingDescriptors:[NSSortDescriptor sortDescriptorsDescendingWithKeys:@[@"schoolDic.Score"]]]];
    NSMutableArray * newArray = [NSMutableArray arrayWithArray:firstArray];
    [newArray addObjectsFromArray:resultAry];
    _tableDatasArray = newArray;
}

#pragma mark - search

- (void)showDefaultSearchSchoolName {
    [self updateLabelFrameOnContainer];
    
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        __strong typeof(self) strongSelf = weakSelf;
        CGRect toRect = strongSelf.searchDefaultNameContainerView.bounds;
        CGRect oldRect = toRect;
        toRect.origin.y -= toRect.size.height;
        [UIView animateWithDuration:0.5 animations:^{
            strongSelf.firstSearachLabel.frame = toRect;
            strongSelf.secondSearachLabel.frame = oldRect;
        } completion:^(BOOL finished) {
            strongSelf.currentShowSearchIndex ++;
            [strongSelf showDefaultSearchSchoolName];
        }];
    });
}
- (NSArray *)showSearchArray {
    return @[@"申通驾校",@"武汉驾校",@"建安驾校新安基地分校",@"汉口驾校"];
}

- (void)updateLabelFrameOnContainer {
    CGRect frame = _searchDefaultNameContainerView.bounds;
    _firstSearachLabel.frame = frame;
    
    CGRect secondFrame = frame;
    secondFrame.origin.y += frame.size.height;
    _secondSearachLabel.frame = secondFrame;

    // 更新
    _currentShowSearchIndex %= self.showSearchArray.count;
    
    NSInteger current = _currentShowSearchIndex;
    // 显示view
    _firstSearachLabel.text = self.showSearchArray[current];

    // 后备view
    NSInteger next = (_currentShowSearchIndex+1)%self.showSearchArray.count;
    _secondSearachLabel.text = self.showSearchArray[next];
}

@end
