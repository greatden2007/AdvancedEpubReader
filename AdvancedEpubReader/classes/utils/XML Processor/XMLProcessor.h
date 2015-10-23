//
//  XMLProcessor.h
//  AdvancedEpubReader
//
//  Created by Kudinov Denis on 01.10.15.
//  Copyright © 2015 Trinity Digital. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CompletionBlock)(id result, NSError *error);

@interface XMLProcessor : NSObject

- (instancetype)initWithRootURL:(NSURL *)rootURL;

- (NSDictionary *)openXMLFile:(NSString *)path;

@end
