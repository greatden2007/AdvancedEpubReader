//
//  NavPoint.m
//  AdvancedEpubReader
//
//  Created by Kudinov Denis on 01.10.15.
//  Copyright © 2015 Trinity Digital. All rights reserved.
//

#import "NavPoint.h"

@implementation NavPoint

- (instancetype)init {
    self = [super init];
    if (self) {
        self.childs = @[].mutableCopy;
        self.depth = 0;
    }
    return self;
}

@end
