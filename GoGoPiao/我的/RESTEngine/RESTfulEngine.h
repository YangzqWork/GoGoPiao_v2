//
//  ViewController.h
//  TGYWT
//
//  Created by YANGZQ on 13-9-5.
//  Copyright (c) 2013年 YANGZQ. All rights reserved.
//  数据应该以model的形式从这里传递到vc，而不是json或者dictionary
//  这里封装了大部分常用的网络相关操作，比如管理并发队列，显示active指示等
//  根据网络改变并发操作的最大数量，WiFi下6max，WWAN是2
//  _mark 除了认证请求之后，都需要提供取消网络的方法，在页面消失的时候，取消请求，释放带宽

#import <Foundation/Foundation.h>
#import "RESTfulOperation.h"
#import "JSONModel.h"
#import "API.h"
#import "MKNetworkEngine.h"

typedef void (^VoidBlock)(void);
typedef void (^ModelBlock)(JSONModel* aModelBaseObject);
typedef void (^ArrayBlock)(NSMutableArray* listOfModelBaseObjects);
typedef void (^ErrorBlock)(RESTError* engineError);

@interface RESTfulEngine : MKNetworkEngine {
    NSString *_accessToken;
}
@property (nonatomic) NSString *accessToken;

/** 
 @param urlPath   接口.
 @return void
 */
-(void) ticketDataWithUrlPath:(NSString *)urlPath
                  onSucceeded:(ArrayBlock) succeededBlock
                      onError:(ErrorBlock) errorBlock;


//登陆
-(void) loginWithUser:(NSString *)user
             password:(NSString *)pwd
          onSucceeded:(VoidBlock) succeededBlock
              onError:(ErrorBlock) errorBlock;

-(void) loginWithUser:(NSString *)user
             password:(NSString *)pwd
             platform:(NSString *)platform
                 uuid:(NSString *)client_uuid
               secret:(NSString *)client_secret
            osVersion:(NSString *)application
          onSucceeded:(VoidBlock) succeededBlock
              onError:(ErrorBlock) errorBlock;


@end
