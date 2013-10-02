//
//  ViewController.h
//  TGYWT
//
//  Created by YANGZQ on 13-9-5.
//  Copyright (c) 2013年 YANGZQ. All rights reserved.
//

#import "RESTfulEngine.h"
#import "MenuItem.h"
#import "MKNetworkEngine.h"
#import "NSString+Encryption.h"


@implementation RESTfulEngine

- (id) initWithHostName:(NSString*) hostName {
  self = [super initWithHostName:hostName];
  if (self) {
    [self registerOperationSubclass:[RESTfulOperation class]];
  }
  return self;
}


-(NSString*) accessToken{
    if(!_accessToken)
        _accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    if (!_accessToken)
        _accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"tempToken"];
    
    return _accessToken;
}
-(void) setAccessToken:(NSString *) aAccessToken{
    _accessToken = aAccessToken;
    
    [[NSUserDefaults standardUserDefaults] setObject:_accessToken forKey:@"token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


#pragma mark -
#pragma mark Custom Request Methods

-(void) ticketDataWithUrlPath:(NSString *)urlPath
                  onSucceeded:(ArrayBlock) succeededBlock
                      onError:(ErrorBlock) errorBlock{
    NSDictionary *paramDic=@{@"token":self.accessToken};
    
    RESTfulOperation *op=(RESTfulOperation *)[self operationWithPath:urlPath params:paramDic httpMethod:@"GET"];
    NSLog(@"-->>%@",op.url);
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        DLog(@"请求Ticket成功：%@",completedOperation.responseString);
        DLog(@"这里需要吧dic处理成ticket 数组返回，推荐创建ticket Model类，返回model类");
        
        succeededBlock(nil);
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        errorBlock((RESTError *)completedOperation.error);
    }];
    
    [self enqueueOperation:op];
    
}

-(void) loginWithUser:(NSString *)user
             password:(NSString *)pwd
          onSucceeded:(VoidBlock) succeededBlock
              onError:(ErrorBlock) errorBlock{
    
    [self loginWithUser:user password:pwd platform: @"iphone" uuid:[[NSUserDefaults standardUserDefaults] objectForKey:@"UUID"] secret:nil osVersion:@"gogopiao_v1.0" onSucceeded:succeededBlock onError:errorBlock];
    
}

-(void) loginWithUser:(NSString *)login
             password:(NSString *)password
             platform:(NSString *)platform
                 uuid:(NSString *)client_uuid
               secret:(NSString *)client_secret
            osVersion:(NSString *)application
          onSucceeded:(VoidBlock) succeededBlock
              onError:(ErrorBlock) errorBlock{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"login"] = login;
    param[@"password"] = password;
    param[@"platform"] = platform;
    param[@"application"] = application;
    param[@"client_uuid"] = client_uuid;
    param[@"client_secret"] = [NSString sha1EncryptWithUnsortedString1:param];
    
    
    RESTfulOperation *op=(RESTfulOperation *)[self operationWithPath:kPathAuthLogin params:param httpMethod:@"POST"];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        self.accessToken = [completedOperation.responseJSON objectForKey:@"token"];
        DLog(@"登陆成功：%@",completedOperation.responseString);
        succeededBlock();
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        errorBlock((RESTError *)completedOperation.error);
    }];
    
    [self enqueueOperation:op];
}





-(void) requestUDIDWithOsversion:(NSString *)osversion Resolution:(NSString *)resolution Rrademark:(NSString *) trademark Installdate:(NSString *) installdate parameter:(NSDictionary *)parameter onSucceeded:(VoidBlock) succeededBlock onError:(ErrorBlock) errorBlock{

//        NSMutableDictionary *paramsDic=[NSMutableDictionary dictionaryWithObjectsAndKeys:osversion,kOsversion,resolution,kResolution,trademark,kTrademark,installdate,kInstalldate,nil];
//        [paramsDic addEntriesFromDictionary:parameter];
//        

}


-(void) requestTokenWithUserName:(NSString *)username passWord:(NSString *)password onSucceeded:(VoidBlock) succeededBlock onError:(ErrorBlock) errorBlock{
    [self requestTokenWithUserName:username passWord:password grantType:@"password" onSucceeded:succeededBlock onError:errorBlock];
}
-(void) requestTokenWithUserName:(NSString *)username passWord:(NSString *)password grantType:(NSString *)granttype onSucceeded:(VoidBlock) succeededBlock onError:(ErrorBlock) errorBlock{
//        NSDictionary *paramsDic=[NSDictionary dictionaryWithObjectsAndKeys:granttype,@"grant_type", username,kUserName,password,kPassWord,nil];
//        RESTfulOperation *op=(RESTfulOperation *)[self operationWithPath:kTokenPath params:paramsDic httpMethod:kPostMethod ssl:YES];
//        [self prepareHeaders:op WithUDID:NO Certificate:YES];
//        [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
//            //保存token
//            succeededBlock();
//        } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
//            errorBlock((RESTError *)completedOperation.error);
//        }];
//        NSLog(@"HttpHeader : %@",[op.readonlyRequest allHTTPHeaderFields]);
//        [self enqueueOperation:op];

}

@end
