//
//  GGGetNetworkingFactory.m
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 12/8/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import "GGGetNetworkingFactory.h"
#import "GGConstants.h"

@implementation GGGetNetworkingFactory

@synthesize responseData;
@synthesize dataArray;

//subUrl需要包括token的参数
-(NSArray *)createConnectionWithSuburl:(NSString *)suburl postBody:(NSString *)postBody
{
//设置缓存
    NSURLCache *urlCache = [NSURLCache sharedURLCache];
    [urlCache setMemoryCapacity:1 * 1024 * 1024];
    
    NSString *urlString = [kHostUrl stringByAppendingString:suburl];
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:40.0f];
    
    [request setHTTPMethod:@"GET"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"en-US" forHTTPHeaderField:@"Content-Language"];
    
    
//请求从缓存中读取数据
    NSCachedURLResponse *response = [urlCache cachedResponseForRequest:request];
    if (response != nil) {
        [request setCachePolicy:NSURLRequestReturnCacheDataDontLoad];
    }
    
    
//这个是异步    [NSURLConnection connectionWithRequest:request delegate:self];
    
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
