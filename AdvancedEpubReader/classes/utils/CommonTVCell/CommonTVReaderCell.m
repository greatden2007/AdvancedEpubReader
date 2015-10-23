//
//  CommonTVCell.m
//  marathon
//
//  Created by Kudinov Denis on 11.09.15.
//  Copyright (c) 2015 Trinity Digital. All rights reserved.
//

#import "CommonTVReaderCell.h"

@implementation CommonTVReaderCell

+ (NSString *)className {
    return NSStringFromClass([self class]);
}

+ (UINib *)nib {
    return [UINib nibWithNibName:[self className] bundle:nil];
}


- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
