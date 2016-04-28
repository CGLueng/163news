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
/** 字典转模型工厂方法 */
+ (instancetype)headLineWithDict:(NSDictionary *)dict {

    return [[self alloc]initwithDict:dict];
}
 /** 字典转模型 */
- (instancetype)initwithDict:(NSDictionary *)dict {

    if (self == [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
/** 加载头条数据 */
+ (void)headLineDatasWithURL:(NSString *)url success:(void (^)(NSArray *))success {
     //断言
    NSAssert(success != nil, @"回到不能为空");
     //调用工具类的方法加载数据
    [[LCGApiManager sharedApi]requestHeadLineWithURL:url success:^(NSDictionary * responseObject) {
         //获取返回的字典中的 key
        NSString *key = responseObject.keyEnumerator.nextObject;
        //获取 key 对应的数组
        NSArray *data = responseObject[key];
        //创建一个可变数组
        NSMutableArray *dataM = [NSMutableArray array];
        //遍历数组中的字典
        [data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            //字典转模型
            [dataM addObject:[LCGHeadLineModel headLineWithDict:obj]];
        }];
         //调用成功回调的 block，传入转好成模型的数组
        success(dataM.copy);
        
    } error:^(NSError *errorInfo) {
        success(nil);
    }];

}
 /** 重写此方法，防止调用 setValuesForKeysWithDictionary(KVC)造成程序崩了 */  
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {

}


@end
