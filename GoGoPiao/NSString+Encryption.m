//
//  NSString+Encryption.m
//  GoGoPiao
//
//  Created by Cho-Yeung Lam on 20/9/13.
//  Copyright (c) 2013 Cho-Yeung Lam. All rights reserved.
//

#import "NSString+Encryption.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Encryption)

+ (NSString *)sha1EncryptWithUnsortedString1:(NSDictionary *)paramDict
{
    NSArray *paramArray = [NSArray arrayWithObjects:paramDict[@"platform"], paramDict[@"application"], paramDict[@"client_uuid"], nil];
    NSArray *sortedArray = [paramArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [(NSString*)obj1 compare:obj2 options:NSDiacriticInsensitiveSearch|NSCaseInsensitiveSearch];
    }];
    
    NSString *wholeString = [NSString stringWithFormat:@"%@%@%@", sortedArray[0], sortedArray[1], sortedArray[2]];
    return [wholeString sha1];
}

- (NSString *)sha1
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, data.length, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
    {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}

@end
