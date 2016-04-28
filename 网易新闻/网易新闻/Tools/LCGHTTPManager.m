//
//  LCGHTTPManager.m
//  网易新闻
//
//  Created by Wistaria on 16/4/22.
//  Copyright © 2016年 Wistaria. All rights reserved.
//

#import "LCGHTTPManager.h"
#define LCGBaseURL [NSURL URLWithString:@"http://c.3g.163.com/nc/"]

@implementation LCGHTTPManager
+ (instancetype)sharedManager {
    //创建一个单例
    static dispatch_once_t onceToken;
    static LCGHTTPManager *instance;
    dispatch_once(&onceToken, ^{
        
        instance = [[self alloc]initWithBaseURL:LCGBaseURL sessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        //无法解析 html 的时候调用此方法并且加上@"text/html"
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",  nil];
    });
    return instance;
}
@end
