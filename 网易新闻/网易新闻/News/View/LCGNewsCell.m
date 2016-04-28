//
//  LCGNewsCell.m
//  网易新闻
//
//  Created by Wistaria on 16/4/26.
//  Copyright © 2016年 Wistaria. All rights reserved.
//

#import "LCGNewsCell.h"
#import "LCGNewsModel.h"
#import "LCGNewsImageModel.h"
#import <UIImageView+WebCache.h>

@interface LCGNewsCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *digestLabel;
@property (weak, nonatomic) IBOutlet UILabel *replyCountLabel;
//多个图片视图
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imgextra;

@end

@implementation LCGNewsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
/** 重写 set 方法对 cel 中的控件设置值 */
- (void)setNews:(LCGNewsModel *)news {
    _news = news;
    //设置图片，注意选用枚举值：滑动时候不加载，加载失败重新加载两个功能
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:news.imgsrc]placeholderImage:nil options:SDWebImageRetryFailed | SDWebImageLowPriority];
     //设置标题
    self.titleLabel.text = news.title;
    //设置简介
    self.digestLabel.text = news.digest;
    //设置跟帖数
    self.replyCountLabel.text = [NSString stringWithFormat:@"%@人跟帖",news.replyCount];
    //判断是否有更多图片
    if (news.imgextra != nil) {
        //设置更多图片，遍历数组
        [self.imgextra enumerateObjectsUsingBlock:^(UIImageView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            //取出数组数据，放到图片模型中
            LCGNewsImageModel *model = news.imgextra[idx];
            //加载图片
            [obj sd_setImageWithURL:[NSURL URLWithString:model.imgsrc]placeholderImage:nil options:SDWebImageRetryFailed | SDWebImageLowPriority];
        }];
    }
}
 /** 设置该重用哪一个 cell */
+ (NSString *)cellIdentiferWithNews:(LCGNewsModel *)news {
    
    if (news.imgextra != nil) {
        return @"LCGMoreImageCell";
    }else if (news.imgType == 1) {
        return @"LCGBigImageCell";
    }else {
        return @"LCGNewsCell";
    }
}
/** 设置 cell 的高度 */
+ (CGFloat)cellHeightWithNews:(LCGNewsModel *)news {

    if (news.imgextra != nil) {
        return 150;
    }else if (news.imgType == 1) {
        return 180;
    }else {
        return 81;
    }
}
@end
