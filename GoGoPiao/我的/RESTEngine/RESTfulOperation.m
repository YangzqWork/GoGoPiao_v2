//
//  ViewController.h
//  TGYWT
//
//  Created by YANGZQ on 13-9-5.
//  Copyright (c) 2013年 YANGZQ. All rights reserved.
//

#import "RESTfulOperation.h"

@implementation RESTfulOperation

- (void)operationSucceeded
{  
// _makr 请求成功后，需要处理服务器返回的错误信息。
    id returnJson=[self responseJSON];
    if ([returnJson isKindOfClass:[NSDictionary class]]) {
        NSString *errorStr = [[self responseJSON] objectForKey:@"error"];
        if(errorStr)
        {
//            self.restError = [[RESTError alloc] initWithDomain:kBusinessErrorDomain
//                                                          code:[[returnJson objectForKey:@"error_code"] intValue]
//                                                      userInfo:returnJson];
            self.restError=[[RESTError alloc] initWithDictionary:returnJson];
            [super operationFailedWithError:self.restError];
        }
    }
	else 
	{		
		[super operationSucceeded];
	}	
}
//_mark 这里的key要处理一下
-(void) operationFailedWithError:(NSError *)theError
{
  NSMutableDictionary *errorDict = [[self responseJSON] objectForKey:@"error"];

  if(errorDict == nil)
  {
    self.restError = [[RESTError alloc] initWithDomain:kRequestErrorDomain 
                                              code:[theError code]
                                          userInfo:[theError userInfo]];
  }
  else if([errorDict isKindOfClass:[NSDictionary class]]){
    self.restError = [[RESTError alloc] initWithDomain:kBusinessErrorDomain
                                                code:[[errorDict objectForKey:@"code"] intValue]
                                            userInfo:errorDict];    
  }else{
      self.restError = [[RESTError alloc] initWithDomain:[NSString stringWithFormat:@"%@",errorDict] code:0 userInfo:nil];
  }
    
  [super operationFailedWithError:theError];
}

@end
