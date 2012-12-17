//
//  WebViewController.m
//  Nerdfeed
//
//  Created by Jack Flintermann on 11/15/12.
//  Copyright (c) 2012 jflinter. All rights reserved.
//

#import "WebViewController.h"

@implementation WebViewController

- (void) loadView {
    CGRect screenFrame = [[UIScreen mainScreen] applicationFrame];
    _webView = [[UIWebView alloc] initWithFrame:screenFrame];
    _webView.scalesPageToFit = YES;
    self.view = _webView;
}

@end
