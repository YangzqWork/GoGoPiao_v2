//
//  ViewController.h
//  TGYWT
//
//  Created by YANGZQ on 13-9-5.
//  Copyright (c) 2013年 YANGZQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKNetworkEngine.h"
#import "RESTError.h"

@interface RESTfulOperation : MKNetworkOperation
@property (nonatomic, strong) RESTError *restError;

@end
