//
//  GGLink.m
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 16/8/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import "GGLink.h"

@interface GGLink ()

@property (strong, nonatomic) NSMutableData *responseData;

@end

@implementation GGLink

@synthesize urlString;
@synthesize postBody;

- (void)getResponseData
{
    
}

- (id)getResponseJSON
{
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingAllowFragments error:&error];
    
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
