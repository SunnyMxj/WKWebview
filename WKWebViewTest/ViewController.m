//
//  ViewController.m
//  WKWebViewTest
//
//  Created by QianFan_Ryan on 2017/11/20.
//  Copyright © 2017年 QianFan_Ryan. All rights reserved.
//

#import "ViewController.h"
#import "WKWebViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake((screenWidth-100)/2, (screenHeight-60)/2, 100, 60)];
    [button addTarget:self action:@selector(openURL) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"打开URL" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
}

- (void)openURL {
    WKWebViewController *wk = [WKWebViewController new];
    [self.navigationController pushViewController:wk animated:YES];
}

@end
