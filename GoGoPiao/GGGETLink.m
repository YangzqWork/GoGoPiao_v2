//
//  GGGETLink.m
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 15/8/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import "GGGETLink.h"

@interface GGGETLink ()

@property (strong, nonatomic) NSMutableData *responseData;
@property (strong, nonatomic) NSMutableArray *responseArray;

@end

@implementation GGGETLink

- (NSMutableData *)getResponseData
{
    NSURL *url = [NSURL URLWithString:self.urlString];
    NSLog(@"test : %@", self.urlString);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:40.0f];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"en-US" forHTTPHeaderField:@"Content-Language"];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    self.responseData = [[NSMutableData alloc] initWithData:data];
    return self.responseData;
}

- (NSArray *)getResponseArray
{
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingAllowFragments error:&error];
    self.responseArray = [[NSMutableArray alloc] initWithArray:nil];
    
    if (jsonObject != nil && error == nil) {
        if ([jsonObject isKindOfClass:[NSDictionary class]]) {
            NSLog(@"Not supposed to be a dictionary object!");
        }
        else if ([jsonObject isKindOfClass:[NSArray class]]) {
            [self.responseArray addObjectsFromArray:(NSArray *)jsonObject];
            NSLog(@"self.responseArray -- %@", self.responseArray);
            
        }
    }
    else {
        NSLog(@"Error message -- %@", error);
        NSLog(@"jsonObject -- %@", jsonObject);
    }
    
    return self.responseArray;
}

@end
