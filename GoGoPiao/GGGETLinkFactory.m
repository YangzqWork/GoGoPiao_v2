//
//  GGGETLinkFactory.m
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 15/8/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import "GGGETLinkFactory.h"

@implementation GGGETLinkFactory

- (GGGETLink *)createLink:(NSString *)api_url
{
    GGGETLink *result = [[GGGETLink alloc] init];
    NSString *url = [base_url stringByAppendingString:api_url];
    
    result.urlString = url;
    return result;
}

@end
