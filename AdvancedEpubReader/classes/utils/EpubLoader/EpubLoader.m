//
//  EpubLoader.m
//  AdvancedEpubReader
//
//  Created by Kudinov Denis on 01.10.15.
//  Copyright © 2015 Trinity Digital. All rights reserved.
//

#import "EpubLoader.h"

#import "Epub.h"
#import "NavPoint.h"

#import "XMLProcessor.h"
#import "FileLoader.h"

@interface EpubLoader ()

@property (strong) XMLProcessor *xmlProcessor;
@property (strong) NSURL *rootURL;
@property (strong) NSURL *OEBPSURL;

@end

@implementation EpubLoader

// основной метод
- (Epub *)loadEpubNamed:(NSString *)name {
    self.rootURL = [NSURL URLWithString:[[FileLoader documentsPath] stringByAppendingPathComponent:name]];
    self.OEBPSURL = [self.rootURL URLByAppendingPathComponent:@"OEBPS"];
    self.xmlProcessor = [[XMLProcessor alloc] initWithRootURL:self.rootURL];

    Epub *epub = [Epub new];
    epub.rootURL = self.rootURL;
    epub.textURL = [self.OEBPSURL URLByAppendingPathComponent:@"Text"];
    
    NSString *contentOPFPath = [self getContentOPFPath];
    NSDictionary *contentOPFFile = [self.xmlProcessor openXMLFile:contentOPFPath];
    NSDictionary *contentTocFile = [self.xmlProcessor openXMLFile:@"OEBPS/toc.ncx"];
    
    epub.tocRoot = [self parseTocFile:contentTocFile];
    epub.spine = [self parseSpineFile:contentOPFFile];
    
    return epub;
}

// Возвращает путь к файлу content.opf (файл с перечислением items)
- (NSString *)getContentOPFPath {
    NSDictionary *result = [self.xmlProcessor openXMLFile:@"META-INF/container.xml"];
    return result[@"rootfiles"][0][@"rootfile"][0][@"_full-path"];
}

#pragma mark - Table of content parse
//-------------------------------------------------
// Table of content parse
//-------------------------------------------------

- (NavPoint *)parseTocFile:(NSDictionary *)tocDict {
    NavPoint *root = [NavPoint new];
    [self findNavPointsinDictionary:tocDict[@"navMap"][0] forPoint:root];
//    [self printAllNavPointsStarting:root];
    return root;
}

// Составляет дерево из заголовков
- (void)findNavPointsinDictionary:(NSDictionary *)dict forPoint:(NavPoint *)navPoint {
    for (NSDictionary *navPoint_d in dict[@"navPoint"]) {
        NavPoint *point = [NavPoint new];
        point.title = navPoint_d[@"navLabel"][0][@"text"][0];
        point.content = [self.OEBPSURL URLByAppendingPathComponent:navPoint_d[@"content"][0][@"_src"] ];
        point.playOrder = [navPoint_d[@"_playOrder"] integerValue];
        point.depth = navPoint.depth + 1;
        
        [self findNavPointsinDictionary:navPoint_d forPoint:point];
        
        [navPoint.childs addObject:point];
    }
    return;
}

- (void)printAllNavPointsStarting:(NavPoint *)navpoint {
    for (NavPoint *point in navpoint.childs) {
        NSLog(@"depth :%@ Item: %@ Content:%@", @(point.depth), point.title, point.content.absoluteString);
        [self printAllNavPointsStarting:point];
    }
}

#pragma mark - Spine Parsing
//-------------------------------------------------
// Spine Parsing
//-------------------------------------------------
- (NSArray *)parseSpineFile:(NSDictionary *)contentOPF {
    
    // manifest (declaration of all files)
    NSMutableDictionary *manifestElments = @{}.mutableCopy;
    for (NSDictionary *spineMainfestEl in contentOPF[@"manifest"][0][@"item"]) {
        manifestElments[spineMainfestEl[@"_id"]] = spineMainfestEl[@"_href"];
    }
    
    // spine (sorted mainfest except non-html files)
    NSMutableArray *spineIds = @[].mutableCopy;
    for (NSDictionary *spineElement in contentOPF[@"spine"][0][@"itemref"]) {
        [spineIds addObject:spineElement[@"_idref"]];
    }
    
    // sorted hrefs
    NSMutableArray *hrefSorted = @[].mutableCopy;
    for (NSString *idref in spineIds) {
        [hrefSorted addObject:[self.OEBPSURL URLByAppendingPathComponent:manifestElments[idref]]];
    }
    
    return hrefSorted;
}

#pragma mark - Help Functions
//-------------------------------------------------
// Help Functions
//-------------------------------------------------


@end
