//
//  FirstTabForACell.m
//  JKApp
//
//  Created by Apple on 2020/2/20.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "FirstTabForACell.h"
#import "FirstTabACollectionViewCell.h"

@interface FirstTabForACell () <UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

- (FirstTabData *)currentData;
- (NSArray *)sourceArray;

@end

@implementation FirstTabForACell

- (void)awakeFromNib {
    [super awakeFromNib];
    
  //  self.collectionView.backgroundColor = [UIColor redColor];
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    CGRect frame = [UIScreen mainScreen].bounds;
    layout.itemSize = CGSizeMake(frame.size.width/5.0-1, 80);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(5, 0, 5, 0);
    self.collectionView.collectionViewLayout = layout;
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([FirstTabACollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"firsttabacollectioncell"];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)reloadCellCollectionView {
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView reloadData];
}

- (FirstTabData *)currentData {
    if (self.cellData.cellType == FirstTableCellType_A) {
        return self.cellData;
    }
    return nil;
}
- (NSArray *)sourceArray {
    if (self.currentData) {
        return self.currentData.itemsForA;
    }
    return nil;
}

#pragma mark - collection view delegate


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.sourceArray.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
        
    FirstTabACollectionViewCell *cell = [self.collectionView
                            dequeueReusableCellWithReuseIdentifier:@"firsttabacollectioncell"
                            forIndexPath:indexPath];
    
    NSDictionary * dic = self.sourceArray[indexPath.row];
    
    [cell setImage:[UIImage imageNamed:dic[@"ImageName"]]];
    [cell setTitle:dic[@"Title"]];
    return cell;
}


//定义每个UICollectionView 的大小


//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return CGSizeMake((80-20-15)/4.0f, 80/4.0f-5);
//}
//
////定义每个UICollectionView 的间距
//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(5, 10, 5, 10);
//}
//
////每个item之间的间距
//- (CGFloat)collectionView:(UICollectionView *)collectionView
//                   layout:(UICollectionViewLayout*)collectionViewLayout
//minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 2;
//}


////动态设置每列的间距大小
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
//    return 1.0f;
//}

//
//UICollectionView被选中时调用的方法
//-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    NTSubscribeModel *model = self.serviceListArr[indexPath.row];
//    if(self.newOfficeServiceWasSelect){
//        self.newOfficeServiceWasSelect(model, indexPath.row, self);
//    }
//}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"select = %ld",indexPath.row);
}

@end
