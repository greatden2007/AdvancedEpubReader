//
//  PageView.m
//  AdvancedEpubReader
//
//  Created by Kudinov Denis on 05.10.15.
//  Copyright © 2015 Trinity Digital. All rights reserved.
//

#import "PageView.h"

@implementation PageView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.delegate = self;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame spine:(NSArray *)spine index:(NSInteger)index {
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        [self setURLFromSpine:spine index:index];
        _progress = index / spine.count;
    }
    return self;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    CGRect screenSize = [UIScreen mainScreen].bounds;
    float multiplier = 2.f;
    if (screenSize.size.height > 568) {
        multiplier = 1.7;
    }
    if (screenSize.size.height < 568) {
        multiplier = 2.5;
    }
    if (screenSize.size.height == 736) {
        multiplier = 1.6;
    }
    NSString *js = [NSString stringWithFormat:@"viewport = document.querySelector(\"meta[name=viewport]\");viewport.setAttribute('content', 'width=%f,height=%f');", screenSize.size.width * multiplier, screenSize.size.height * multiplier];
    [webView stringByEvaluatingJavaScriptFromString:js];
}

- (void)setURLFromSpine:(NSArray *)spine index:(NSInteger)index  {
    self.spineIndex = index;
    [self loadRequest:[NSURLRequest requestWithURL:spine[index]]];
    self.scrollView.scrollEnabled = NO;
    self.scalesPageToFit = YES;
}

@end
