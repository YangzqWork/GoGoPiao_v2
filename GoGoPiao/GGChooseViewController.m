//
//  GGChooseViewController.m
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 29/8/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import "GGChooseViewController.h"
#import "GGListingsViewController.h"
#import "GGSellFirstViewController.h"
#import "EventTitleView.h"

@interface GGChooseViewController ()

@end

@implementation GGChooseViewController

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
    
    self.navigationItem.title = @"票务详情";
    
    [self customizeLabel];
    [self customizeNavigationBar];
    
    self.eventTitleLabel.text = self.titleString;
    self.timeLabel.text = self.subtitleString;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

#pragma mark - Customize Appearance
- (void)customizeNavigationBar
{
    self.navigationItem.leftBarButtonItem.title = nil;
    self.navigationItem.leftBarButtonItem = nil;
    
    UIImage* backButtonImage = [UIImage imageNamed:@"nav_backBtn.png"];
    CGRect frameimgleft = CGRectMake(0, 0, backButtonImage.size.width, backButtonImage.size.height);
    UIButton *backButton = [[UIButton alloc] initWithFrame:frameimgleft];
    [backButton setBackgroundImage:backButtonImage forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(didClickBackButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backButtonItem =[[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backButtonItem;
}

- (void)customizeLabel
{
    self.eventTitleLabel.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.3];
    self.eventTitleLabel.textColor = [UIColor blackColor];
    self.timeLabel.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.3];
    self.timeLabel.textColor = [UIColor blackColor];
}

#pragma mark - Back Button
- (void)didClickBackButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
