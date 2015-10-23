//
//  AdvancedEpubReaderTests.m
//  AdvancedEpubReaderTests
//
//  Created by Kudinov Denis on 30.09.15.
//  Copyright © 2015 Trinity Digital. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "FileLoader.h"
#import "XMLProcessor.h"
#import "EpubUnarchiver.h"

@interface AdvancedEpubReaderTests : XCTestCase

@end

@implementation AdvancedEpubReaderTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

#pragma mark - File loader test
//-------------------------------------------------
// File loader test
//-------------------------------------------------
- (void)testFileLoader {
    NSData *data = [FileLoader contentOfFileInMainBundle:@"test.epub"];
    XCTAssert(data != nil, @"File loader OK");
}

#pragma mark - XML Parser
//-------------------------------------------------
// XML Parser
//-------------------------------------------------
- (void)testXMLParser {
    XMLProcessor *processor = [[XMLProcessor alloc] initWithRootURL:[NSURL URLWithString:[[FileLoader documentsPath] stringByAppendingPathComponent:@"test"]]];
    
//    NSDictionary *result = [processor openXMLFile:@"META-INF/container.xml"];
    NSDictionary *result = [processor openXMLFile:@"OEBPS/toc.ncx"];
    XCTAssert(result, @"XML Parser working ok");
}


#pragma mark - Unarchiver
//-------------------------------------------------
// Unarchiver
//-------------------------------------------------
//- (void)testUnarchiver {
//    BOOL success = NO;
//    NSError *error = nil;
//    success = [FileLoader copyFileFromBundleToDocuments:@"test.epub" error:error];
//    success &= [EpubUnarchiver unzipEpubNamed:@"test.epub"];
//    
//    XCTAssert(success, @"unarchiver ok");
//}
@end
