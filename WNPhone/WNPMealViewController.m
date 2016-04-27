//
//  WNPMealViewController.m
//  WNPhone
//
//  Created by Paul on 1/24/15.
//
//

#import "WNPMealViewController.h"
#import "WNPMealDetailViewController.h"

@interface WNPMealViewController ()

@property (strong, nonatomic) UIView *customNavigationBar;
@property (strong, nonatomic) UILabel *customNavigationBarTitle;
@property (strong, nonatomic) UIButton *customNavigationBarButton;
@property (strong, nonatomic) NSArray *indexArray;

@end

@implementation WNPMealViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.indexArray = [[NSArray alloc] initWithObjects:
  @{@"title":@"送外卖",@"description":@"选择系统内设电话功能，免费预定酒店。小叮当助手可依据您的需求提供酒店筛选及预定服务 。离开预定酒店时只需支付住房费用即可",@"steps":@"1-使用内设电话连接客服专员\n2-提供所需信息：姓名，电话\n3-提供咨询信息：预算，人数，入住和退房时间，地点以及特殊要求\n4-收取酒店确认明细",@"images":@[@"delivery01.jpg",@"delivery02.jpg",@"delivery03.jpg"]},
  @{@"title":@"订座预约",@"description":@"选择系统内设电话功能，免费预定机票。小叮当助手可依据您的需求提供航班筛选及订票服务 。出票前只需支付机票费用即可",@"steps":@"1-使用内设电话连接客服专员\n2-提供所需信息：姓名，电话\n3-提供咨询信息：预算，人数，日期，出发地和目的地以及特殊要求\n4-收取行程确认明细",@"images":@[@"reservation01.jpg",@"reservation02.jpg",@"reservation03.jpg"]},
  @{@"title":@"餐厅推荐",@"description":@"选择系统内设短信功能，免费咨询购房相关信息。小叮当助手可根据您的疑问（购房法律，中价信息，地段筛选，律师推荐以及价格涨幅等），提供有效信息",@"steps":@"1-使用内设短信功能连接客服专员\n2-提供所需信息：姓名，预算，地段以及其它要求\n3-提出购房相关疑问\n4-收取解答方案明细",@"images":@[@"recommendation01.jpg",@"recommendation02.jpg",@"recommendation03.jpg"]}, nil];

    [self configureCustomNavigationBar];
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
    _customNavigationBarTitle.text = @"点餐";
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
            slidingMenuCell.textLabel.text = @"送外卖";
            slidingMenuCell.detailTextLabel.text = @"";
            slidingMenuCell.backgroundImageView.image = [UIImage imageNamed:@"delivery"];
            break;
            
        case 2:
            slidingMenuCell.textLabel.text = @"订座预约";
            slidingMenuCell.detailTextLabel.text = @"";
            slidingMenuCell.backgroundImageView.image = [UIImage imageNamed:@"reservation"];
            break;
            
        case 3:
            slidingMenuCell.textLabel.text = @"餐厅推荐";
            slidingMenuCell.detailTextLabel.text = @"";
            slidingMenuCell.backgroundImageView.image = [UIImage imageNamed:@"recommendation"];
            break;
            
        case 0:
            slidingMenuCell.textLabel.text = @"";
            slidingMenuCell.detailTextLabel.text = @"天天饮食助手，可根据您的个人口味喜好，推荐理想的餐饮去处，让您0风险坐享其成";
            slidingMenuCell.backgroundImageView.image = [UIImage imageNamed:@"defaultBackground"];
            slidingMenuCell.categoryImageView.image = [UIImage imageNamed:@"meal"];
            break;
        default:
            break;
    }
}

- (void)slidingMenu:(RPSlidingMenuViewController *)slidingMenu didSelectItemAtRow:(NSInteger)row{
    
    [super slidingMenu:slidingMenu didSelectItemAtRow:row];
    
    if (row) {
    WNPMealDetailViewController *wnpCarDetailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"wnpMealDetailView"];
        wnpCarDetailViewController.indexDic = self.indexArray[row-1];
        [self.navigationController pushViewController:wnpCarDetailViewController animated:YES];
    }
    
}


@end
