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

- (void)setNews:(LCGNewsModel *)news {
    _news = news;
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:news.imgsrc]];
    
    self.titleLabel.text = news.title;
    
    self.digestLabel.text = news.digest;
    
    self.replyCountLabel.text = [NSString stringWithFormat:@"%@人跟帖",news.replyCount];
    
    if (news.imgextra != nil) {
        [self.imgextra enumerateObjectsUsingBlock:^(UIImageView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            LCGNewsImageModel *model = news.imgextra[idx];
            [obj sd_setImageWithURL:[NSURL URLWithString:model.imgsrc]];
        }];
    }
}

+ (NSString *)cellIdentiferWithNews:(LCGNewsModel *)news {
    
    if (news.imgextra != nil) {
        return @"LCGMoreImageCell";
    }else if (news.imgType == 1) {
        return @"LCGBigImageCell";
    }else {
        return @"LCGNewsCell";
    }
}

+ (CGFloat)cellHeightWithNews:(LCGNewsModel *)news {

    if (news.imgextra != nil) {
        return 130;
    }else if (news.imgType == 1) {
        return 150;
    }else {
        return 81;
    }
}
@end
