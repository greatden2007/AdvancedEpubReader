//
//  Epub+Extensions.m
//  AdvancedEpubReader
//
//  Created by Kudinov Denis on 22.10.15.
//  Copyright © 2015 Trinity Digital. All rights reserved.
//

#import "Epub+Extensions.h"
#import "NavPoint.h"

@implementation Epub (Extensions)

- (NSArray *)bfsToc {
    NSMutableArray *bfsToc = @[].mutableCopy;
    [self addNavPointToArray:bfsToc navPoint:self.tocRoot];
    return bfsToc;
}

- (void)addNavPointToArray:(NSMutableArray *)bfstocArray navPoint:(NavPoint *)navPoint {
    for (NavPoint *navPChild in navPoint.childs) {
        [bfstocArray addObject:navPChild];
    }
    for (NavPoint *navPChild in navPoint.childs) {
        [self addNavPointToArray:bfstocArray navPoint:navPChild];
    }
}

@end
