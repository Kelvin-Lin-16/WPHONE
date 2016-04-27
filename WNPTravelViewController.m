//
//  WNPTravelViewController.m
//  WNPhone
//
//  Created by Paul on 1/26/15.
//
//

#import "WNPTravelViewController.h"
#import "WNPTravelDetailViewController.h"

@interface WNPTravelViewController ()

@property (strong, nonatomic) UIView *customNavigationBar;
@property (strong, nonatomic) UILabel *customNavigationBarTitle;
@property (strong, nonatomic) UIButton *customNavigationBarButton;
@property (strong, nonatomic) NSArray *indexArray;

@end

@implementation WNPTravelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configureCustomNavigationBar];
    self.indexArray = [[NSArray alloc] initWithObjects:
  @{@"title":@"酒店",@"description":@"选择系统内设电话功能，免费预定酒店。小叮当助手可依据您的需求提供酒店筛选及预定服务 。离开预定酒店时只需支付住房费用即可",@"steps":@"1-使用内设电话连接客服专员\n2-提供所需信息：姓名，电话\n3-提供咨询信息：预算，人数，入住和退房时间，地点以及特殊要求\n4-收取酒店确认明细",@"images":@[@"hotel01.jpg",@"hotel02.jpg",@"hotel03.jpg"]},
  @{@"title":@"机票",@"description":@"选择系统内设电话功能，免费预定机票。小叮当助手可依据您的需求提供航班筛选及订票服务 。出票前只需支付机票费用即可",@"steps":@"1-使用内设电话连接客服专员\n2-提供所需信息：姓名，电话\n3-提供咨询信息：预算，人数，日期，出发地和目的地以及特殊要求\n4-收取行程确认明细",@"images":@[@"flight01.jpg",@"flight02.jpg",@"flight03.jpg"]},
  @{@"title":@"私人定制",@"description":@"选择系统内设短信功能，免费咨询购房相关信息。小叮当助手可根据您的疑问（购房法律，中价信息，地段筛选，律师推荐以及价格涨幅等），提供有效信息",@"steps":@"1-使用内设短信功能连接客服专员\n2-提供所需信息：姓名，预算，地段以及其它要求\n3-提出购房相关疑问\n4-收取解答方案明细",@"images":@[@"recommendation01.jpg",@"recommendation02.jpg",@"recommendation03.jpg"]}, nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureCustomNavigationBar {
    
    _customNavigationBar = self.menuNavigationBar;
    
    _customNavigationBarButton = self.menuNavigationBarButton;
    [_customNavigationBar addSubview:self.customNavigationBarButton];
    
    _customNavigationBarTitle = self.menuNavigationBarTitle;
    _customNavigationBarTitle.text = @"旅游";
    [_customNavigationBar addSubview:self.customNavigationBarTitle];
    
}

-(NSInteger)numberOfItemsInSlidingMenu{
    // 10 for demo purposes, typically the count of some array
    return 4;
}

- (void)customizeCell:(RPSlidingMenuCell *)slidingMenuCell forRow:(NSInteger)row{
    
    // alternate for demo.  Simply set the properties of the passed in cell
    
    switch (row) {
            
        case 1:
            slidingMenuCell.textLabel.text = @"酒店";
            slidingMenuCell.detailTextLabel.text = @"";
            slidingMenuCell.backgroundImageView.image = [UIImage imageNamed:@"hotel"];
            break;
            
        case 2:
            slidingMenuCell.textLabel.text = @"机票";
            slidingMenuCell.detailTextLabel.text = @"";
            slidingMenuCell.backgroundImageView.image = [UIImage imageNamed:@"flight"];
            break;
            
        case 3:
            slidingMenuCell.textLabel.text = @"私人定制";
            slidingMenuCell.detailTextLabel.text = @"";
            slidingMenuCell.backgroundImageView.image = [UIImage imageNamed:@"flight"];
            break;
            
        case 0:
            slidingMenuCell.textLabel.text = @"";
            slidingMenuCell.detailTextLabel.text = @"旅行助手，可根据您的个性需求，定制最佳旅行方案，让您的出行顺畅0纠结";
            slidingMenuCell.backgroundImageView.image = [UIImage imageNamed:@"defaultBackground"];
            slidingMenuCell.categoryImageView.image = [UIImage imageNamed:@"camera"];
            break;
        default:
            break;
    }
}

- (void)slidingMenu:(RPSlidingMenuViewController *)slidingMenu didSelectItemAtRow:(NSInteger)row{
    
    [super slidingMenu:slidingMenu didSelectItemAtRow:row];
    
    if (row) {

    WNPTravelDetailViewController *wnpCarDetailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"wnpTravelDetailView"];
    wnpCarDetailViewController.indexDic = self.indexArray[row-1];
    [self.navigationController pushViewController:wnpCarDetailViewController animated:YES];
    }
    
}

@end
