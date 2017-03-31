//
//  Sha256.m
//  hackatonFinal
//
//  Created by devil1001 on 31.03.17.
//  Copyright © 2017 iosBaumanTeam. All rights reserved.
//

#import "Sha256.h"
#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonHMAC.h>

@implementation Sha256

- (NSString *) hmacSHA256:(NSString *)key data:(NSString *)data
{
    const char *cKey  = [key cStringUsingEncoding:NSASCIIStringEncoding];
    const char *cData = [data cStringUsingEncoding:NSASCIIStringEncoding];
    unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];
    CCHmac(kCCHmacAlgSHA256, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    
    NSMutableString *result = [NSMutableString string];
    for (int i = 0; i < sizeof cHMAC; i++)
    {
        [result appendFormat:@"%02hhx", cHMAC[i]];
    }
    NSLog(@"result=3%@",result);
    return result;
}


@end
