//
//  LCGApiManager.m
//  网易新闻
//
//  Created by Wistaria on 16/4/22.
//  Copyright © 2016年 Wistaria. All rights reserved.
//

#import "LCGApiManager.h"
#import "LCGHTTPManager.h"

@implementation LCGApiManager
+ (instancetype)sharedApi {

    static dispatch_once_t onceToken;
    static id instance;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
    });
    return instance;
}

- (void)requestWithURL:(NSString *)url success:(void (^)(id))success error:(void (^)(NSError *))error {

    [[LCGHTTPManager sharedManager]GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull errorInfo) {
        if (error) {
            error(errorInfo);
        }
    }];
}
@end
