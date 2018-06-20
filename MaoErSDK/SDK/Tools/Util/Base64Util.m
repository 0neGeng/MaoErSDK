//
//  Base64Util.m
//  mrsdk
//
//  Created by zxq on 2018/2/17.
//  Copyright © 2018年 maoer. All rights reserved.
//

#import "Base64Util.h"

@implementation Base64Util

+ (NSString *)base64Encode:(NSString *)source
{
    if (!source) {
        return nil;
    }
    NSData *sourceData = [source dataUsingEncoding:NSUTF8StringEncoding];
    if (!sourceData) {
        return nil;
    }
    NSString *resultStr = [sourceData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return resultStr;
}

+ (NSString *)base64Decode:(NSString *)source
{
    if (!source) {
        return nil;
    }
    // 解密
    NSData *resultData = [[NSData alloc] initWithBase64EncodedString:source options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSString *string = [[NSString alloc] initWithData: resultData encoding:NSUTF8StringEncoding];
    return string;
}

@end
