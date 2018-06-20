//
//  Md5Util.m
//  mrsdk
//
//  Created by zxq on 2018/2/17.
//  Copyright © 2018年 maoer. All rights reserved.
//

#import "Md5Util.h"
#import <CommonCrypto/CommonDigest.h>

#define CC_MD5_DIGEST_LENGTH 16

@implementation Md5Util

+ (NSString *)md5EncodeFromStr:(NSString *)input
{    
    const char* str = [input UTF8String];
    unsigned char result[16];
    CC_MD5(str, (uint32_t)strlen(str), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:16 * 2];
    for(int i = 0; i<16; i++) {
        [ret appendFormat:@"%02x",(unsigned int)(result[i])];
    }
    return ret;
}

@end
