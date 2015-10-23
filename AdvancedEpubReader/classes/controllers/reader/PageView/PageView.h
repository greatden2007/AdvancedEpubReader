//
//  PageView.h
//  AdvancedEpubReader
//
//  Created by Kudinov Denis on 05.10.15.
//  Copyright © 2015 Trinity Digital. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageView : UIWebView <UIWebViewDelegate>

@property NSInteger spineIndex;

@property (strong) PageView *next;
@property (strong) PageView *previous;
@property float progress;

- (instancetype)initWithFrame:(CGRect)frame spine:(NSArray *)spine index:(NSInteger)index;

- (void)setURLFromSpine:(NSArray *)spine index:(NSInteger)index;

@end
