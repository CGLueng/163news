//
//  LCGHeadLineModel.m
//  网易新闻
//
//  Created by Wistaria on 16/4/22.
//  Copyright © 2016年 Wistaria. All rights reserved.
//

#import "LCGHeadLineModel.h"
#import "LCGApiManager.h"

@implementation LCGHeadLineModel
+ (instancetype)headLineWithDict:(NSDictionary *)dict {

    return [[self alloc]initwithDict:dict];
}

- (instancetype)initwithDict:(NSDictionary *)dict {

    if (self == [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (void)headLineDatasWithURL:(NSString *)url success:(void (^)(NSArray *))success {
    
    NSAssert(success != nil, @"回到不能为空");

    [[LCGApiManager sharedApi]requestHeadLineWithURL:url success:^(NSDictionary * responseObject) {

        NSString *key = responseObject.keyEnumerator.nextObject;
        NSArray *data = responseObject[key];
        NSMutableArray *dataM = [NSMutableArray array];
        [data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [dataM addObject:[LCGHeadLineModel headLineWithDict:obj]];
        }];
        
        success(dataM.copy);
        
    } error:^(NSError *errorInfo) {
        success(nil);
    }];

}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {

}


@end
