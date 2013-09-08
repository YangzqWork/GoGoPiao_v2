//
//  GGNetworkEngine.m
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 3/9/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import "GGNetworkEngine.h"
#import "MKNetworkOperation.h"
#import "Reachability.h"

@interface GGNetworkEngine ()

@property (strong, nonatomic) Reachability *reachability;

@end

@implementation GGNetworkEngine

- (void)linkWithSuburl:(NSString *)theSuburl
            httpMethod:(NSString *)theMethod
                 param:(NSDictionary *)theParam
     completionHandler:(GGResponseBlock)responseBlock
          errorHandler:(MKNKErrorBlock)errorBlock
{
    MKNetworkOperation *op = [self operationWithPath:theSuburl params:theParam httpMethod:theMethod];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        NSLog(@"responseData : %@", [completedOperation responseData]);
        NSLog(@"responseString : %@", [completedOperation responseString]);
        
        [completedOperation responseJSONWithCompletionHandler:^(id jsonObject) {
            NSLog(@"jsonOOO : %@", jsonObject);
            responseBlock(jsonObject);
        }];
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        
        errorBlock(error);
    }];
    
    [self enqueueOperation:op];
}

- (NSString *)cacheDirectoryName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = paths[0];
    NSString *cacheDirectoryName = [documentsDirectory stringByAppendingPathComponent:@"GoGoPiaoCache"];
    return cacheDirectoryName;
}

@end
