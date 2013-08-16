//
//  GGPOSTLinkFactory.h
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 15/8/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GGPOSTLink.h"

@interface GGPOSTLinkFactory : NSObject

- (GGPOSTLink *)createLink: (NSString *)api_url param:(NSDictionary *)dictionary;

@end
