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
#import "LCGDetailNewsController.h"


@interface LCGNewsController ()
//新闻数据
@property (nonatomic,strong) NSArray *data;

@end

@implementation LCGNewsController

- (void)viewDidLoad {
    [super viewDidLoad];
    //加载数据
    [self loadData];
}

/** 加载数据，关联了 refreshController ，能下来时候调用此方法 */
- (IBAction)loadData {
    //调用模型中获取新闻的方法，传入频道的 id 进行拼接
    [LCGNewsModel newsDatasWithURL:[NSString stringWithFormat:@"article/headline/%@/0-20.html",self.channelId] success:^(NSArray *news) {
        //接受成功后返回的数据
        self.data = news;
         //刷新界面
        [self.tableView reloadData];
    }];
     //结束refreshController的滚动
    [self.refreshControl endRefreshing];
}

#pragma mark - 代理方法
/** 返回多少行 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}
/** 返回怎样的 cell */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //获取当前模型数据
    LCGNewsModel *news = self.data[indexPath.row];
    //根据模型中的数据判断使用哪一个 cell 的 id 来进行重用
    NSString *ID = [LCGNewsCell cellIdentiferWithNews:news];
    //重用 cell
    LCGNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    //设置数据
    cell.news = news;
    
    return cell;
}
/** 设置 cell 的高度 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //取出模型
    LCGNewsModel *model = self.data[indexPath.row];
    //根据模型中的数据判断 cell 的高度，并返回高度
    return [LCGNewsCell cellHeightWithNews:model];
}
/** 点击cell 跳转到新闻详情页 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
     //取出当前模型的数据
    LCGNewsModel *news = self.data[indexPath.row];
    //创建新闻详情页控制器
    LCGDetailNewsController *detail = [[LCGDetailNewsController alloc]init];
    //设置详情页的 URL
    detail.newsURL = news.fullURL;
    //push 到详情页
    [self.navigationController pushViewController:detail animated:YES];
}
@end
