//
//  LCGHeadLineController.m
//  网易新闻
//
//  Created by Wistaria on 16/4/22.
//  Copyright © 2016年 Wistaria. All rights reserved.
//

#import "LCGHeadLineController.h"
#import "LCGHeadLineCell.h"
#import "LCGHeadLineModel.h"

@interface LCGHeadLineController ()
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;
@property (nonatomic,strong) NSArray *data;
@end

@implementation LCGHeadLineController

static NSString * const reuseIdentifier = @"HeadLine";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
    [self loadData];
}

/** 加载头条数据 */
- (void)loadData {
    [LCGHeadLineModel headLineDatasWithURL:@"ad/headline/0-4.html" success:^(NSArray *headline) {
        NSMutableArray *tempData = [NSMutableArray arrayWithArray:headline];
        [tempData insertObject:[headline lastObject] atIndex:0];
        [tempData addObject:[headline firstObject]];
        self.data = tempData.copy;
        [self.collectionView reloadData];
        
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    }];
}

/** 设置View 的布局和其他样式 */
- (void)setupView {
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    self.layout.itemSize = self.collectionView.bounds.size;
    
    self.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.layout.minimumLineSpacing = 0;
    
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    self.collectionView.pagingEnabled = YES;
    
    self.collectionView.bounces = NO;
}

#pragma mark - 代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LCGHeadLineCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.tag = indexPath.item - 1;
    
    cell.headline = self.data[indexPath.item];
    
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

    NSInteger index = scrollView.contentOffset.x / self.collectionView.bounds.size.width;
    
    if (index == self.data.count - 1) {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    }else if (index == 0) {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.data.count - 2 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    }

}

@end
