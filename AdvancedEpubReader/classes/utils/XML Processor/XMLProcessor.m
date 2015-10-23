//
//  XMLProcessor.m
//  AdvancedEpubReader
//
//  Created by Kudinov Denis on 01.10.15.
//  Copyright © 2015 Trinity Digital. All rights reserved.
//

#import "XMLProcessor.h"
#import "FileLoader.h"
#import "XMLDictionary.h"

@interface XMLProcessor () <NSXMLParserDelegate>

@property (strong, nonatomic) NSURL *rootURL;
@property (copy) CompletionBlock completion;
@property (strong) NSXMLParser *xmlParser;

@end

@implementation XMLProcessor

- (instancetype)initWithRootURL:(NSURL *)rootURL {
    self = [super init];
    if (self) {
        self.rootURL = rootURL;
    }
    return self;
}

/**
 *  Return parsed content of file
 *
 *  @param path full path to file
 *
 *  @return parsed content
 */
- (NSDictionary *)openXMLFile:(NSString *)path {
    
    NSURL *fullPath = [self.rootURL URLByAppendingPathComponent:path];
    NSData *xmlData = [FileLoader contentOfFile:[fullPath absoluteString]];
    self.xmlParser = [[NSXMLParser alloc] initWithData:xmlData];
    
    XMLDictionaryParser *dictionaryParser = [XMLDictionaryParser sharedInstance];
    dictionaryParser.alwaysUseArrays = YES;
    
//    NSDictionary *dict = [NSDictionary dictionaryWithXMLParser:self.xmlParser];
    NSDictionary *dict = [dictionaryParser dictionaryWithParser:self.xmlParser];
    
    return dict;
}

@end


