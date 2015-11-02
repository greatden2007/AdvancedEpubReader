//
//  TableOfContentsDelegate.h
//  AdvancedEpubReader
//
//  Created by Kudinov Denis on 22.10.15.
//  Copyright © 2015 Trinity Digital. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BottomMenuProtocol <NSObject>

- (void)back;

@end

@protocol TableOfContentsDelegate <NSObject>

@required

- (void)showPageAtIndex:(NSInteger)pageIndex;
- (NSArray *)toc;
- (NSInteger)currentIndex;

@end
