//
//  GGMainViewController.m
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 11/8/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import "GGMainViewController.h"
#import "GGEventViewController.h"
#import "GGAccountViewController.h"
#import "GGMoreViewController.h"

@interface GGMainViewController ()

@end

@implementation GGMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//设置TabBarVC的5个VCs
        self.ggEventVC = [[GGEventViewController alloc] initWithNibName:@"GGEventViewController" bundle:nil];
        self.ggAccountVC = [[GGAccountViewController alloc] initWithNibName:@"GGAccountViewController" bundle:nil];
        self.ggMoreVC = [[GGMoreViewController alloc] initWithNibName:@"GGMoreViewController" bundle:nil]; 
        UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:self.ggEventVC];
        UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:self.ggAccountVC];
        UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:self.ggMoreVC];
//        NSArray *viewControllers = [[NSArray alloc] initWithObjects:self.ggCategoryVC, self.ggEventVC, self.ggOrderVC, self.ggSellingVC, self.ggAccountVC, nil];
        NSArray *viewControllers = [[NSArray alloc] initWithObjects:nav1, nav2, nav3, nil];
        [self setViewControllers:viewControllers];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self customizeTabBar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)customizeTabBar
{
    UITabBarController *tabBarController = self;
    UITabBar *tabBar = tabBarController.tabBar;
    UITabBarItem *item0 = [tabBar.items objectAtIndex:0];
    UITabBarItem *item1 = [tabBar.items objectAtIndex:1];
    UITabBarItem *item2 = [tabBar.items objectAtIndex:2];
    
    [item0 setTitle:@"场次"];
    
    [item0 setFinishedSelectedImage:[UIImage imageNamed:@"icon_cc.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"icon_cc.png"]];
    [item1 setFinishedSelectedImage:[UIImage imageNamed:@"icon_wd.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"icon_wd.png"]];
    [item2 setFinishedSelectedImage:[UIImage imageNamed:@"icon_mr.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"icon_mr.png"]];
    
    [[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"tab_indicator.png"]];
}

@end
