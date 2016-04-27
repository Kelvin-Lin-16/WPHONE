//
//  MessageViewController.m
//  WNPhone
//
//  Created by peng wan on 15-1-27.
//
//

#import "MessageViewController.h"
#import "MessageTableViewCell.h"

typedef NS_ENUM(int, MessageDirection) { Incoming, Outgoing, };

@interface MessageViewController () {
    NSMutableArray *_messages;
}

@end

@implementation MessageViewController

- (id<SINClient>)client {
    return [(AppDelegate *)[[UIApplication sharedApplication] delegate] client];
}

- (void)awakeFromNib {
    _messages = [NSMutableArray array];
    [self.client messageClient].delegate = self;
}

- (void)sendButtonPressed:(id)sender {
    
    NSString *destination = @"Novagee";
    NSString *text = self.message.text;
    
    if ([destination length] == 0 || [text length] == 0) {
        return;
    }
    
    SINOutgoingMessage *message = [SINOutgoingMessage messageWithRecipient:destination text:text];
    
    [[self.client messageClient] sendMessage:message];
}

#pragma mark - SINMessageClientDelegate

- (void)messageClient:(id<SINMessageClient>)messageClient didReceiveIncomingMessage:(id<SINMessage>)message {
    [_messages addObject:@[ message, @(Incoming) ]];
    [self.messageView reloadData];
    [self scrollToBottom];
}

- (void)messageSent:(id<SINMessage>)message recipientId:(NSString *)recipientId {
    [_messages addObject:@[ message, @(Outgoing) ]];
    self.message.text = @"";
    [self.messageView reloadData];
    [self scrollToBottom];
}

- (void)message:(id<SINMessage>)message shouldSendPushNotifications:(NSArray *)pushPairs {
    NSLog(@"Recipient not online. \
          Should notify recipient using push (not implemented in this demo app). \
          Please refer to the documentation for a comprehensive description.");
}

- (void)messageDelivered:(id<SINMessageDeliveryInfo>)info {
    NSLog(@"Message to %@ was successfully delivered", info.recipientId);
}

- (void)messageFailed:(id<SINMessage>)message info:(id<SINMessageFailureInfo>)failureInfo {
    NSLog(@"Failed delivering message to %@. Reason: %@", failureInfo.recipientId,
          [failureInfo.error localizedDescription]);
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_messages count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *entry = [_messages objectAtIndex:[indexPath row]];
    
    id<SINMessage> message = entry[0];
    MessageTableViewCell *cell = [self dequeOrLoadMessageTableViewCell:[entry[1] intValue]];
    
    cell.message.text = message.text;
    cell.nameLabel.text = message.senderId;
    return cell;
}

- (MessageTableViewCell *)dequeOrLoadMessageTableViewCell:(MessageDirection)direction {
    
    NSString *identifier =
    [NSString stringWithFormat:@"%@MessageCell", (Incoming == direction) ? @"Incoming" : @"Outgoing"];
    
    MessageTableViewCell *cell = [self.messageView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:identifier owner:self options:nil][0];
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
    }
    return cell;
}

#pragma mark -

/*
 Scrolls the message view to the bottom to ensure we always see the latest message.
 */
- (void)scrollToBottom {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:(_messages.count - 1)inSection:0];
    
    [self.messageView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *flipButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"取消"
                                   style:UIBarButtonItemStyleBordered
                                   target:self
                                   action:@selector(cancelMessage)];
    self.navigationItem.rightBarButtonItem = flipButton;

    self.messageView.dataSource = self;
    self.messageView.delegate = self;
    
    // Remove separator lines in table view
    self.messageView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

-(void) cancelMessage
{
    [self dismissViewControllerAnimated:YES completion:NO];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.message.delegate = self;
    
    // Add keyboard related logic
    [self registerForKeyboardNotifications];
    
    UITapGestureRecognizer *tap;
    tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}

#pragma mark - Keyboard handling

- (void)registerForKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)keyboardWillShow:(NSNotification *)note {
    // Adjust the bottom constraint to make room for the keyboard.
    CGRect keyboardFrameEnd = [[[note userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.bottomConstraint.constant = keyboardFrameEnd.size.height;
}

- (void)keyboardWillBeHidden:(NSNotification *)aNotification {
    // Restores the bottom constraint to zero, making the view span the screen.
    self.bottomConstraint.constant = 0;
    [self.messageView reloadData];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.activeField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.activeField = nil;
}

- (void)dismissKeyboard {
    [self.activeField resignFirstResponder];
}

@end
