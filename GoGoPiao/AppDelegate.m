//
//  AppDelegate.m
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 14/7/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import "AppDelegate.h"
#import "GGLoginViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    
//NavigationBar的设定
    [self customizeiPhoneTheme];

//RootVC和Navigation的设定
    self.ggLoginVC = [[GGLoginViewController alloc] init];
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:self.ggLoginVC];
    [self.window addSubview:self.navigationController.view];    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - 自定义
- (void)customizeiPhoneTheme
{
    [[UIApplication sharedApplication]
     setStatusBarStyle:UIStatusBarStyleBlackOpaque animated:NO];
    
    UIImage *navBarImage = [UIImage imageNamed:@"5-orange-menu-bar.png"];
    
    [[UINavigationBar appearance] setBackgroundImage:navBarImage forBarMetrics:UIBarMetricsDefault];
    
    
    UIImage *barButton = [[UIImage imageNamed:@"5-orange-settings-button.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 4, 0, 4)];
    
    [[UIBarButtonItem appearance] setBackgroundImage:barButton forState:UIControlStateNormal
                                          barMetrics:UIBarMetricsDefault];
    
    UIImage *backButton = [[UIImage imageNamed:@"5-orange-back-button.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 14, 0, 4)];
    
    
    
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButton forState:UIControlStateNormal
                                                    barMetrics:UIBarMetricsDefault];
    
    UIImage* tabBarBackground = [UIImage imageNamed:@"tabbar.png"];
    [[UITabBar appearance] setBackgroundImage:tabBarBackground];
    
    
    [[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"tabbar_selected.png"]];
}


@end
