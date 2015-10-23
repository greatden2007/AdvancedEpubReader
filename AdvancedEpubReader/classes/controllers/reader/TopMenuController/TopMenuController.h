//
//  TopMenuController.h
//  AdvancedEpubReader
//
//  Created by Kudinov Denis on 22.10.15.
//  Copyright © 2015 Trinity Digital. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TableOfContentsDelegate;

@interface TopMenuController : UIViewController

@property (weak) UIViewController <TableOfContentsDelegate> *readerController;

@end
