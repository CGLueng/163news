//
//  LCGNewsCell.h
//  网易新闻
//
//  Created by Wistaria on 16/4/26.
//  Copyright © 2016年 Wistaria. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LCGNewsModel;

@interface LCGNewsCell : UITableViewCell
//新闻模型
@property (nonatomic,strong) LCGNewsModel *news;
///  返回cell的重用id
///
///  @param news 模型
///
///  @return 重用Id
+ (NSString *)cellIdentiferWithNews:(LCGNewsModel *)news;
///  返回cell的高度
///
///  @param news 模型
///
///  @return cell的高度
+ (CGFloat)cellHeightWithNews:(LCGNewsModel *)news;
@end
