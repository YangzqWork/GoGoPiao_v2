//
//  NSString+Encryption.h
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 20/9/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Encryption)

- (NSString *)sha1;
+ (NSString *)sha1EncryptWithUnsortedString1:(NSDictionary *)paramDict;

@end
