//
//  LCGChannelModel.m
//  网易新闻
//
//  Created by Wistaria on 16/4/26.
//  Copyright © 2016年 Wistaria. All rights reserved.
//

#import "LCGChannelModel.h"
#import <YYModel.h>

@implementation LCGChannelModel
+ (NSArray *)channelDatas {
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"topic_news.json" ofType:nil];
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    
    NSString *key = result.keyEnumerator.nextObject;
    
    NSArray *array = result[key];
    
    return [NSArray yy_modelArrayWithClass:self json:array];
}
@end
