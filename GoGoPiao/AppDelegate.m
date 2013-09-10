//
//  AppDelegate.m
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 14/7/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import "AppDelegate.h"
#import "GGLoginViewController.h"
#import "GGMainViewController.h"
#import "GGAuthManager.h"
#import "Constants.h"
#import "MKNetworkOperation.h"

@implementation AppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

#pragma mark - Default
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    
    [self customizeiPhoneTheme];
    [self setUpNetworkEngine];
//    [self getCFUUID];
    
    self.ggMainVC = [[GGMainViewController alloc] initWithNibName:@"GGMainViewController" bundle:nil];
    [self.window setRootViewController:self.ggMainVC];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
//    [self getTravellerToken];

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

//UINavigationBar
    [[UINavigationBar appearance] setShadowImage:[UIImage imageNamed:@"nav_shadow.png"]];
    
    UIImage *navBarImage = [UIImage imageNamed:@"nav_bg.png"];
    
    [[UINavigationBar appearance] setBackgroundImage:navBarImage forBarMetrics:UIBarMetricsDefault];
    
    
//    UIImage *backButton = [[UIImage imageNamed:@"nav_backBtn.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 14, 0, 4)];
//    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButton forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    


//UITabBar
    UIImage *tabBarBackground = [UIImage imageNamed:@"tab_bg.png"];
    [[UITabBar appearance] setBackgroundImage:tabBarBackground];
    
    UIImage *tabBarIndicatorImage = [UIImage imageNamed:@"tab_indicator.png"];
    [[UITabBar appearance] setSelectionIndicatorImage:tabBarIndicatorImage];
    
    
//UISegmentControl
    UIImage *segmentSelected =
    [UIImage imageNamed:@"seg_selectedBtn.png"];
    UIImage *segmentUnselected =
    [UIImage imageNamed:@"seg_normalBtn.png"];
    
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
    
//UISearchBar
    [[UISearchBar appearance] setSearchFieldBackgroundImage:[UIImage imageNamed:@"search_bar.png"] forState:UIControlStateNormal];
    [[UISearchBar appearance] setSearchFieldBackgroundImage:[UIImage imageNamed:@"search_bar.png"] forState:UIControlStateSelected];
    [[UISearchBar appearance] setBackgroundImage:[UIImage imageNamed:@"search_bg.png"]];
    
    //SearchBar -- Cancel Button
    UIBarButtonItem *searchBarButton = [UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil];
    [searchBarButton setBackgroundImage:[UIImage imageNamed:@"search_bg_line.png"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [searchBarButton setBackgroundImage:[UIImage imageNamed:@"search_bg_line.png"] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    [searchBarButton setTitle:@"取消"];
    [searchBarButton setTitleTextAttributes:@{UITextAttributeTextColor : [UIColor blackColor]} forState:UIControlStateNormal];
    [searchBarButton setTitleTextAttributes:@{UITextAttributeTextColor : [UIColor grayColor]} forState:UIControlStateSelected];
}

- (void)setUpNetworkEngine
{
    NSMutableDictionary *headerFields = [NSMutableDictionary dictionary];
    headerFields[@"Content-Type"] = @"application/json";
    self.networkEngine = [[MKNetworkEngine alloc] initWithHostName:K_HOST_URL customHeaderFields:headerFields];
    [self.networkEngine useCache];
}

- (void)getCFUUID
{
    CFUUIDRef cfuuid = CFUUIDCreate(kCFAllocatorDefault);
    NSString *cfuuidString = (NSString*)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, cfuuid));
    [GGAuthManager sharedManager].uuid = cfuuidString;
}

- (void)getTravellerToken
{
#warning 待修改 - 判断是iphone还是ipad
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"platform"] = @"iphone";
    param[@"application"] = @"gogopiao_v1.0";
    param[@"client_uuid"] = @"1234567890";
    param[@"client_secret"] = @"515104200a02f596fea7c2f298aa621084c5985b";
    
    
    MKNetworkOperation *op = [self.networkEngine operationWithPath:@"api/v1/auth/xapp_auth.json" params:param httpMethod:@"GET"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        [completedOperation responseJSONWithCompletionHandler:^(id jsonObject) {
            
            [GGAuthManager sharedManager].tempToken = ((NSDictionary *)jsonObject)[@"token"];
            self.ggMainVC = [[GGMainViewController alloc] initWithNibName:@"GGMainViewController" bundle:nil];
            [self.window setRootViewController:self.ggMainVC];
            self.window.backgroundColor = [UIColor whiteColor];
            [self.window makeKeyAndVisible];
        }];
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        
        NSLog(@"AppDelegate : %@", error);
    }];
    
    [self.networkEngine enqueueOperation:op];
}

@end
