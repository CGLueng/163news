//
//  LCGNewsController.m
//  网易新闻
//
//  Created by Wistaria on 16/4/25.
//  Copyright © 2016年 Wistaria. All rights reserved.
//

#import "LCGNewsController.h"
#import "LCGNewsModel.h"

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

@end
