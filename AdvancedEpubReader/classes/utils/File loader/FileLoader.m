//
//  FileLoader.m
//  AdvancedEpubReader
//
//  Created by Kudinov Denis on 30.09.15.
//  Copyright © 2015 Trinity Digital. All rights reserved.
//

#import "FileLoader.h"

@implementation FileLoader

+ (NSData *)contentOfFile:(NSString *)fileName {
    return [[NSFileManager defaultManager] contentsAtPath:fileName];
}

+ (NSData *)contentOfFileInMainBundle:(NSString *)fileName {
    return [self contentOfFile:[self fullPathForFile:fileName]];
}

+ (NSString *)fullPathForFile:(NSString *)filename {
    NSArray *separatedName = [filename componentsSeparatedByString:@"."];
    if(separatedName.count != 2) {
        return nil;
    }
    
    NSString *path = [[NSBundle mainBundle] pathForResource:separatedName[0] ofType:separatedName[1]];
    return path;
}

+ (BOOL)copyFileFromBundleToDocuments:(NSString *)filename error:(NSError *)error {
    return [[NSFileManager defaultManager] copyItemAtPath:[self fullPathForFile:filename]
                                                   toPath:[[self documentsPath] stringByAppendingPathComponent:filename]
                                                    error:&error];
}

#pragma mark - Helpers
//-------------------------------------------------
// Helpers
//-------------------------------------------------
+ (NSString *)documentsPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}

@end
