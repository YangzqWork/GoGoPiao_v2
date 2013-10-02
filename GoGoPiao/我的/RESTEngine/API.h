//
//  API.h
//  TGYWT
//
//  Created by YANGZQ on 13-9-6.
//  Copyright (c) 2013年 YANGZQ. All rights reserved.
//


#ifndef TGYWT_API_h
#define TGYWT_API_h

#pragma mark - 参数
#define kUserName @"username"
#define kPassWord @"password"


#pragma mark - 链接
#define kBaseURL            @"42.121.58.78"
#define kPathAuthLogin      @"/api/v1/auth/signin.json"

#define kPathBuyer          @"/api/v1/tickets/buyer.json"
#define kPathSeller         @"/api/v1/tickets/seller.json"
#define kPathSold         @"/api/v1/tickets/seller/sold.json"

//GET /api/v1/tickets/buyer.json 獲得當前用戶買家tickets
//GET /api/v1/tickets/seller.json 獲得當前用戶的賣家tickets

//GET /api/v1/tickets/seller/sold.json 獲得當前用戶的賣家tickets
//GET /api/v1/tickets/seller/unsold.json 獲得當前用戶的賣家tickets



#endif
