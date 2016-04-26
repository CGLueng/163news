//
//  LCGChannelModel.h
//  网易新闻
//
//  Created by Wistaria on 16/4/26.
//  Copyright © 2016年 Wistaria. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCGChannelModel : NSObject
@property (nonatomic ,copy) NSString *tname;
@property (nonatomic ,copy) NSString *tid;

+ (NSArray *)channelDatas;
@end
