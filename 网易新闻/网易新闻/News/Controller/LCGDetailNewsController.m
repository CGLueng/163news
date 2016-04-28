//
//  LCGDetailNewsController.m
//  无广告网易新闻
//
//  Created by Wistaria on 16/4/28.
//  Copyright © 2016年 Wistaria. All rights reserved.
//

#import "LCGDetailNewsController.h"
#import "LCGHTTPManager.h"

@interface LCGDetailNewsController ()<UIWebViewDelegate>
// 创建webview
@property (nonatomic,strong) UIWebView *webView;
//新闻内容
@property (nonatomic ,copy) NSString *body;
//新闻标题
@property (nonatomic ,copy) NSString *newsTitle;
//新闻事件
@property (nonatomic ,copy) NSString *time;
@end

@implementation LCGDetailNewsController
/** 在 view 显示到界面之前会调用这个方法，此处将普通的 view 换成 webView */
- (void)loadView {

    self.webView = [[UIWebView alloc]init];
    //设置 webView 代理
    self.webView.delegate = self;
    //将普通的 view 用 webView 进行替换
    self.view = self.webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //这是背景色，不然跳转时候回卡顿
    self.view.backgroundColor = [UIColor whiteColor];
     //加载数据
    [self loadData];
}
/** 加载数据 */
- (void)loadData {
    //调用工具类进行加载
    [[LCGHTTPManager sharedManager]GET:self.newsURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        //拿到字典中的key
        NSString *key = responseObject.keyEnumerator.nextObject;
        //取出返回结果中装有数据的字典
        NSDictionary *result = responseObject[key];
         //获得新闻内容（由于 block 中要调用，所以要加前缀）
        __block NSString *body = result[@"body"];
        //获得图片数组
        NSArray *images = result[@"img"];
         //遍历数组的元素，将图片添加到新闻内容中
        [images enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
             //取到图片的占位字符串
            NSString *ref = obj[@"ref"];
             //将占位字符替换成图片代码字符串，将值返回
            body = [body stringByReplacingOccurrencesOfString:ref withString:[self imageHTTPWithDict:obj]];
            
        }];
         //获得视频数组
        NSArray *videos = result[@"video"];
        //遍历数组，将视频添加到新闻内容中
        [videos enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
             //取到视频的占位字符串
            NSString *ref = obj[@"ref"];
             //将占位字符替换成视频代码字符串，将值返回
            body = [body stringByReplacingOccurrencesOfString:ref withString:[self videoHTMLWithDict:obj]];
        }];
         //赋值
        self.body = body;
        //获取当前新闻标题
        self.newsTitle = result[@"title"];
        //获取新闻事件和新闻来源信息
        self.time = [NSString stringWithFormat:@"%@  %@",result[@"ptime"],result[@"source"]];
         //加载本地 html
        NSURL *url = [[NSBundle mainBundle]URLForResource:@"detail.html" withExtension:nil];
        //创建网络请求
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        //webView 加载网络请求
        [self.webView loadRequest:request];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"出错了");
    }];
}
/** 返回添加图片的字符串代码 */
- (NSString *)imageHTTPWithDict:(NSDictionary *)dict {
    
    NSString *html = [NSString stringWithFormat:@"<img src=\"%@\" width=\"100%%\"  alt=\"%@\"/><span style=\"font-size: 15px;color: dimgrey\">%@</span>",dict[@"src"],dict[@"alt"],dict[@"alt"]];

    return html;
}
/** 返回添加视频的字符串代码 */
- (NSString *)videoHTMLWithDict:(NSDictionary *)dict {
    NSString *html = [NSString stringWithFormat:@"<video width=\"100%%\" controls>"
                      "<source src=\"%@\""
                      " type=\"video/mp4\">"
                      "您的浏览器不支持 HTML5 video 标签。"
                      "</video><span style=\"font-size: 15px;color: dimgrey\">%@</span>",dict[@"url_mp4"],dict[@"alt"]];
    return html;
}

#pragma mark - webView 代理
/** 调用本地 html 中的 js 方法 */
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    //拼接代码字符串
    NSString *code = [NSString stringWithFormat:@"changeContent('%@','%@','%@')",self.newsTitle,self.time,self.body];
    //调用本地 html 中的 jc 方法
    [webView stringByEvaluatingJavaScriptFromString:code];
}
@end
