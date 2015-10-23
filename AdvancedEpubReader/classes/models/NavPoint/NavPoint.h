//
//  NavPoint.h
//  AdvancedEpubReader
//
//  Created by Kudinov Denis on 01.10.15.
//  Copyright © 2015 Trinity Digital. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NavPoint : NSObject

@property (copy) NSString *title;
@property NSInteger playOrder;
@property NSInteger depth;
@property (strong) NSMutableArray *childs;
@property (copy) NSURL *content; //full path

@end
