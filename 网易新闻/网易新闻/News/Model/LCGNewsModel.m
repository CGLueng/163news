//
//  LCGNewsModel.m
//  网易新闻
//
//  Created by Wistaria on 16/4/25.
//  Copyright © 2016年 Wistaria. All rights reserved.
//

#import "LCGNewsModel.h"
#import "LCGApiManager.h"
#import <YYModel.h>
#import "LCGNewsImageModel.h"

@implementation LCGNewsModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"imgextra" : [LCGNewsImageModel class]
             };
}

+ (void)newsDatasWithURL:(NSString *)url success:(void(^)(NSArray *news))success {
    NSAssert(success != nil, @"回调不能为空");
    [[LCGApiManager sharedApi]requesNewstWithURL:url success:^(NSDictionary *responseObject) {
        NSString *key = responseObject.keyEnumerator.nextObject;
        
        NSData *data = responseObject[key];
        
        NSArray *tmp = [NSArray yy_modelArrayWithClass:self json:data];
//        NSLog(@"%@",tmp);
        NSMutableArray *news = [NSMutableArray arrayWithArray:tmp];
        
//        [news removeObjectAtIndex:0];
        
        success(news);
    } error:^(NSError *errorInfo) {
        success(nil);
    }];
}

@end
