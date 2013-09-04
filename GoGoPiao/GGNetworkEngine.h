//
//  GGNetworkEngine.h
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 3/9/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import "MKNetworkEngine.h"

typedef void (^GGResponseBlock)(id);

@interface GGNetworkEngine : MKNetworkEngine

- (void)linkWithSuburl:(NSString *)theSuburl
            httpMethod:(NSString *)theMethod
                 param:(NSDictionary *)theParam
     completionHandler:(GGResponseBlock)responseBlock
          errorHandler:(MKNKErrorBlock)errorBlock;

@end
