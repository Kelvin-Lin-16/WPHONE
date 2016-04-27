//
//  MessageViewController.h
//  WNPhone
//
//  Created by peng wan on 15-1-27.
//
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <Sinch/Sinch.h>
#import "PaddedTextField.h"

@interface MessageViewController : UIViewController <SINMessageClientDelegate, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *messageView;
@property (weak, nonatomic) IBOutlet PaddedTextField *activeField;
@property (weak, nonatomic) IBOutlet PaddedTextField *message;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;
@property (weak, nonatomic) id<SINClient> client;

- (IBAction)sendButtonPressed:(id)sender;


@end
