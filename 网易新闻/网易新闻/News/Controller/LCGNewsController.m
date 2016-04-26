//
//  LCGNewsController.m
//  网易新闻
//
//  Created by Wistaria on 16/4/25.
//  Copyright © 2016年 Wistaria. All rights reserved.
//

#import "LCGNewsController.h"
#import "LCGNewsModel.h"
#import "LCGNewsCell.h"

@interface LCGNewsController ()
@property (nonatomic,strong) NSArray *data;

@end

@implementation LCGNewsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
}

- (void)loadData {

    [LCGNewsModel newsDatasWithURL:@"article/headline/T1348647853363/0-20.html" success:^(NSArray *news) {
        self.data = news;
        
        [self.tableView reloadData];
    }];
}

#pragma mark - 代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LCGNewsModel *news = self.data[indexPath.row];
    
    NSString *ID = [LCGNewsCell cellIdentiferWithNews:news];
    LCGNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    cell.news = news;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    LCGNewsModel *model = self.data[indexPath.row];
    return [LCGNewsCell cellHeightWithNews:model];
}
@end
