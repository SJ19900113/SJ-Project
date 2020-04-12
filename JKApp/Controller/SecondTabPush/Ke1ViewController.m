//
//  Ke1ViewController.m
//  JKApp
//
//  Created by Apple on 2020/3/2.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "Ke1ViewController.h"
#import "SecondTabACell.h"
#import "ControllerFunc.h"
#import "SecondViewController.h"
#import "SecondTabData.h"
#import "SecondTabACell.h"
#import "SecondADViewController.h"
#import "SecondTabBCell.h"

static NSString * SecondTabCellForA_Identifier = @"secondtabfora";
static NSString * SecondTabCellForB_Identifier = @"secondtabforb";

@interface Ke1ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView * tableView;
@property (strong, nonatomic) NSMutableArray * sourceArray;

- (NSArray *)tableSourceArray;

@end

@implementation Ke1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTable];
    
    //  cells
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SecondTabACell class]) bundle:nil] forCellReuseIdentifier:@"secondtabfora"];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SecondTabBCell class]) bundle:nil] forCellReuseIdentifier:@"secondtabforb"];
}

- (void)initTable {
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.allowsSelection = NO;
    [self.view addSubview:_tableView];
}

- (NSArray *)tableSourceArray {
    return [ControllerFunc secondController].tableSourceArray;
}

#pragma mark - tableview

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return MAX(0, self.tableSourceArray.count);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SecondTabData * data = self.tableSourceArray[indexPath.row];

    if (data.cellType == SecondTableCellType_A) {
        SecondTabACell * cell = [tableView dequeueReusableCellWithIdentifier:SecondTabCellForA_Identifier
        forIndexPath:indexPath];
        
        cell.cellData = data;
        [cell reloadCellScrollView];
        return cell;
    } else if (data.cellType == SecondTableCellType_B) {
        SecondTabBCell * cell = [tableView dequeueReusableCellWithIdentifier:SecondTabCellForB_Identifier
        forIndexPath:indexPath];
        [cell startVipImageViewAnimation];
        return cell;
    }

    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    SecondTabData * data = self.tableSourceArray[indexPath.row];
    if (data) {
        return data.tableCell_Height;
    }
    return 50;
}


#pragma mark - controllers

- (void)showSecondADViewControllerWithADIndex:(NSInteger)index {
    if (self.secondADController == nil) {
        self.secondADController = [SecondADViewController new];
    }
    self.secondADController.adIndex = index;
    [self.navigationController pushViewController:self.secondADController animated:YES];
}

- (void)closeSecondADViewController {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
