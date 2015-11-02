//
//  ReaderController.m
//  AdvancedEpubReader
//
//  Created by Kudinov Denis on 30.09.15.
//  Copyright © 2015 Trinity Digital. All rights reserved.
//

#import "ReaderController.h"

#import "EpubLoader.h"
#import "FileLoader.h"
#import "EpubUnarchiver.h"

#import "Epub.h"
#import "Epub+Extensions.h"

#import "PageView.h"
#import "PageViewController.h"

#import "TopMenuController.h"
#import "BottomMenuController.h"

#import "TableOfContentsDelegate.h"
#import "SliderNavigationDelegate.h"
#import "MainBookInfoDelegate.h"
#import "NavPoint.h"

@interface ReaderController () <UIWebViewDelegate, UIGestureRecognizerDelegate, TableOfContentsDelegate, SliderNavigationDelegate, MainBookInfoDelegate>

@property NSInteger currentSpinePosition;
@property (strong) Epub *epub;

@property (strong) PageViewController *pageVC;
@property (strong, nonatomic) IBOutlet UIView *topMenu;
@property (strong, nonatomic) IBOutlet UIView *bottomMenu;

@property (strong, nonatomic) BottomMenuController *bottomMenuController;
@property (strong, nonatomic) TopMenuController *topMenuController;

@end

@implementation ReaderController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.currentSpinePosition = 0;
    
    if (![self copyAndUnarchiveEpub]) {
        NSLog(@"Cannot copy or unarchive epub");
    }
    self.epub = [self loadEpubNamed:@"test"];
    
    self.pageVC = [[PageViewController alloc] initWithSpine:self.epub.spine index:0 presenter:self];
    
    [self.view bringSubviewToFront:self.topMenu];
    [self.view bringSubviewToFront:self.bottomMenu];
    
    [self addSwipeRecognizers];
    [self addTapRecognizer];
}

#pragma mark - Gesture Recognizers
//-------------------------------------------------
// Gesture Recognizers
//-------------------------------------------------

- (void)addSwipeRecognizers {
    UISwipeGestureRecognizer *rightSwipeReco = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    [rightSwipeReco setDirection:UISwipeGestureRecognizerDirectionRight];
    rightSwipeReco.delegate = self;
    [self.view addGestureRecognizer:rightSwipeReco];
    
    UISwipeGestureRecognizer *leftSwipeReco = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    [leftSwipeReco setDirection:UISwipeGestureRecognizerDirectionLeft];
    leftSwipeReco.delegate = self;
    [self.view addGestureRecognizer:leftSwipeReco];
}

- (void)addTapRecognizer {
    UITapGestureRecognizer *tapReco = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [tapReco setNumberOfTapsRequired:1];
    tapReco.delegate = self;
    [self.view addGestureRecognizer:tapReco];
}

- (void)swipe:(UISwipeGestureRecognizer *)gestrec {
    if (gestrec.direction == UISwipeGestureRecognizerDirectionLeft) {
        [self.pageVC turnPage:PageScrollDirectionRight];
    }
    if (gestrec.direction == UISwipeGestureRecognizerDirectionRight) {
        [self.pageVC turnPage:PageScrollDirectionLeft];
    }
}

- (void)tap:(UITapGestureRecognizer *)tapReco {
    
    // не скрывать меню, если на него нажать
    CGPoint touchPoint = [tapReco locationInView:tapReco.view];
    if (CGRectContainsPoint(self.topMenu.frame, touchPoint) || CGRectContainsPoint(self.bottomMenu.frame, touchPoint)) {
        return;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        // стоит не забывать, что alpha -- это (cg)float.
        // сравнение float с int может закончиться не так, как ожидалось
        self.topMenu.alpha = self.topMenu.alpha ? 0 : 1;
        self.bottomMenu.alpha = self.bottomMenu.alpha ? 0 : 1;
    } completion:^(BOOL finished) {
        
    }];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

#pragma mark - Temp methods to load epub
//-------------------------------------------------
// Temp methods to load epub
//-------------------------------------------------

- (BOOL)copyAndUnarchiveEpub {
    BOOL success = NO;
    NSError *error = nil;
    success = [FileLoader copyFileFromBundleToDocuments:@"test.epub" error:error];
    success &= [EpubUnarchiver unzipEpubNamed:@"test.epub"];
    return success;
}

- (Epub *)loadEpubNamed:(NSString *)name {
    EpubLoader *loader = [EpubLoader new];
    return [loader loadEpubNamed:@"test"];
}



#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    id dvc = segue.destinationViewController;
    if ([dvc isKindOfClass:[TopMenuController class]]) {
        self.topMenuController = dvc;
        [dvc setReaderController:self];
    }
    if ([dvc isKindOfClass:[BottomMenuController class]]) {
        self.bottomMenuController = dvc;
        [dvc setReaderController:self];
    }

}

#pragma mark - TableOfContentsDelegate
//-------------------------------------------------
// TableOfContentsDelegate
//-------------------------------------------------

- (NSInteger)currentIndex {
    return 0;
}

- (NSArray *)toc {
    return self.epub.bfsToc;
}

- (void)showPageAtIndex:(NSInteger)pageIndex {
//    for (NavPoint *navPoint in self.epub.tocRoot.childs)
    [self.pageVC loadPageFromSpine:self.epub.spine AtIndex:pageIndex];
}

#pragma mark - SliderNavigationDelegate
//-------------------------------------------------
// SliderNavigationDelegate
//-------------------------------------------------

- (void)showPageAtPercent:(float)percent {
    [self.pageVC loadAtPercent:percent];
}

- (void)updatePercent:(float)percent {
    [self.bottomMenuController updatePercent:percent];
}

#pragma mark - Main Info Delegate
//-------------------------------------------------
// Main Info Delegate
//-------------------------------------------------

- (NSArray *)spine {
    return self.epub.spine;
}


@end
