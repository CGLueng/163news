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
//自动布局属性
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;
//collectionview 的数据
@property (nonatomic,strong) NSArray *data;
//collectionview
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
//标题
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
//分页
@property (weak, nonatomic) IBOutlet UIPageControl *pageControll;
@end

@implementation LCGHeadLineController
//注册 cell 的 id
static NSString * const reuseIdentifier = @"HeadLine";

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self setupView];
//    加载数据
    [self loadData];
}
/**
 *  在此处设置 view 的样式可以避免一些错误
 */
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
//    设置 collectionView 的样式
    [self setupView];
}
/** 加载头条数据 */
- (void)loadData {
    [LCGHeadLineModel headLineDatasWithURL:@"ad/headline/0-4.html" success:^(NSArray *headline) {
//        用可变数组记录headline
        NSMutableArray *tempData = [NSMutableArray arrayWithArray:headline];
//        在前面添加最后一个元素
        [tempData insertObject:[headline lastObject] atIndex:0];
//        在后面添加第一个元素
        [tempData addObject:[headline firstObject]];
//        赋值给 data
        self.data = tempData.copy;
//        self.data = headline;
        //刷新界面
        [self.collectionView reloadData];
//         设置跳转到第一页（第二个元素是第一页）
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
//        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:5000] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
//        设置分页控件的页数
        self.pageControll.numberOfPages = headline.count;
//         调用方法跳到第一页
        [self scrollViewDidEndDecelerating:self.collectionView];
    }];
}

/** 设置View 的布局和其他样式 */
- (void)setupView {
     //设置控制器背景色
    self.collectionView.backgroundColor = [UIColor whiteColor];
     //设置 item 的大小
    self.layout.itemSize = self.collectionView.bounds.size;
     //设置水平滚动
    self.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
     //设置 item 的最小间隙
    self.layout.minimumLineSpacing = 0;
     //设置隐藏滚动条
    self.collectionView.showsHorizontalScrollIndicator = NO;
     //设置自动分页
    self.collectionView.pagingEnabled = YES;
     //设置取消弹簧效果
    self.collectionView.bounces = NO;
}

#pragma mark - 代理方法
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//
//    return 10000;
//}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    创建自定义 item
    LCGHeadLineCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
//    设置 tag 值，用于无限滚动标识
    cell.tag = indexPath.item - 1;
//    cell.tag = indexPath.item;
//    设置头条数据
    cell.headline = self.data[indexPath.item];
    
    return cell;
}

/**
 *  滚动结束时候判断当前在第几张
 *
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    获得当前的页数，用滚动的 offsetX 来计算
    NSInteger index = scrollView.contentOffset.x / self.collectionView.bounds.size.width;
//    设置当前页
    self.pageControll.currentPage = index - 1;
//    判断是滚动到最后一个元素时候，就跳到最前面
    if (index == self.data.count - 1) {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        self.pageControll.currentPage = 0;
    }else if (index == 0) { //判断是滚动到最前面时候，就跳到最后面
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.data.count - 2 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        self.pageControll.currentPage = self.data.count - 2;
    }
//    取出模型数据
    LCGHeadLineModel *headline = self.data[index];
//    滚动结束时候更新 label 的文字
    self.titleLabel.text = headline.title;

}

@end
