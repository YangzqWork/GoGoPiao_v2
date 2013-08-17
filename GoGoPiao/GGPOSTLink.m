//
//  GGPOSTLink.m
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 15/8/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import "GGPOSTLink.h"

@interface GGPOSTLink ()

@property (strong, nonatomic) NSMutableData *responseData;
//@property (strong, nonatomic) NSMutableArray *responseArray;

@end

@implementation GGPOSTLink

@synthesize postBody;

- (NSMutableData *)getResponseData
{
    NSLog(@"test : %@", self.urlString);
    NSLog(@"test 2 : %@", self.postBody);
    NSURL *requestURL = [NSURL URLWithString:self.urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0f];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    NSMutableData *body = [NSMutableData data];
   
    [body appendData:[self.postBody dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request setHTTPBody:body];
    
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    self.responseData = [[NSMutableData alloc] initWithData:data];
    return self.responseData;
}


- (id)getResponseJSON
{
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingAllowFragments error:&error];
    NSLog(@"test : %@", jsonObject);
    
    if (jsonObject != nil && error == nil) {
        if ([jsonObject isKindOfClass:[NSDictionary class]]) {
            NSMutableDictionary *responseDictionary = [[NSMutableDictionary alloc] initWithDictionary:(NSDictionary *)jsonObject copyItems:YES];
            return responseDictionary;
        }
        else if ([jsonObject isKindOfClass:[NSArray class]]) {
            NSMutableArray *responseArray = [[NSMutableArray alloc] initWithArray:nil];
            [responseArray addObjectsFromArray:(NSArray *)jsonObject];
            return responseArray;
        }
    }
    else {
        NSLog(@"Error message -- %@", error);
        NSLog(@"jsonObject -- %@", jsonObject);
    }
    
    return nil;
}


@end
