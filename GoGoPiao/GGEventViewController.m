//
//  GGEventViewController.m
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 14/7/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import "GGEventViewController.h"

@interface GGEventViewController ()

@end

@implementation GGEventViewController


//-(void)loadTodos {
//    NSMutableURLRequest *theRequest=[NSMutableURLRequest
//                                     requestWithURL:
//                                     [NSURL URLWithString: kGetAllUrl]
//                                     cachePolicy:NSURLRequestUseProtocolCachePolicy
//                                     timeoutInterval:60.0];
//    [theRequest setHTTPMethod:@"GET"];
//    [theRequest addValue:@"application/json" forHTTPHeaderField:@"ACCEPT"];
//    [theRequest addValue:kMobileServiceAppId forHTTPHeaderField:@"X-ZUMO-APPLICATION"];
//    
//    NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
//    if (theConnection) {
//        receivedData = [NSMutableData data];
//    } else {
//        // We should inform the user that the connection failed.
//    }
//}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"UpComingEvents";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
