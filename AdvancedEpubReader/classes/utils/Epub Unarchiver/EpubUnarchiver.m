//
//  EpubUnarchiver.m
//  AdvancedEpubReader
//
//  Created by Kudinov Denis on 01.10.15.
//  Copyright © 2015 Trinity Digital. All rights reserved.
//

#import "EpubUnarchiver.h"
#import "FileLoader.h"

@implementation EpubUnarchiver

+ (BOOL)unzipEpubNamed:(NSString *)path {
    NSString *outPath = [path componentsSeparatedByString:@"."][0];
    outPath = [[FileLoader documentsPath] stringByAppendingPathComponent:outPath];
    
    path = [[FileLoader documentsPath] stringByAppendingPathComponent:path];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:outPath isDirectory:nil]) {
        [[NSFileManager defaultManager] removeItemAtPath:outPath error:nil];
    }
    
    return [self unzipFileAtPath:path toDestination:outPath];
}

@end
