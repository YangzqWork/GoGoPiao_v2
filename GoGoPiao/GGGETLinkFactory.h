//
//  GGGETLinkFactory.h
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 15/8/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GGGETLink.h"

@interface GGGETLinkFactory : NSObject

- (GGGETLink *)createLink:(NSString *)api_url;

@end
