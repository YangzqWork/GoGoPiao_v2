//
//  GGPOSTLinkFactory.m
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 15/8/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import "GGPOSTLinkFactory.h"

@implementation GGPOSTLinkFactory

- (GGPOSTLink *)createLink:(NSString *)api_url
{
    GGPOSTLink *result = [[GGPOSTLink alloc] init];
    NSString *url = [base_url stringByAppendingString:api_url];
    
    result.urlString = url;
    return result;
}

@end
