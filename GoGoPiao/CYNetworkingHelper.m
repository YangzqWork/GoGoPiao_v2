//
//  CYNetworkingManager.m
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 26/7/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import "CYNetworkingHelper.h"

@interface CYNetworkingHelper ()

//@property (strong, nonatomic) ConnectionConfiguration configurationBlock;
@property (strong, nonatomic) NSMutableData *receivedData;

@end

@implementation CYNetworkingHelper

@synthesize receivedJSONObject;

#pragma mark - NSURLConnectionDelegate Protocols

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.receivedData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.receivedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:self.receivedData options:NSJSONReadingAllowFragments error:&error];
    if (jsonObject != nil && error != nil) {
        self.receivedJSONObject = jsonObject;
        if ([jsonObject isKindOfClass:[NSArray class]]) {
            self.receivedJSONObject = (NSArray *)self.receivedJSONObject;
        }
        else if ([jsonObject isKindOfClass:[NSDictionary class]]) {
            self.receivedJSONObject = (NSDictionary *)self.receivedJSONObject;
        }
        else
            NSLog(@"Weird JSON data, not array or dictionary. Have no idea how to deal with.");
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didFinishReceivingData" object:self];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%@", error);
}

@end
