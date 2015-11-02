//
//  BottomMenuController.h
//  AdvancedEpubReader
//
//  Created by Kudinov Denis on 22.10.15.
//  Copyright © 2015 Trinity Digital. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SliderNavigationDelegate, MainBookInfoDelegate;

@interface BottomMenuController : UIViewController

@property (weak) UIViewController <SliderNavigationDelegate, MainBookInfoDelegate> *readerController;

- (void)updatePercent:(float)percent;

@end
