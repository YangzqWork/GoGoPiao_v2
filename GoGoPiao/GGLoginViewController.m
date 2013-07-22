//
//  GGLoginViewController.m
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 14/7/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import "GGLoginViewController.h"
#import "GGRegisterViewController.h"
#import "GGAccountViewController.h"
#import "GGEventViewController.h"
#import "GGSettingsViewController.h"
#import "GGMainViewController.h"

@interface GGLoginViewController ()

@property (strong, nonatomic) GGMainViewController *ggMainVC;

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
    self.navigationItem.title = @"登录/注册";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginButtonPressed:(id)sender
{
//    self.tabBarController = [[UITabBarController alloc] init];
//    self.ggAcountVC = [[GGAccountViewController alloc] initWithNibName:@"GGAccountViewController" bundle:nil];
//    self.ggEventVC = [[GGEventViewController alloc] initWithNibName:@"GGEventViewController" bundle:nil];
//    self.ggSettingsVC = [[GGSettingsViewController alloc] initWithNibName:@"GGSettingsViewController" bundle:nil];
//    UINavigationController *accountNav = [[UINavigationController alloc] initWithRootViewController:self.ggAcountVC];
//    UINavigationController *eventNav = [[UINavigationController alloc] initWithRootViewController:self.ggEventVC];
//    UINavigationController *settingNav = [[UINavigationController alloc] initWithRootViewController:self.ggSettingsVC];
//    
//    NSArray* vcArray = [[NSArray alloc] initWithObjects:accountNav, eventNav, settingNav, nil];
//    [self.tabBarController setViewControllers:vcArray];
//    
//
//    [self presentViewController:self.tabBarController animated:YES completion:nil];
    self.ggMainVC = [[GGMainViewController alloc] initWithNibName:@"GGMainViewController" bundle:nil];
    UINavigationController *mainNav = [[UINavigationController alloc] initWithRootViewController:self.ggMainVC];
    [self presentViewController:mainNav animated:YES completion:nil];
}

- (IBAction)registerButtonPressed:(id)sender
{
    GGRegisterViewController *ggRegisterVC = [[GGRegisterViewController alloc] initWithNibName:@"GGRegisterViewController" bundle:nil];
    
//    [self.navigationController pushViewController:ggRegisterVC animated:YES];
    [self presentViewController:ggRegisterVC animated:YES completion:nil];
}

- (void)viewDidUnload {
    [self setLoginButton:nil];
    [self setRegisterButton:nil];
    [super viewDidUnload];
}
@end
