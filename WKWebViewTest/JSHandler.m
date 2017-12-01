//
//  JSHandler.m
//  WKWebViewTest
//
//  Created by QianFan_Ryan on 2017/11/21.
//  Copyright © 2017年 QianFan_Ryan. All rights reserved.
//

#import "JSHandler.h"


@interface JSHandler ()

@property (nonatomic, weak) id<JSHandlerDelegate> jsdelegate;
@property (nonatomic, weak) WKUserContentController *userController;

@end

@implementation JSHandler

- (void)dealloc {
    NSLog(@"JSHandler dealloc");
}

- (void)setJsdelegate:(id<JSHandlerDelegate>)jsdelegate userController:(WKUserContentController *)userController {
    _jsdelegate = jsdelegate;
    _userController = userController;
    [[[self class] allJS] enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [_userController addScriptMessageHandler:self name:obj];
    }];
}

- (void)removeJsdelegate {
    [[[self class] allJS] enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [_userController removeScriptMessageHandlerForName:obj];
    }];
}

#pragma mark -- WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    if ([self.jsdelegate respondsToSelector:@selector(didReceiveMessageName:body:)]) {
        [self.jsdelegate didReceiveMessageName:message.name body:message.body];
    }
}

+ (NSArray <NSString *>*)allJS {
    return @[@"QFH5jumpThread",@"Share",@"Location"];
}

@end
