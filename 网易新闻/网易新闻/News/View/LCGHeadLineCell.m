//
//  LCGHeadLineCell.m
//  网易新闻
//
//  Created by Wistaria on 16/4/22.
//  Copyright © 2016年 Wistaria. All rights reserved.
//

#import "LCGHeadLineCell.h"
#import "LCGHeadLineModel.h"
#import <UIImageView+WebCache.h>

@interface LCGHeadLineCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation LCGHeadLineCell
- (void)setHeadline:(LCGHeadLineModel *)headline {

    _headline = headline;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:headline.imgsrc]];
}
@end
