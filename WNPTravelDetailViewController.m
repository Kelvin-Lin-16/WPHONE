//
//  WNPTravelDetailViewController.m
//  WNPhone
//
//  Created by peng wan on 15-1-27.
//
//

#import "WNPTravelDetailViewController.h"
#import "WNPCell.h"
#import <Sinch/Sinch.h>
#import "CallViewController.h"

@interface WNPTravelDetailViewController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, SINCallClientDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageIndicator;
@property (strong, nonatomic) UITableViewCell *prototypeCell;
@property (strong, nonatomic) NSArray *data;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *firstImg;
@property (weak, nonatomic) IBOutlet UIImageView *secondImg;
@property (weak, nonatomic) IBOutlet UIImageView *thirdImg;
@property (weak, nonatomic) IBOutlet UIImageView *fourthImg;
@end

@implementation WNPTravelDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // Register a custom cell from Nib
    //
    [_tableView registerNib:[UINib nibWithNibName:[WNPCell cellIdentifier] bundle:nil]
     forCellReuseIdentifier:[WNPCell cellIdentifier]];
    self.tableView.allowsSelection = NO;
    
    NSArray *images = self.indexDic[@"images"];
    self.pageIndicator.numberOfPages = images.count;
    if (images.count>0) {
        [self.firstImg setImage:[UIImage imageNamed:images[0]]];
    }
    if (images.count>1) {
        [self.secondImg setImage:[UIImage imageNamed:images[1]]];
        self.secondImg.hidden=NO;
    }
    if (images.count>2) {
        [self.thirdImg setImage:[UIImage imageNamed:images[2]]];
        self.thirdImg.hidden=NO;
    }
    if (images.count>3) {
        [self.fourthImg setImage:[UIImage imageNamed:images[3]]];
        self.fourthImg.hidden=NO;
        
    }
    
    // Init a cell for caculate the custom cell's height
    //
    _prototypeCell = [self.tableView dequeueReusableCellWithIdentifier:@"WNPCell"];
    
    // Data for Demo
    //
    _data = @[
              @{
                  @"title": @"服务简介",
                  @"detail": self.indexDic[@"description"]
                  },
              @{
                  @"title": @"服务范围",
                  @"detail": @"旧金山湾区，纽约，洛杉矶，波士顿"
                  },
              @{
                  @"title": @"步骤",
                  @"detail": self.indexDic[@"steps"]
                  },
              ];
    self.titleLabel.text = self.indexDic[@"title"];
    

    
}

- (void)viewDidAppear:(BOOL)animated {
    
    // Start the scroll animation
    //
    [self preorderScrollAnimationToPage:0];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
    
}

#pragma mark - Table View Delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WNPCell *wnpCell = [self.tableView dequeueReusableCellWithIdentifier:[WNPCell cellIdentifier] forIndexPath:indexPath];
    wnpCell.titleLabel.text = self.data[indexPath.row][@"title"];
    wnpCell.detailTextView.text = self.data[indexPath.row][@"detail"];
    
    return wnpCell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WNPCell *wnpCell = (WNPCell *)self.prototypeCell;
    wnpCell.detailTextView.text = self.data[indexPath.row][@"detail"];
    
    CGSize currentCellSize = [wnpCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    CGSize textViewSize = [wnpCell.detailTextView sizeThatFits:currentCellSize];
    
    return currentCellSize.height + textViewSize.height + 1;
}

#pragma mark - Infinity Scroll Animation

- (void)preorderScrollAnimationToPage:(NSInteger)page {
    
    // Use a weak self for avoid retain cycle
    //
    __weak typeof(self) weakSelf = self;
    
    if (page >= self.pageIndicator.numberOfPages) {
        
        [self postOrderScrollAnimationToPage:page - 1];
        
    }
    else {
        
        [UIView animateWithDuration:0.5f
                              delay:5.0f
                            options:UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             
                             [weakSelf.scrollView setContentOffset:CGPointMake(page * self.scrollView.frame.size.width, 0)
                                                          animated:NO];
                             
                         }
                         completion:^(BOOL finished) {
                             
                             [weakSelf preorderScrollAnimationToPage:page + 1];
                             
                             _pageIndicator.currentPage = page;
                         }];
        
    }
    
}

- (void)postOrderScrollAnimationToPage:(NSInteger)page {
    
    // Use a weak self for avoid retain cycle
    //
    __weak typeof(self) weakSelf = self;
    
    if (page < 0) {
        
        [self preorderScrollAnimationToPage:page + 1];
        
    }
    else {
        
        [UIView animateWithDuration:0.5f
                              delay:5.0f
                            options:UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             
                             [weakSelf.scrollView setContentOffset:CGPointMake(page * self.scrollView.frame.size.width, 0)
                                                          animated:NO];
                             
                         }
                         completion:^(BOOL finished) {
                             
                             [weakSelf postOrderScrollAnimationToPage:page - 1];
                             
                             _pageIndicator.currentPage = page;
                             
                         }];
        
    }
    
}

#pragma mark - Control's Actions

- (IBAction)backButtonTouchUpInside:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];

}

- (IBAction)makePhoneCallButtonTouchUpInside:(id)sender {
    
    if ([self.client isStarted]) {
        id<SINCall> call = [self.client.callClient callUserWithId:@"Novagee"];
        [self performSegueWithIdentifier:@"callView_travel" sender:call];
    }
}

- (IBAction)sendTextButtonTouchUpInside:(id)sender {
    
    if ([self.client isStarted]) {
        [self performSegueWithIdentifier:@"messageView_travel" sender:nil];
    }
}

- (id<SINClient>)client {
    
    return [(AppDelegate *)[[UIApplication sharedApplication] delegate] client];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if (sender) {
        CallViewController *callViewController = [segue destinationViewController];
        callViewController.call = sender;
        callViewController.call.delegate = callViewController;
    }
}

#pragma mark - SINCallClientDelegate

- (void)client:(id<SINCallClient>)client didReceiveIncomingCall:(id<SINCall>)call {
    [self performSegueWithIdentifier:@"callView" sender:call];
}

- (SINLocalNotification *)client:(id<SINClient>)client localNotificationForIncomingCall:(id<SINCall>)call {
    SINLocalNotification *notification = [[SINLocalNotification alloc] init];
    notification.alertAction = @"Answer";
    notification.alertBody = [NSString stringWithFormat:@"Incoming call from %@", [call remoteUserId]];
    return notification;
}

@end
