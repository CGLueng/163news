//
//  LCGHomeController.m
//  网易新闻
//
//  Created by Wistaria on 16/4/26.
//  Copyright © 2016年 Wistaria. All rights reserved.
//

#import "LCGHomeController.h"
#import "LCGChannelModel.h"
#import "LCGChannelLabel.h"
#import "LCGChannelNewsCell.h"
#import "LCGNewsController.h"

@interface LCGHomeController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;
@property (nonatomic,strong) NSArray *channels;
@property (nonatomic,assign) NSInteger currentPage;
@property (nonatomic,strong) NSMutableDictionary *newsVCCache;
@end

@implementation LCGHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self loadChannelData];
    
}

- (void)viewDidLayoutSubviews {
    
    [self setupView];
}

- (void)setupView {
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    self.layout.itemSize = self.collectionView.bounds.size;
    
    self.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.layout.minimumLineSpacing = 0;
    
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    self.collectionView.pagingEnabled = YES;
    
    self.collectionView.bounces = NO;
}

- (void)loadChannelData {
    
    NSArray *channels = [LCGChannelModel channelDatas];
    
    channels = [channels sortedArrayUsingComparator:^NSComparisonResult(LCGChannelModel *  _Nonnull obj1, LCGChannelModel *  _Nonnull obj2) {
        return [obj1.tid compare:obj2.tid];
    }];
    
    __block CGFloat labelX = 0;
    
    [channels enumerateObjectsUsingBlock:^(LCGChannelModel *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGFloat labelY = 0;
        
        CGFloat labelH = self.scrollView.bounds.size.height;
        
        LCGChannelLabel *label = [LCGChannelLabel channelLabelWithTitle:obj.tname];
        
        CGFloat labelW = label.bounds.size.width;
        
        label.frame = CGRectMake(labelX, labelY, labelW, labelH);
        
        
        __weak typeof(label) weakLabel = label;
        
        __weak typeof(self) weakSelf = self;
        [label setClickChannel:^{
            //            NSLog(@"%@",weakLabel.text);
            
            [weakSelf.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:idx inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
            
            LCGChannelLabel *currentLabel = weakSelf.scrollView.subviews[weakSelf.currentPage];
            
            currentLabel.scale = 0;
            
            weakLabel.scale = 1;
            
            weakSelf.currentPage = idx;
            
            [self adjScrollViewContentoffset];
        }];
        
        [self.scrollView addSubview:label];
        
        labelX += labelW;
        
        if (idx == 0) {
            label.scale = 1;
        }
        
    }];
    
    self.scrollView.contentSize = CGSizeMake(labelX, 0);
    
    self.channels = channels;
    
    [self.collectionView reloadData];
}

- (void)adjScrollViewContentoffset {

    LCGChannelLabel *channel = self.scrollView.subviews[self.currentPage];
    
    CGFloat offsetX = channel.center.x - CGRectGetWidth(self.scrollView.frame) * 0.5;
    
    if (offsetX < 0) {
        offsetX = 0;
    }
    
    CGFloat maxOffsetX = self.scrollView.contentSize.width - CGRectGetWidth(self.scrollView.frame);
    
    if (offsetX > maxOffsetX) {
        offsetX = maxOffsetX;
    }
    
    [self.scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

#pragma mark - collectionView 代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.channels.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LCGChannelNewsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LCGChannelNewsCell" forIndexPath:indexPath];
    
    [cell.news.view removeFromSuperview];
    
    LCGChannelModel *channel = self.channels[indexPath.item];
    
    LCGNewsController *news = [self newsControllerWithChannel:channel];
    if (![self.childViewControllers containsObject:news]) {
        
        [self addChildViewController:news];
    }
    
    news.view.frame = cell.contentView.bounds;
    
    [cell.contentView addSubview:news.view];
    
    //    cell.channel = channel;
    cell.news = news;
    return cell;
}

- (LCGNewsController *)newsControllerWithChannel:(LCGChannelModel *)channel {
    
    LCGNewsController *news = [self.newsVCCache objectForKey:channel.tid];
    
    if (news == nil) {
        
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"News" bundle:nil];
        
        news = [sb instantiateInitialViewController];
        
        news.channelId = channel.tid;
        
        [self.newsVCCache setObject:news forKey:channel.tid];
    }
    return news;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    LCGChannelLabel *currentChannel = self.scrollView.subviews[self.currentPage];
    
    __block LCGChannelLabel *nextChannel;
    
    NSArray *indexPaths = [self.collectionView indexPathsForVisibleItems];
    
    [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (obj.item != self.currentPage) {
            nextChannel = self.scrollView.subviews[obj.item];
        }
    }];
    
    if (nextChannel == nil) {
        NSLog(@"没有下一个频道");
        return;
    }
    
    CGFloat offsetX = scrollView.contentOffset.x;
    
    CGFloat scale = ABS(offsetX / scrollView.bounds.size.width - self.currentPage);
    
    CGFloat currentScale = 1- scale;
    
    nextChannel.scale = scale;
    
    currentChannel.scale = currentScale;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    CGFloat offsetX = scrollView.contentOffset.x;
    
    self.currentPage = (NSInteger)offsetX / scrollView.bounds.size.width;
    
    [self adjScrollViewContentoffset];
}

- (NSMutableDictionary *)newsVCCache
{
    
    if (_newsVCCache == nil) {
        _newsVCCache = [NSMutableDictionary dictionary];
    }
    return _newsVCCache;
}
@end
