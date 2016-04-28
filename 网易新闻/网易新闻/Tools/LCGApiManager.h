//
//  LCGApiManager.h
//  网易新闻
//
//  Created by Wistaria on 16/4/22.
//  Copyright © 2016年 Wistaria. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCGApiManager : NSObject
/**
 *  提供一个创建单例的方法
 *
 *  @return 返回一个单例
 */
+ (instancetype)sharedApi;
/**
 *  请求头条数据
 *
 *  @param url     请求路径
 *  @param success 成功回调
 *  @param error   错误回调
 */
- (void)requestHeadLineWithURL:(NSString *)url success:(void(^)(id responseObject))success error:(void(^)(NSError *errorInfo))error;
/**
 *  请求新闻数据
 *
 *  @param url     请求路径
 *  @param success 成功回调
 *  @param error   失败回调
 */
- (void)requesNewstWithURL:(NSString *)url success:(void(^)(id responseObject))success error:(void(^)(NSError *errorInfo))error;
@end
