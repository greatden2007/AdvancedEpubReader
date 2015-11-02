//
//  PageViewController.m
//  AdvancedEpubReader
//
//  Created by Kudinov Denis on 05.10.15.
//  Copyright © 2015 Trinity Digital. All rights reserved.
//

#import "PageViewController.h"

#import "PageView.h"

#import "TableOfContentsDelegate.h"
#import "SliderNavigationDelegate.h"

static const float kPageTurnTime = 0.25;

@interface PageViewController ()

@property PageView *pageView;
@property (strong) NSArray *spine;
@property (weak) UIViewController <TableOfContentsDelegate, SliderNavigationDelegate> *presenter;

@end

@implementation PageViewController

- (instancetype)initWithSpine:(NSArray *)spine index:(NSInteger)index presenter:(UIViewController <TableOfContentsDelegate, SliderNavigationDelegate> *)presenter {
    self = [super init];
    if(self) {
        
        _spine = spine;
        _presenter = presenter;
        
        self.pageView = [[PageView alloc] initWithFrame:presenter.view.frame spine:spine index:index];
        self.pageView.backgroundColor = [UIColor blueColor];
        [presenter.view addSubview:self.pageView];
        
        self.pageView.previous = [[PageView alloc] init];
        self.pageView.previous.backgroundColor = [UIColor redColor];
        [self moveViewLeft:self.pageView.previous RelativeToView:self.pageView];
        [presenter.view addSubview:self.pageView.previous];
        
        self.pageView.next = [[PageView alloc] init];
        self.pageView.next.backgroundColor = [UIColor greenColor];
        [self moveViewToRight:self.pageView.next RelativeToView:self.pageView];
        [presenter.view addSubview:self.pageView.next];
        
        if (index > 0) {
            [self.pageView.previous setURLFromSpine:spine index:index - 1];
        }
        if (index < spine.count - 1) {
            [self.pageView.next setURLFromSpine:spine index:index + 1];
        }
        
        [self.presenter updatePercent:(float)index / (float)spine.count];
    }
    return self;
}

- (void)loadPageFromSpine:(NSArray *)spine AtIndex:(NSInteger)index {
    self.spine = spine;
    [self.presenter updatePercent:(float)index / (float)spine.count];
    [self.pageView setURLFromSpine:spine index:index];
    if (index > 0) {
        [self.pageView.previous setURLFromSpine:spine index:index - 1];
    }
    if (index < spine.count - 1) {
        [self.pageView.next setURLFromSpine:spine index:index + 1];
    }
}

- (void)turnPage:(PageScrollDirection)direction {
    switch (direction) {
        case PageScrollDirectionLeft: {
            if (self.pageView.spineIndex == 0) {
                return;
            }
            [UIView animateWithDuration:kPageTurnTime animations:^{
                self.pageView.previous.frame = self.pageView.frame;
                self.pageView.frame = self.pageView.next.frame;
            } completion:^(BOOL finished) {
                // страница --
                
                PageView *left = self.pageView.previous;
                PageView *right = self.pageView.next;
                PageView *center = self.pageView;
                
                if (left.spineIndex > 0) {
                    [right setURLFromSpine:self.spine index:left.spineIndex - 1];
                }
                
                [self setViewOriginXTo0:left];
                [self moveViewToRight:center RelativeToView:left];
                [self moveViewLeft:right RelativeToView:left];
                
                self.pageView = left;
                self.pageView.previous = right;
                self.pageView.next = center;
                
                [self.presenter updatePercent:self.pageView.spineIndex / (float)self.spine.count];
            }];
            break;
        }
        case PageScrollDirectionRight: {
            if (self.pageView.next.spineIndex == self.spine.count - 1) {
                return;
            }
            [UIView animateWithDuration:kPageTurnTime animations:^{
                // в иерархии subviews добавляется сначала левый, потом средний, потом правый
                // поэтому простого self.pageView.next.frame = self.pageView.frame; будет недостаточно
                // так как центральный будет лежать поверх правого. Поэтому у центрального фрейм тоже смещается
                
                // как вариант можно было делать bringSubviewToFront, но как-то это выглядит неправильно
                
                self.pageView.next.frame = self.pageView.frame;
                self.pageView.frame = self.pageView.previous.frame;
            } completion:^(BOOL finished) {
                // страница ++
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    PageView *left = self.pageView.previous;
                    PageView *right = self.pageView.next;
                    PageView *center = self.pageView;
                    
                    [self setViewOriginXTo0:right];
                    [self moveViewToRight:left RelativeToView:right];
                    [self moveViewLeft:center RelativeToView:right];
                    
                    self.pageView = right;
                    self.pageView.previous = center;
                    self.pageView.next = left;
                    
                    if (right.spineIndex + 1 < self.spine.count - 1) {
                        [self.pageView.next setURLFromSpine:self.spine index:right.spineIndex + 1];
                    }
                    [self.presenter updatePercent:self.pageView.spineIndex / (float)self.spine.count];
                    
                });
            }];
            break;
        }
        default:
            break;
    }
    
}

- (void)setViewOriginXTo0:(PageView *)pageView {
    CGRect frame = pageView.frame;
    frame.origin.x = 0;
    pageView.frame = frame;
}

- (void)moveViewToRight:(PageView *)pageView RelativeToView:(PageView *)pageView_r {
    CGRect frame = pageView_r.frame;
    frame.origin.x += CGRectGetWidth(frame);
    pageView.frame = frame;
}

- (void)moveViewLeft:(PageView *)pageView RelativeToView:(PageView *)pageView_r {
    CGRect frame = pageView_r.frame;
    frame.origin.x -= CGRectGetWidth(frame);
    pageView.frame = frame;
}

#pragma mark - SliderNavigation
//-------------------------------------------------
// SliderNavigation
//-------------------------------------------------

- (void)loadAtPercent:(float)percent {
    [self loadPageFromSpine:self.spine AtIndex:percent * (self.spine.count - 1)];
}

@end
