//
//  JSHandler.h
//  WKWebViewTest
//
//  Created by QianFan_Ryan on 2017/11/21.
//  Copyright © 2017年 QianFan_Ryan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@protocol JSHandlerDelegate <NSObject>

- (void)didReceiveMessageName:(NSString *)name body:(id)body;

@end

@interface JSHandler : NSObject <WKScriptMessageHandler>

- (void)setJsdelegate:(id<JSHandlerDelegate>)jsdelegate userController:(WKUserContentController *)userController;

- (void)removeJsdelegate;

@end
