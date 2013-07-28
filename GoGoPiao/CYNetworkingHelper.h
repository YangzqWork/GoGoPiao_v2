//
//  CYNetworkingManager.h
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 26/7/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//
//  Specific in loading the data from the server

#import <Foundation/Foundation.h>

//typedef void(^ConnectionConfiguration)(void);

@interface CYNetworkingHelper : NSObject<NSURLConnectionDelegate, NSURLConnectionDataDelegate>

//@property (strong, nonatomic) NSMutableDictionary *receivedDataDictionary;
//@property (strong, nonatomic) NSMutableArray *receivedDataArray;
@property (strong, nonatomic) id receivedJSONObject;

@end
