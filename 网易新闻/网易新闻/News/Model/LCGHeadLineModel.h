//
//  LCGHeadLineModel.h
//  网易新闻
//
//  Created by Wistaria on 16/4/22.
//  Copyright © 2016年 Wistaria. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCGHeadLineModel : NSObject
@property (nonatomic ,copy) NSString *imgsrc;
@property (nonatomic ,copy) NSString *title;
- (instancetype)initwithDict:(NSDictionary *)dict;
+ (instancetype)headLineWithDict:(NSDictionary *)dict;
+ (void)headLineDatasWithURL:(NSString *)url success:(void(^)(NSArray *headline))success;
@end
