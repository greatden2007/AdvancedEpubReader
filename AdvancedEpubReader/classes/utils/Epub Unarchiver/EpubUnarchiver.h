//
//  EpubUnarchiver.h
//  AdvancedEpubReader
//
//  Created by Kudinov Denis on 01.10.15.
//  Copyright © 2015 Trinity Digital. All rights reserved.
//

#import "SSZipArchive.h"

@interface EpubUnarchiver : SSZipArchive

+ (BOOL) unzipEpubNamed:(NSString *)path;

@end
