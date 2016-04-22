//
//  LCGHeadLineController.m
//  网易新闻
//
//  Created by Wistaria on 16/4/22.
//  Copyright © 2016年 Wistaria. All rights reserved.
//

#import "LCGHeadLineController.h"
#import "LCGHeadLineCell.h"
#import "LCGApiManager.h"

@interface LCGHeadLineController ()
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;

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
    [[LCGApiManager sharedApi]requestWithURL:@"ad/headline/0-4.html" success:^(id responseObject) {
        NSLog(@"成功%@",responseObject);
    } error:^(NSError *errorInfo) {
        NSLog(@"错误%@",errorInfo);
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
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LCGHeadLineCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
    
    return cell;
}


@end
