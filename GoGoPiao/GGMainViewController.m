//
//  GGMainViewController.m
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 11/8/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import "GGMainViewController.h"

#import "GGCategoryViewController.h"
#import "GGEventViewController.h"
#import "GGOrderViewController.h"
#import "GGSellingViewController.h"
#import "GGAccountViewController.h"

@interface GGMainViewController ()

@end

@implementation GGMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//设置TabBarVC的5个VCs
        self.ggCategoryVC = [[GGCategoryViewController alloc] initWithNibName:@"GGCategoryViewController" bundle:nil];
        self.ggEventVC = [[GGEventViewController alloc] initWithNibName:@"GGEventViewController" bundle:nil];
        self.ggOrderVC = [[GGOrderViewController alloc] initWithNibName:@"GGOrderViewController" bundle:nil];
        self.ggSellingVC = [[GGSellingViewController alloc] initWithNibName:@"GGSellingViewController" bundle:nil];
        self.ggAccountVC = [[GGAccountViewController alloc] initWithNibName:@"GGAccountViewController" bundle:nil];
        NSArray *viewControllers = [[NSArray alloc] initWithObjects:self.ggCategoryVC, self.ggEventVC, self.ggOrderVC, self.ggSellingVC, self.ggAccountVC, nil];
        [self setViewControllers:viewControllers];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
