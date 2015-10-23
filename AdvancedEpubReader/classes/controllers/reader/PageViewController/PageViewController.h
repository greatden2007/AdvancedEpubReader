//
//  PageViewController.h
//  AdvancedEpubReader
//
//  Created by Kudinov Denis on 05.10.15.
//  Copyright © 2015 Trinity Digital. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class PageView;

typedef enum : NSUInteger {
    PageScrollDirectionRight,
    PageScrollDirectionLeft
} PageScrollDirection;

@interface PageViewController : NSObject

- (instancetype)initWithSpine:(NSArray *)spine index:(NSInteger)index presenter:(UIView *)presenter;

// Открывает страницу по индексу из spine, а так же соседние
- (void)loadPageFromSpine:(NSArray *)spine AtIndex:(NSInteger)index;

- (void)turnPage:(PageScrollDirection)direction;

@end
