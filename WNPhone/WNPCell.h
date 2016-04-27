//
//  WNPCell.h
//  WNPhone
//
//  Created by Paul on 1/23/15.
//
//

#import <UIKit/UIKit.h>

@interface WNPCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *detailTextView;

+ (NSString *)cellIdentifier;

@end
