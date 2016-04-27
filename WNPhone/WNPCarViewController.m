//
//  WNPCarViewController.m
//  SinchCalling
//
//  Created by peng wan on 15-1-21.
//
//

#import "WNPCarViewController.h"
#import "WNPCarDetailViewController.h"

@interface WNPCarViewController ()

@property (strong, nonatomic) UIView *customNavigationBar;
@property (strong, nonatomic) UILabel *customNavigationBarTitle;
@property (strong, nonatomic) UIButton *customNavigationBarButton;
@property (strong, nonatomic) NSArray *indexArray;

@end

@implementation WNPCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.scrollsToCollapsedRowsOnSelection = NO;
    self.indexArray = [[NSArray alloc] initWithObjects:
  @{@"title":@"电召车",@"description":@"选择系统内设电话功能，免费预定。小叮当助手将根据您所提供的信息立即预约，确保您的出行。到达目的地后支付乘车费用即可",@"steps":@"1-拨打内设电话连接客服专员\n2-提供所需信息：姓名，电话，时间，所在地，目的地\n3-收取确认信息：车号，车款以及车的颜色",@"images":@[@"taxi01.jpg",@"taxi02.jpg",@"taxi03.jpg"]},
  @{@"title":@"租车",@"description":@"选择系统内设电话或短信功能，免费租车。小叮当助手将依照你给出的要求挑选出最符合您出行的租车信息和建议供您参考",@"steps":@"1-使用内设电话或短信连接客服专员\n2-提供所需信息：姓名，电话\n3-提供咨询信息：预算，目的，人数，时间，地点，要求\n4-收取最佳建议明细",@"images":@[@"rent01.jpg",@"rent02.jpg",@"rent03.jpg"]},
  @{@"title":@"购物拼车",@"description":@"选择系统内设电话功能，免费拼车。小叮当助手可依据您的需求提供安全拼车服务。确保您愉快购物。出行前只需支付乘车费用即可",@"steps":@"1-使用内设电话连接客服专员\n2-提供所需信息：姓名，电话\n3-提供咨询信息：预算，人数，时间，所在地，目的地及附加要求\n4-收取确认明细",@"images":@[@"shopping01.jpg",@"shopping02.jpg",@"shopping03.jpg"]}, nil];
    [self configureCustomNavigationBar];
}

- (void)viewDidAppear:(BOOL)animated {


    
}

- (void)configureCustomNavigationBar {
    
    _customNavigationBar = self.menuNavigationBar;
    
    _customNavigationBarButton = self.menuNavigationBarButton;
    [_customNavigationBar addSubview:self.customNavigationBarButton];
    
    _customNavigationBarTitle = self.menuNavigationBarTitle;
    _customNavigationBarTitle.text = @"叫车";
    [_customNavigationBar addSubview:self.customNavigationBarTitle];
    
}

#pragma mark - RPSlidingMenuViewController

-(NSInteger)numberOfItemsInSlidingMenu{
    // 10 for demo purposes, typically the count of some array
    return 4;
}

- (void)customizeCell:(RPSlidingMenuCell *)slidingMenuCell forRow:(NSInteger)row{
    
    // alternate for demo.  Simply set the properties of the passed in cell
    
    switch (row) {
        case 1:
            slidingMenuCell.textLabel.text = @"电召车";
            slidingMenuCell.detailTextLabel.text = @"";
            slidingMenuCell.backgroundImageView.image = [UIImage imageNamed:@"CAR3"];
            break;
            
        case 2:
            slidingMenuCell.textLabel.text = @"租车";
            slidingMenuCell.detailTextLabel.text = @"";
            slidingMenuCell.backgroundImageView.image = [UIImage imageNamed:@"CAR1"];
            break;
            
        case 3:
            slidingMenuCell.textLabel.text = @"购物租车";
            slidingMenuCell.detailTextLabel.text = @"";
            slidingMenuCell.backgroundImageView.image = [UIImage imageNamed:@"CAR2"];
            break;
            
        case 0:
            slidingMenuCell.textLabel.text = @"";
            slidingMenuCell.detailTextLabel.text = @"专车出行助手，可根据您的出行安排，提供专车服务，让您在美帝出行0烦恼";
            slidingMenuCell.backgroundImageView.image = [UIImage imageNamed:@"defaultBackground"];
            slidingMenuCell.categoryImageView.image = [UIImage imageNamed:@"car_tab"];
            break;
        default:
            break;
    }

}

- (void)slidingMenu:(RPSlidingMenuViewController *)slidingMenu didSelectItemAtRow:(NSInteger)row{
    
    [super slidingMenu:slidingMenu didSelectItemAtRow:row];
    
    if (row) {
    WNPCarDetailViewController *wnpCarDetailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"wnpCarDetailView"];
        wnpCarDetailViewController.indexDic = self.indexArray[row-1];
        [self.navigationController pushViewController:wnpCarDetailViewController animated:YES];
    }
}

@end
