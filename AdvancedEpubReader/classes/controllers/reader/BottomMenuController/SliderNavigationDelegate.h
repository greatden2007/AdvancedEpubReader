//
//  SliderNavigationDelegate.h
//  AdvancedEpubReader
//
//  Created by Kudinov Denis on 29.10.15.
//  Copyright © 2015 Trinity Digital. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SliderNavigationDelegate <NSObject>

- (void)showPageAtPercent:(float)percent;
- (void)updatePercent:(float)percent;

@end
