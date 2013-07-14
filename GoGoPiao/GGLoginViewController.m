//
//  GGLoginViewController.m
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 14/7/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import "GGLoginViewController.h"
#import "GGAccountViewController.h"
#import "GGEventViewController.h"
#import "GGSettingsViewController.h"

@interface GGLoginViewController ()

@end

@implementation GGLoginViewController

@synthesize ggAcountVC;
@synthesize ggEventVC;
@synthesize ggSettingsVC;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Login";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(rightBarButtonItemPressed)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)rightBarButtonItemPressed
{
    self.tabBarController = [[UITabBarController alloc] init];
    self.ggAcountVC = [[GGAccountViewController alloc] initWithNibName:nil bundle:nil];
    self.ggEventVC = [[GGEventViewController alloc] initWithNibName:nil bundle:nil];
    self.ggSettingsVC = [[GGSettingsViewController alloc] initWithNibName:nil bundle:nil];
    NSArray* vcArray = [[NSArray alloc] initWithObjects:
                        ggAcountVC,
                        ggEventVC,
                        ggSettingsVC, nil];
    [self.tabBarController setViewControllers:vcArray];
    
//TabBarController由Navigation控制
    [self.navigationController pushViewController:self.tabBarController animated:YES];
}

@end
