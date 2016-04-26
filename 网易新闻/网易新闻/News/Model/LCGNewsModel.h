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
@property (nonatomic ,copy) NSString *replyCount;
@property (nonatomic ,copy) NSString *title;
@property (nonatomic ,copy) NSString *digest;
@property (nonatomic ,copy) NSString *imgsrc;
@property (nonatomic,strong) NSArray<LCGNewsImageModel *> *imgextra;
@property (nonatomic ,assign) NSInteger imgType;
//
+ (void)newsDatasWithURL:(NSString *)url success:(void(^)(NSArray *news))success;
@end
