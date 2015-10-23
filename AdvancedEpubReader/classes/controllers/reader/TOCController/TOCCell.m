//
//  TOCCell.m
//  AdvancedEpubReader
//
//  Created by Kudinov Denis on 22.10.15.
//  Copyright © 2015 Trinity Digital. All rights reserved.
//

#import "TOCCell.h"

#import "NavPoint.h"

@interface TOCCell ()

@property (strong, nonatomic) IBOutlet UILabel *contentTitle;

@end

@implementation TOCCell

- (void)setNavPoint:(NavPoint *)navPoint {
    _navPoint = navPoint;
    self.contentTitle.text = navPoint.title;
}

@end
