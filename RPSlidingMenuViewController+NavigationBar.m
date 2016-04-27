//
//  RPSlidingMenuViewController+NavigationBar.m
//  WNPhone
//
//  Created by Paul on 2/1/15.
//
//

#import "RPSlidingMenuViewController+NavigationBar.h"

@implementation RPSlidingMenuViewController (NavigationBar)

- (UIView *)menuNavigationBar {
    
    // Configure navigation bar
    //
    UIView *menuNavigationBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
    menuNavigationBar.backgroundColor = [UIColor colorWithRed:0.25 green:0.59 blue:0.85 alpha:1];
    [self.view addSubview:menuNavigationBar];
    
    return menuNavigationBar;
}

- (UIButton *)menuNavigationBarButton {
    
    UIButton *menuNavigationBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    menuNavigationBarButton.frame = CGRectMake(0, 20, 100, 44);
    
    menuNavigationBarButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [menuNavigationBarButton setTitle:@"小叮当助手" forState:UIControlStateNormal];
    [menuNavigationBarButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    return menuNavigationBarButton;
}

- (UILabel *)menuNavigationBarTitle {
    
    UILabel *menuNavigationBarTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 44)];
    menuNavigationBarTitle.font = [UIFont systemFontOfSize:15];
    menuNavigationBarTitle.textColor = [UIColor whiteColor];
    menuNavigationBarTitle.textAlignment = NSTextAlignmentCenter;
    
    return menuNavigationBarTitle;
}

@end
