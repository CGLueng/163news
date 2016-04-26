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
@property (nonatomic,strong) LCGNewsModel *news;
+ (NSString *)cellIdentiferWithNews:(LCGNewsModel *)news;
+ (CGFloat)cellHeightWithNews:(LCGNewsModel *)news;
@end
