//
//  TOCController.h
//  AdvancedEpubReader
//
//  Created by Kudinov Denis on 22.10.15.
//  Copyright © 2015 Trinity Digital. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TableOfContentsDelegate;

@interface TOCController : UIViewController

@property (weak) UIViewController <TableOfContentsDelegate> *tocDelegate;

@end
