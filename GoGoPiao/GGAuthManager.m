//
//  GGAuthManager.m
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 24/7/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import "GGAuthManager.h"

@implementation GGAuthManager

@synthesize token;

+ (GGAuthManager *)sharedManager
{
    static GGAuthManager *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

@end
