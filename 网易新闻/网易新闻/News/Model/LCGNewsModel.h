//
//  LCGNewsModel.h
//  网易新闻
//
//  Created by Wistaria on 16/4/25.
//  Copyright © 2016年 Wistaria. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCGNewsModel : NSObject
@property (nonatomic ,copy) NSString *replyCount;
@property (nonatomic ,copy) NSString *ltitle;
@property (nonatomic ,copy) NSString *digest;
@property (nonatomic ,copy) NSString *imgsrc;
//
+ (void)newsDatasWithURL:(NSString *)url success:(void(^)(NSArray *news))success;
@end
