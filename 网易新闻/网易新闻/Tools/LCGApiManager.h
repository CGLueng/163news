//
//  LCGApiManager.h
//  网易新闻
//
//  Created by Wistaria on 16/4/22.
//  Copyright © 2016年 Wistaria. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCGApiManager : NSObject

+ (instancetype)sharedApi;

- (void)requestWithURL:(NSString *)url success:(void(^)(id responseObject))success error:(void(^)(NSError *errorInfo))error;
@end
