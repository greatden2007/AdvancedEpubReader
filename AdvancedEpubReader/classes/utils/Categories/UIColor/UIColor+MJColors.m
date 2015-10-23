//
//  UIColor+MJColors.m
//  marathon
//
//  Created by Kudinov Denis on 10.09.15.
//  Copyright (c) 2015 Trinity Digital. All rights reserved.
//

#import "UIColor+MJColors.h"

@implementation UIColor (MJColors)

+ (UIColor *)mainPinkColor {
    return [UIColor colorWithRed:255.0f / 255.0f green:144.0f / 255.0f blue:149.0f / 255.0f alpha:1.0f];
}

+ (UIColor *)menuBackgroundRedColor {
    return [UIColor colorWithRed:0.784 green:0.286 blue:0.309 alpha:1];
}

+ (UIImage *)imageFromColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
