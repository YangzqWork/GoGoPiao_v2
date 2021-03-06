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
#import "UIBarButtonItem+ProjectButton.h"

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
    
    [self customizeImage];
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

- (void)customizeImage
{
    self.eventImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.eventImageView.autoresizingMask = (UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth);
    [self.eventImageView setImage:self.eventImage];
}

- (void)customizeNavigationBar
{
    self.navigationItem.leftBarButtonItems = [UIBarButtonItem createEdgeButtonWithImage:[UIImage imageNamed:@"nav_backBtn.png"] WithTarget:self action:@selector(didClickBackButton)];
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
