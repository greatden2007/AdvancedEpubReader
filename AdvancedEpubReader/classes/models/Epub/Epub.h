//
//  Epub.h
//  AdvancedEpubReader
//
//  Created by Kudinov Denis on 01.10.15.
//  Copyright © 2015 Trinity Digital. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NavPoint;

@interface Epub : NSObject

@property (strong) NSURL *rootURL;
@property (strong) NSURL *textURL;

@property (copy) NSString *title;
@property (strong) NavPoint *tocRoot;
@property (strong) NSArray *spine;

@end
