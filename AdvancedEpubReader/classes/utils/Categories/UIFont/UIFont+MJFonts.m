//
//  UIFont+MJFonts.m
//  marathon
//
//  Created by Kudinov Denis on 11.09.15.
//  Copyright (c) 2015 Trinity Digital. All rights reserved.
//

#import "UIFont+MJFonts.h"
/**
 *  Все шрифты, которые юзаем именуются так:
 MuseoSansCyrl-500
 MuseoSansCyrl-700
 MuseoSansCyrl-900
 MuseoSansCyrl-300
 MuseoSansCyrl-100
 */

@implementation UIFont (MJFonts)

+ (UIFont *)MuseoSansCyrlFontWithPostfix:(NSInteger)postfix withSize:(CGFloat)size {
    if(!postfix) {
        return nil;
    }
    NSString *fontName = [@"MuseoSansCyrl-" stringByAppendingString:@(postfix).stringValue];
    return [UIFont fontWithName:fontName size:size];
}

+ (UIFont *)navigationBarTitleFont {
    return [self MuseoSansCyrlFontWithPostfix:500 withSize:18];
}

@end
