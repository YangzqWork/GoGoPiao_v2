//
//  GGSellingViewController.m
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 11/8/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import "GGSellingViewController.h"

@interface GGSellingViewController ()

@end

@implementation GGSellingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"我要转让";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.searchBar.backgroundColor = [UIColor clearColor];
    
    //去掉搜索框背景
    for (UIView *subview in self.searchBar.subviews)
    {
        if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")])
        {
            [subview removeFromSuperview];
            break;  
        }  
    }
    
    //自定义背景
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"2-red-menu-bar.png"]];
    [self.searchBar insertSubview:imageView atIndex:1];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setSearchBar:nil];
    [super viewDidUnload];
}
@end
