//
//  GGPostNetworkingFactory.m
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 12/8/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import "GGPostNetworkingFactory.h"
#import "GGConstants.h"
#import "CYNetworkingHelper.h"

@interface GGPostNetworkingFactory ()

@property (strong, nonatomic) CYNetworkingHelper *cyNetworkingHelper;

@end

@implementation GGPostNetworkingFactory

@synthesize responseData;
@synthesize dataArray;

-(NSArray *)createConnectionWithSuburl:(NSString *)suburl postBody:(NSString *)body
{
    //kHostUrl = @"http://42.121.58.78"
    NSString *urlString = [kHostUrl stringByAppendingString:suburl];
    NSURL *requestURL = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0f];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"en-US" forHTTPHeaderField:@"Content-Language"];
    
    NSMutableData *postBody = [NSMutableData data];
    [postBody appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request setHTTPBody:postBody];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    self.responseData = [[NSMutableData alloc] initWithData:data];
    
//解析JSON
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingAllowFragments error:&error];
    
    if (jsonObject != nil && error == nil) {
        if ([jsonObject isKindOfClass:[NSDictionary class]]) {
            NSLog(@"Not supposed to be a dictionary object!");
        }
        else if ([jsonObject isKindOfClass:[NSArray class]]) {
            self.dataArray = [[NSMutableArray alloc] initWithArray:(NSArray *)jsonObject];
            NSLog(@"self.eventsArray -- %@", self.dataArray);
            
        }
    }
    else {
        NSLog(@"Error message -- %@", error);
        NSLog(@"jsonObject -- %@", jsonObject);
    }
    
    return self.dataArray;    
}

@end
