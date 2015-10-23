//
//  FileLoader.h
//  AdvancedEpubReader
//
//  Created by Kudinov Denis on 30.09.15.
//  Copyright © 2015 Trinity Digital. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileLoader : NSObject

+ (NSData *)contentOfFile:(NSString *)fileName;
+ (NSData *)contentOfFileInMainBundle:(NSString *)fileName;

+ (NSString *)fullPathForFile:(NSString *)filename;

+ (BOOL)copyFileFromBundleToDocuments:(NSString *)filename error:(NSError *)error;


#pragma mark - helpers
//-------------------------------------------------
// helpers
//-------------------------------------------------
+ (NSString *)documentsPath;

@end
