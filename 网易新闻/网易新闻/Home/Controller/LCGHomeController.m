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

@interface LCGHomeController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;
@property (nonatomic,strong) NSArray *channels;
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
        
        
//        __weak typeof(label) weakLabel = label;
        
        __weak typeof(self) weakSelf = self;
        [label setClickChannel:^{
//            NSLog(@"%@",weakLabel.text);
            
            [weakSelf.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:idx inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        }];
        
        [self.scrollView addSubview:label];
        
        labelX += labelW;

    }];
    
    self.scrollView.contentSize = CGSizeMake(labelX, 0);
    
    self.channels = channels;
    
    [self.collectionView reloadData];
}

#pragma mark - collectionView 代理方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.channels.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LCGChannelNewsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LCGChannelNewsCell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
    
    cell.channel = self.channels[indexPath.item];
    return cell;
}
@end
