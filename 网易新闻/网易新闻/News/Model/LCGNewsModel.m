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
/** YYModel 对模型中的模型解析不出来时候，在模型中实现这个方法就能解析出模型中的模型数据了 */
+ (NSDictionary *)modelContainerPropertyGenericClass {

    //@"imgextra"  模型在当前类中的属性名字
    //[LCGNewsImageModel class]  模型属于的类
    return @{@"imgextra" : [LCGNewsImageModel class]
             };
}
/** 重写 set 方法，设置新闻详情页的全路径 */
- (void)setDocid:(NSString *)docid {
     //对 NSString 赋值要用.copy（正规写法）
    _docid = docid.copy;
     //拼接全路径
    self.fullURL = [NSString stringWithFormat:@"article/%@/full.html",_docid];

}
/** 加载新闻数据 */
+ (void)newsDatasWithURL:(NSString *)url success:(void(^)(NSArray *news))success {
     //断言
    NSAssert(success != nil, @"回调不能为空");
    //调用工具类方法加载新闻数据
    [[LCGApiManager sharedApi]requesNewstWithURL:url success:^(NSDictionary *responseObject) {
        //取到返回的字典中的 key
        NSString *key = responseObject.keyEnumerator.nextObject;
        //取出 key 对应的数据
        NSData *data = responseObject[key];
         //YYModel解析 JSON 到数组中
        NSArray *tmp = [NSArray yy_modelArrayWithClass:self json:data];
        //创建可变数组
        NSMutableArray *news = [NSMutableArray arrayWithArray:tmp];
        //回调 block，传入数组
        success(news);
    } error:^(NSError *errorInfo) {
        success(nil);
    }];
}

@end
