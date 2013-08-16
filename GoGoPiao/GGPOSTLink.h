//
//  GGPOSTLink.h
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 15/8/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GGLink.h"

@interface GGPOSTLink : GGLink

@property (strong, nonatomic) NSString *postBody;

- (NSMutableData *)getResponseData;
- (NSArray *)getResponseArray;

@end
