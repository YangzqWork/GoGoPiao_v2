//
//  GGLink.h
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 16/8/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GGLink : NSObject

@property (strong, nonatomic) NSString *urlString;
@property (strong, nonatomic) NSString *postBody;

- (void)getResponseData;
- (NSArray *)getResponseJSON;

@end
