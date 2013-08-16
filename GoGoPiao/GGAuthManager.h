//
//  GGAuthManager.h
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 24/7/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GGAuthManager : NSObject

@property (strong, nonatomic) NSString *token;
@property (strong, nonatomic) NSString *tempToken;
@property (strong, nonatomic) NSString *uuid;

+(GGAuthManager *)sharedManager;

@end
