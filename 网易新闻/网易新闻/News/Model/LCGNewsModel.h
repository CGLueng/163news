//
//  LCGNewsModel.h
//  网易新闻
//
//  Created by Wistaria on 16/4/25.
//  Copyright © 2016年 Wistaria. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LCGNewsImageModel;

@interface LCGNewsModel : NSObject
///  跟帖数
@property (nonatomic ,copy) NSString *replyCount;
///  标题
@property (nonatomic ,copy) NSString *title;
///  简介
@property (nonatomic ,copy) NSString *digest;
///  图片
@property (nonatomic ,copy) NSString *imgsrc;
///  更多的图片
@property (nonatomic,strong) NSArray<LCGNewsImageModel *> *imgextra;
///  图片类型 1是大图 默认是0，小图
@property (nonatomic ,assign) NSInteger imgType;
///  新闻详情 id
@property (nonatomic ,copy) NSString *docid;
///  新闻详情全路径
@property (nonatomic ,copy) NSString *fullURL;

///  加载新闻数据
///
///  @param url     新闻数据的路径
///  @param success 成功回调(数据的回调)
+ (void)newsDatasWithURL:(NSString *)url success:(void(^)(NSArray *news))success;
@end
