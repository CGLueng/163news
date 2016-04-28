//
//  LCGHeadLineModel.h
//  网易新闻
//
//  Created by Wistaria on 16/4/22.
//  Copyright © 2016年 Wistaria. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCGHeadLineModel : NSObject
//图片路径
@property (nonatomic ,copy) NSString *imgsrc;
//标题
@property (nonatomic ,copy) NSString *title;

- (instancetype)initwithDict:(NSDictionary *)dict;
+ (instancetype)headLineWithDict:(NSDictionary *)dict;
/**
 *  加载头条的数据
 *
 *  @param url     url
 *  @param success  成功回调
 */
+ (void)headLineDatasWithURL:(NSString *)url success:(void(^)(NSArray *headline))success;
@end
