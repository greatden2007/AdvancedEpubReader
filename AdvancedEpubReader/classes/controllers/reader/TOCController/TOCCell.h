//
//  TOCCell.h
//  AdvancedEpubReader
//
//  Created by Kudinov Denis on 22.10.15.
//  Copyright © 2015 Trinity Digital. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonTVCell.h"

@class NavPoint;

@interface TOCCell : CommonTVCell

@property (strong, nonnull, nonatomic) NavPoint *navPoint;

@end
