//
//  EpubLoader.h
//  AdvancedEpubReader
//
//  Created by Kudinov Denis on 01.10.15.
//  Copyright © 2015 Trinity Digital. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Epub;

@interface EpubLoader : NSObject

- (Epub *)loadEpubNamed:(NSString *)name;

@end
