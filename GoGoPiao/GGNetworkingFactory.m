//
//  GGNetworkingFactory.m
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 12/8/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import "GGNetworkingFactory.h"

@implementation GGNetworkingFactory

-(NSArray *)createConnectionWithSuburl:(NSString *)suburl postBody:(NSString *)postBody
{
    [NSException raise:NSInternalInconsistencyException
                format:@"在%@的子类中必须override:%@方法", [NSString stringWithUTF8String:object_getClassName(self)], NSStringFromSelector(_cmd)];
    return nil;
}

@end
