//
//  MainBookInfoDelegate.h
//  AdvancedEpubReader
//
//  Created by Kudinov Denis on 29.10.15.
//  Copyright © 2015 Trinity Digital. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MainBookInfoDelegate <NSObject>

- (NSInteger)currentIndex;
- (NSArray *)spine;

@end
