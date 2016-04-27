//
//  WNPOtherViewController.m
//  WNPhone
//
//  Created by peng wan on 15-1-27.
//
//

#import "WNPOtherViewController.h"
#import "WNPOtherDetailViewController.h"

@interface WNPOtherViewController ()

@property (strong, nonatomic) UIView *customNavigationBar;
@property (strong, nonatomic) UILabel *customNavigationBarTitle;
@property (strong, nonatomic) UIButton *customNavigationBarButton;
@property (strong, nonatomic) NSArray *indexArray;

@end

@implementation WNPOtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configureCustomNavigationBar];
    self.indexArray = [[NSArray alloc] initWithObjects:
  @{@"title":@"报税",@"description":@"选择系统内设短信功能，免费咨询保税相关事宜。小叮当助手可根据您的疑问（保税时间，身份限制，填写税单以及退税等），提供相应最佳解决方案",@"steps":@"1-使用内设短信功能连接客服专员\n2-提供所需信息：姓名，当下身份\n3-提出保税相关疑问\n4-收取解答方案明细",@"images":@[@"law01.jpg",@"law02.jpg",@"law03.jpg"]},
  @{@"title":@"医疗",@"description":@"选择系统内设短信功能，免费咨询医疗相关事宜。小叮当助手可根据您的疑问（医疗保险，医院筛选，医生推荐以及价格估算等），提供可靠信息",@"steps":@"1-使用内设短信功能连接客服专员\n2-提供所需信息：姓名，预算和病况\n3-提出医疗相关疑问\n4-收取答疑信息明细",@"images":@[@"medical01.jpg",@"medical02.jpg",@"medical03.jpg"]},
  @{@"title":@"买房",@"description":@"选择系统内设短信功能，免费咨询购房相关信息。小叮当助手可根据您的疑问（购房法律，中价信息，地段筛选，律师推荐以及价格涨幅等），提供有效信息",@"steps":@"1-使用内设短信功能连接客服专员\n2-提供所需信息：姓名，预算，地段以及其它要求\n3-提出购房相关疑问\n4-收取解答方案明细",@"images":@[@"house01.jpg",@"house02.jpg",@"house03.jpg"]},
  @{@"title":@"租房",@"description":@"选择系统内设短信功能，免费咨询租房相关信息。小叮当助手可根据您的疑问（租房合同，中价信息，地段筛选，法律条约以及退租，转租等事项），提供有效信息",@"steps":@"1-使用内设短信功能连接客服专员\n2-提供所需信息：姓名，预算，地段以及其它要求\n3-提出租房相关疑问\n4-收取解答方案明细",@"images":@[@"lease01.jpg",@"lease02.jpg",@"lease03.jpg"]},
  @{@"title":@"求学",@"description":@"选择系统内设短信功能，免费咨询在美求学相关信息。小叮当助手可根据您的疑问（学校信息，申请资料，治安状况，专业排名以及报考事项等），提供相应信息",@"steps":@"1-使用内设短信功能连接客服专员\n2-提供所需信息：姓名，预算，身份状态以及自身要求\m3-提出求学相关疑问\n4-收取答疑明细",@"images":@[@"education01.jpg",@"education02.jpg",@"education03.jpg"]},
  @{@"title":@"感情",@"description":@"选择系统内设短信功能，免费咨询在美情感问题解决方案。小叮当助手可根据您的疑问（身份变动，感情纠纷，律师推荐，红娘牵线以及情感建议等），提供相应信息",@"steps":@"1-使用内设短信功能连接客服专员\n2-提供所需信息：姓名，地点，身份状态以及自身要求\n3-提出情感相关疑问\n4-收取答疑明细",@"images":@[@"relationship01.jpg",@"relationship02.jpg",@"relationship03.jpg"]}, nil];
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
    _customNavigationBarTitle.text = @"其它";
    [_customNavigationBar addSubview:self.customNavigationBarTitle];
    
}

-(NSInteger)numberOfItemsInSlidingMenu{
    // 10 for demo purposes, typically the count of some array
    return 7;
}

- (void)customizeCell:(RPSlidingMenuCell *)slidingMenuCell forRow:(NSInteger)row{
    
    // alternate for demo.  Simply set the properties of the passed in cell
    
    switch (row) {
            
        case 1:
            slidingMenuCell.textLabel.text = @"报税";
            slidingMenuCell.detailTextLabel.text = @"";
            slidingMenuCell.backgroundImageView.image = [UIImage imageNamed:@"tax"];
            break;
            
        case 2:
            slidingMenuCell.textLabel.text = @"医疗";
            slidingMenuCell.detailTextLabel.text = @"";
            slidingMenuCell.backgroundImageView.image = [UIImage imageNamed:@"medical"];
            break;
            
        case 3:
            slidingMenuCell.textLabel.text = @"买房";
            slidingMenuCell.detailTextLabel.text = @"";
            slidingMenuCell.backgroundImageView.image = [UIImage imageNamed:@"house"];
            break;
            
        case 4:
            slidingMenuCell.textLabel.text = @"租房";
            slidingMenuCell.detailTextLabel.text = @"";
            slidingMenuCell.backgroundImageView.image = [UIImage imageNamed:@"rent"];
            break;
            
        case 5:
            slidingMenuCell.textLabel.text = @"求学";
            slidingMenuCell.detailTextLabel.text = @"";
            slidingMenuCell.backgroundImageView.image = [UIImage imageNamed:@"education"];
            break;
            
        case 6:
            slidingMenuCell.textLabel.text = @"感情";
            slidingMenuCell.detailTextLabel.text = @"";
            slidingMenuCell.backgroundImageView.image = [UIImage imageNamed:@"relationship"];
            break;
            
        case 0:
            slidingMenuCell.textLabel.text = @"";
            slidingMenuCell.detailTextLabel.text = @"万能助手，细心为您解答北美生活须知, 全部免费，让您在美生活0困惑。";
            slidingMenuCell.backgroundImageView.image = [UIImage imageNamed:@"defaultBackground"];
            slidingMenuCell.categoryImageView.image = [UIImage imageNamed:@"more"];
            break;
        default:
            break;
    }}

- (void)slidingMenu:(RPSlidingMenuViewController *)slidingMenu didSelectItemAtRow:(NSInteger)row{
    
    [super slidingMenu:slidingMenu didSelectItemAtRow:row];
    
    if (row) {
        WNPOtherDetailViewController *wnpCarDetailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"wnpOtherDetailView"];
        wnpCarDetailViewController.indexDic = self.indexArray[row-1];
        
        [self.navigationController pushViewController:wnpCarDetailViewController animated:YES];
    }
}

@end
