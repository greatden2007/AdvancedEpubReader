//
//  PageViewController.m
//  AdvancedEpubReader
//
//  Created by Kudinov Denis on 05.10.15.
//  Copyright © 2015 Trinity Digital. All rights reserved.
//

#import "PageViewController.h"

#import "PageView.h"

static const float kPageTurnTime = 0.25;

@interface PageViewController ()

@property PageView *pageView;
@property (strong) NSArray *spine;

@end

@implementation PageViewController

- (instancetype)initWithSpine:(NSArray *)spine index:(NSInteger)index presenter:(UIView *)presenter {
    self = [super init];
    if(self) {
        
        self.spine = spine;
        
        self.pageView = [[PageView alloc] initWithFrame:presenter.frame spine:spine index:index];
        self.pageView.backgroundColor = [UIColor blueColor];
        [presenter addSubview:self.pageView];
        
        self.pageView.previous = [[PageView alloc] init];
        self.pageView.previous.backgroundColor = [UIColor redColor];
        [self moveViewLeft:self.pageView.previous RelativeToView:self.pageView];
        [presenter addSubview:self.pageView.previous];
        
        self.pageView.next = [[PageView alloc] init];
        self.pageView.next.backgroundColor = [UIColor greenColor];
        [self moveViewToRight:self.pageView.next RelativeToView:self.pageView];
        [presenter addSubview:self.pageView.next];
        
        if (index > 0) {
            [self.pageView.previous setURLFromSpine:spine index:index - 1];
        }
        if (index < spine.count - 1) {
            [self.pageView.next setURLFromSpine:spine index:index + 1];
        }
    }
    return self;
}

- (void)loadPageFromSpine:(NSArray *)spine AtIndex:(NSInteger)index {
    self.spine = spine;
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

@end
