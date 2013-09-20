//
//  GGFilterViewController.m
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 11/9/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import "GGFilterViewController.h"
#import "UIBarButtonItem+ProjectButton.h"
#import "UISearchBar+ProjectSearchBar.h"

@interface GGFilterViewController ()

@end

@implementation GGFilterViewController

#pragma mark - Life Cycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self customizeTheme];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [self setSearchBar:nil];
    [self setTableView:nil];
    [super viewDidUnload];
}

#pragma mark - Customization

- (void)customizeTheme
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem createButtonWithImage:[UIImage imageNamed:@"nav_backBtn.png"] WithTarget:self action:@selector(back)];
    
    [_searchBar becomeFirstResponder];
}

@end
