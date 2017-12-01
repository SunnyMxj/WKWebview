//
//  WKWebViewController.m
//  WKWebViewTest
//
//  Created by QianFan_Ryan on 2017/11/20.
//  Copyright © 2017年 QianFan_Ryan. All rights reserved.
//

#import "WKWebViewController.h"
#import <WebKit/WebKit.h>
#import "JSHandler.h"

#define DLog NSLog(@"function:%s ",__FUNCTION__);

@interface WKWebViewController ()<WKNavigationDelegate,WKUIDelegate,JSHandlerDelegate>

@property (nonatomic, weak  )JSHandler *jsHandler;

@property (nonatomic, strong)WKWebView *webview;
@property (nonatomic, strong)UIWebView *uiwebview;
//返回按钮
@property (nonatomic, strong)UIBarButtonItem *customBackBarItem;
//关闭按钮
@property (nonatomic, strong)UIBarButtonItem *closeButtonItem;

@end

@implementation WKWebViewController

- (void)dealloc {
    NSLog(@"WKWebViewController dealloc");
    if (_jsHandler) {
        [_jsHandler removeJsdelegate];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString *url = @"http://www.qianfanyun.com/js_demo.php";
    
    //添加到主控制器上
    [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
//    [self.uiwebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    
//    //获取JS所在的路径
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"html"];
//    //获得html内容
//    NSString *html = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
//    //加载js
//    [self.webview loadHTMLString:html baseURL:[[NSBundle mainBundle] bundleURL]];
    
    
    //添加右边刷新按钮
    UIBarButtonItem *roadLoad = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(roadLoadClicked)];
    self.navigationItem.rightBarButtonItem = roadLoad;
}

#pragma mark -- WKNavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    decisionHandler(WKNavigationActionPolicyAllow);
    DLog;
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    decisionHandler(WKNavigationResponsePolicyAllow);
    DLog;
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    DLog;
}

- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    DLog;
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    DLog;
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {
    DLog;
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    [self updateNavigationItems];
    DLog;
}

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    DLog;
}

//- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler {
//    DLog;
//}

#pragma mark -- WKUIDelegate
- (nullable WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    DLog;
    return self.webview;
}

//from ios9
- (void)webViewDidClose:(WKWebView *)webView {
    DLog;
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    DLog;
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler {
    DLog;
}

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable result))completionHandler {
    DLog;
}

//from ios10
- (BOOL)webView:(WKWebView *)webView shouldPreviewElement:(WKPreviewElementInfo *)elementInfo {
    DLog;
    return YES;
}

//from ios10
- (nullable UIViewController *)webView:(WKWebView *)webView previewingViewControllerForElement:(WKPreviewElementInfo *)elementInfo defaultActions:(NSArray<id <WKPreviewActionItem>> *)previewActions {
    DLog;
    return nil;
}

//from ios10
- (void)webView:(WKWebView *)webView commitPreviewingViewController:(UIViewController *)previewingViewController {
    DLog;
}

#pragma mark -- JSHandlerViewControllerDelegate
- (void)didReceiveMessageName:(NSString *)name body:(id)body {
    NSLog(@"didReceiveMessageName name: %@ body : %@",name,body);
}

#pragma mark -- action
- (void)updateNavigationItems{
    if (self.webview.canGoBack) {
        UIBarButtonItem *spaceButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        spaceButtonItem.width = -6.5;
        [self.navigationItem setLeftBarButtonItems:@[spaceButtonItem,self.customBackBarItem,self.closeButtonItem] animated:NO];
    } else {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        [self.navigationItem setLeftBarButtonItems:@[self.customBackBarItem]];
    }
}

- (void)roadLoadClicked{
    [self.webview reloadFromOrigin];
}

- (void)customBackItemClicked{
    if (self.webview.goBack) {
        [self.webview goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)closeItemClicked{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- property
- (WKWebView *)webview{
    if (!_webview) {
        //设置网页的配置文件
        WKWebViewConfiguration *Configuration = [[WKWebViewConfiguration alloc]init];
        // 允许在线播放
        Configuration.allowsInlineMediaPlayback = YES;
        // 允许可以与网页交互，选择视图
        Configuration.selectionGranularity = YES;
        // web内容处理池
        Configuration.processPool = [[WKProcessPool alloc] init];
        //自定义配置,一般用于 js调用oc方法(OC拦截URL中的数据做自定义操作)
        WKUserContentController * UserContentController = [[WKUserContentController alloc]init];
        // 是否支持记忆读取
        Configuration.suppressesIncrementalRendering = YES;
        // 允许用户更改网页的设置
        Configuration.userContentController = UserContentController;
        _webview = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:Configuration];
        _webview.backgroundColor = [UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1.0];
        // 设置代理
        _webview.navigationDelegate = self;
        _webview.UIDelegate = self;
        //kvo 添加进度监控
//        [_webview addObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress)) options:0 context:WkwebBrowserContext];
        //开启手势触摸
        _webview.allowsBackForwardNavigationGestures = YES;
        // 设置 可以前进 和 后退
        //适应你设定的尺寸
        [_webview sizeToFit];
        [self.view addSubview:_webview];
        
        // 添加消息处理，注意：self指代的对象需要遵守WKScriptMessageHandler协议，结束时需要移除
        JSHandler *jsHandler = [JSHandler new];
        [jsHandler setJsdelegate:self userController:UserContentController];
        _jsHandler = jsHandler;
    }
    return _webview;
}

- (UIWebView *)uiwebview {
    if (!_uiwebview) {
        _uiwebview = [[UIWebView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:_uiwebview];
    }
    return _uiwebview;
}

- (UIBarButtonItem *)customBackBarItem{
    if (!_customBackBarItem) {
        UIImage *backItemImage = [[UIImage imageNamed:@"backItemImage"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        UIImage *backItemHlImage = [[UIImage imageNamed:@"backItemImage-hl"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        UIButton* backButton = [[UIButton alloc] init];
        [backButton setTitle:@"返回" forState:UIControlStateNormal];
        [backButton setTitleColor:self.navigationController.navigationBar.tintColor forState:UIControlStateNormal];
        [backButton setTitleColor:[self.navigationController.navigationBar.tintColor colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
        [backButton.titleLabel setFont:[UIFont systemFontOfSize:17]];
        [backButton setImage:backItemImage forState:UIControlStateNormal];
        [backButton setImage:backItemHlImage forState:UIControlStateHighlighted];
        [backButton sizeToFit];
        
        [backButton addTarget:self action:@selector(customBackItemClicked) forControlEvents:UIControlEventTouchUpInside];
        _customBackBarItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    }
    return _customBackBarItem;
}

- (UIBarButtonItem *)closeButtonItem{
    if (!_closeButtonItem) {
        _closeButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(closeItemClicked)];
    }
    return _closeButtonItem;
}

@end
