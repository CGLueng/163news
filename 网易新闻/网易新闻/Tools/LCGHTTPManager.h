//
//  LCGHTTPManager.h
//  网易新闻
//
//  Created by Wistaria on 16/4/22.
//  Copyright © 2016年 Wistaria. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface LCGHTTPManager : AFHTTPSessionManager
/**
 *  提供一个单例加载方法
 *
 *  @return 返回一个单例
 */
+ (instancetype)sharedManager;

@end
