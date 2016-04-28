//
//  LCGHeadLineCell.m
//  网易新闻
//
//  Created by Wistaria on 16/4/22.
//  Copyright © 2016年 Wistaria. All rights reserved.
//

#import "LCGHeadLineCell.h"
#import "LCGHeadLineModel.h"
#import "LCGNewsModel.h"
#import <UIImageView+WebCache.h>

@interface LCGHeadLineCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation LCGHeadLineCell
/**
 *  重写 set 方法
 *
 *  @param headline 传进一个 headline 模型
 */
- (void)setHeadline:(LCGHeadLineModel *)headline {

    _headline = headline;
    //用第三方框架<UIImageView+WebCache.h>的方法下载图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:headline.imgsrc]];
}


@end
