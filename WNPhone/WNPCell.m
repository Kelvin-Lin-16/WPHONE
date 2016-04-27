//
//  WNPCell.m
//  WNPhone
//
//  Created by Paul on 1/23/15.
//
//

#import "WNPCell.h"

@implementation WNPCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (NSString *)cellIdentifier {
    
    return @"WNPCell";
    
}

@end
