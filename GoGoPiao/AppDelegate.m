//
//  AppDelegate.m
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 14/7/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import "AppDelegate.h"
#import "GGLoginViewController.h"
#import "GGEventViewController.h"
#import "GGMoreViewController.h"
#import "GGAccountViewController.h"
#import "GGMainViewController.h"
#import "GGAuthManager.h"
#import "Constants.h"
#import "MKNetworkOperation.h"

@interface AppDelegate ()

@property (nonatomic, strong) NSString *uniqueID;

@end

@implementation AppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

#pragma mark - Default
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    
    [self setUpNetworkEngine];
    [self getCFUUID];
    
    self.ggMainVC = [[GGMainViewController alloc] initWithNibName:@"GGMainViewController" bundle:nil];
    
    GGEventViewController *ggEventVC = [[GGEventViewController alloc] initWithNibName:@"GGEventViewController" bundle:nil];
    GGAccountViewController *ggAccountVC = [[GGAccountViewController alloc] initWithNibName:@"GGAccountViewController" bundle:nil];
    GGMoreViewController *ggMoreVC = [[GGMoreViewController alloc] initWithNibName:@"GGMoreViewController" bundle:nil];
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:ggEventVC];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:ggAccountVC];
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:ggMoreVC];
    //        NSArray *viewControllers = [[NSArray alloc] initWithObjects:self.ggCategoryVC, self.ggEventVC, self.ggOrderVC, self.ggSellingVC, self.ggAccountVC, nil];
    NSArray *viewControllers = [[NSArray alloc] initWithObjects:nav1, nav2, nav3, nil];
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    [tabBarController setViewControllers:viewControllers];
    
    [self.window setRootViewController:tabBarController];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    [self customizeiPhoneTheme];
    
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

#pragma mark - Core Data Stack
- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext =self.managedObjectContext;
    if (managedObjectContext !=nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolvederror %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext !=nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc]init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application'smodel.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel !=nil) {
        return _managedObjectModel;
    }
    //这里一定要注意，这里的iWeather就是你刚才建立的数据模型的名字，一定要一致。否则会报错。
    NSURL *modelURL = [[NSBundle mainBundle]URLForResource:@"GoGoPiao" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc]initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and theapplication's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator !=nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory]URLByAppendingPathComponent:@"GoGoPiao.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        NSLog(@"Unresolvederror %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL*)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager]URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask]lastObject];
}

#pragma mark - 自定义
- (void)customizeiPhoneTheme
{
    [[UIApplication sharedApplication]
     setStatusBarStyle:UIStatusBarStyleBlackOpaque animated:NO];
    [self cutsomizeUINavigationBar];
    [self customizeUISegmentControl];
    [self customizeUITabBar];
    [self customizeUISearchBar];
}

- (void)setUpNetworkEngine
{
    NSMutableDictionary *headerFields = [NSMutableDictionary dictionary];
    headerFields[@"Content-Type"] = @"application/json";
    self.networkEngine = [[MKNetworkEngine alloc] initWithHostName:K_HOST_URL customHeaderFields:headerFields];
//    [self.networkEngine useCache];
}

- (void)getCFUUID
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    id uuid = [defaults objectForKey:@"UUID"];
    
    if (uuid)
        self.uniqueID = [NSString stringWithString:(NSString *)uuid];
    else {
        CFUUIDRef temp = CFUUIDCreate(NULL);
        CFStringRef cfUuid = CFUUIDCreateString(NULL, temp);
        self.uniqueID = [NSString stringWithString:(__bridge NSString*) cfUuid];
        CFRelease(cfUuid);
        CFRelease(temp);
        
        [defaults setObject:self.uniqueID forKey:@"UUID"]; // warning here
    }
}

#pragma mark - 自定义控件
- (void)cutsomizeUINavigationBar
{
    //UINavigationBar
    [[UINavigationBar appearance] setShadowImage:[UIImage imageNamed:@"nav_shadow.png"]];
    UIImage *navBarImage = [UIImage imageNamed:@"nav_bg.png"];
    [[UINavigationBar appearance] setBackgroundImage:navBarImage forBarMetrics:UIBarMetricsDefault];
    
    
    //    UIImage *backButton = [[UIImage imageNamed:@"nav_backBtn.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 14, 0, 4)];
    //    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButton forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
}

- (void)customizeUITabBar
{
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    UITabBar *tabBar = tabBarController.tabBar;
    UITabBarItem *item0 = [tabBar.items objectAtIndex:0];
    UITabBarItem *item1 = [tabBar.items objectAtIndex:1];
    UITabBarItem *item2 = [tabBar.items objectAtIndex:2];
    
    item0.title = @"场次";
    item1.title = @"我的";
    item2.title = @"更多";
    
    [item0 setFinishedSelectedImage:[UIImage imageNamed:@"icon_cc.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"icon_cc.png"]];
    [item1 setFinishedSelectedImage:[UIImage imageNamed:@"icon_wd.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"icon_wd.png"]];
    [item2 setFinishedSelectedImage:[UIImage imageNamed:@"icon_mr.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"icon_mr.png"]];
    
    [[UITabBar appearance] setSelectionIndicatorImage:[UIImage imageNamed:@"tab_indicator.png"]];

}

- (void)customizeUISegmentControl
{
    UIImage *segmentSelected = [[UIImage imageNamed:@"seg_selectedBtn.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1)];
    UIImage *segmentUnselected = [[UIImage imageNamed:@"seg_normalBtn.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1)];
    
    [[UISegmentedControl appearance] setBackgroundImage:segmentUnselected forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UISegmentedControl appearance] setBackgroundImage:segmentSelected forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    [[UISegmentedControl appearance] setDividerImage:[UIImage imageNamed:@"seg_bg_line.png"] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UISegmentedControl appearance] setDividerImage:[UIImage imageNamed:@"seg_bg_line.png"] forLeftSegmentState:UIControlStateSelected rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UISegmentedControl appearance] setDividerImage:[UIImage imageNamed:@"seg_bg_line.png"] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    [[UISegmentedControl appearance] setTitleTextAttributes:
     @{
                                  UITextAttributeTextColor : [UIColor blackColor],
                            UITextAttributeTextShadowColor : [UIColor clearColor],
     
     } forState:UIControlStateNormal];
    [[UISegmentedControl appearance] setTitleTextAttributes:
     @{
                                  UITextAttributeTextColor : [UIColor blackColor],
                            UITextAttributeTextShadowColor : [UIColor clearColor],
     
     }  forState:UIControlStateSelected];
}

- (void)customizeUISearchBar
{
    //UISearchBar
    [[UISearchBar appearance] setSearchFieldBackgroundImage:[UIImage imageNamed:@"search_barBg.png"] forState:UIControlStateNormal];
    [[UISearchBar appearance] setSearchFieldBackgroundImage:[UIImage imageNamed:@"search_barBg.png"] forState:UIControlStateSelected];
    [[UISearchBar appearance] setBackgroundImage:[UIImage imageNamed:@"search_bg.png"]];
    
    //SearchBar -- Cancel Button
    UIBarButtonItem *searchBarButton = [UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil];
    [searchBarButton setBackgroundImage:[UIImage imageNamed:@"search_bg_line.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [searchBarButton setBackgroundImage:[UIImage imageNamed:@"search_bg_line.png"] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
#warning EXC_BAD in iOS7
    [searchBarButton setTitle:@"取消"];
    [searchBarButton setTitleTextAttributes:@{UITextAttributeTextColor : [UIColor blackColor]} forState:UIControlStateNormal];
    [searchBarButton setTitleTextAttributes:@{UITextAttributeTextColor : [UIColor grayColor]} forState:UIControlStateSelected];
}

@end
