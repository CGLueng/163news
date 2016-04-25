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

- (void)requestHeadLineWithURL:(NSString *)url success:(void (^)(id))success error:(void (^)(NSError *))error {
    
    [self mainRequestMethodWithURL:url success:success error:error];
}

- (void)requesNewstWithURL:(NSString *)url success:(void(^)(id responseObject))success error:(void(^)(NSError *errorInfo))error {
    
    [self mainRequestMethodWithURL:url success:success error:error];
}


/**
 *  封装头条，新闻等网络请求方法
 *
 *  @param url     网络路径
 *  @param success 成功后的回调
 *  @param error   错误后的回调
 */
- (void)mainRequestMethodWithURL:(NSString *)url success:(void(^)(id responseObject))success error:(void(^)(NSError *errorInfo))error {
    
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
