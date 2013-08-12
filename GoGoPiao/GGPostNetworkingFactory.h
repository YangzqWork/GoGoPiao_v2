//
//  GGPostNetworkingFactory.h
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 12/8/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GGNetworkingFactory.h"

@interface GGPostNetworkingFactory : GGNetworkingFactory

@property (strong, nonatomic) NSMutableData *responseData;
@property (strong, nonatomic) NSMutableArray *dataArray;

-(NSArray *)createConnectionWithSuburl:(NSString *)suburl postBody:(NSString *)postBody;

@end
