//
//  NSData+AES.m
//  MaoErSDK
//
//  Created by MRIOS on 2018/4/17.
//  Copyright © 2018年 Maor. All rights reserved.
//

#import "NSData+AES.h"
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>

@implementation NSData(AES)
//加密
- (NSData *)AESEncryptWithKey:(NSString *)key iv:(NSString *)iv
{
    return [self AESOperation:kCCEncrypt key:key iv:iv];
}

//解密
- (NSData *)AESDecryptWithKey:(NSString *)key iv:(NSString *)iv
{
    return [self AESOperation:kCCDecrypt key:key iv:iv];
}


NSData *TEST_AES(NSData *indata,CCOperation otype) {
    NSData *retData = nil;
    //测试的密钥或向量
    Byte tkey[32] = {0};
    for (int i = 0; i < 32; i++) {
        tkey[i] = 8;
    }
    Byte iv[16] = {0};
    for (int i =0; i < 16; i++) {
        iv[i] = 1;
    }
    CCCryptorRef cryptor = NULL;
    
    CCCryptorStatus ccret;
    
    //创建加密解密器
    if (otype==kCCEncrypt) {
        ccret = CCCryptorCreate(kCCEncrypt, kCCAlgorithmAES128, 0x0000, tkey, kCCKeySizeAES128, iv, &cryptor);
        
    }
    else {
        
        ccret = CCCryptorCreate(kCCDecrypt, kCCAlgorithmAES128, 0x0000, tkey, kCCKeySizeAES128, iv, &cryptor);
        
    }
    if (ccret!=kCCSuccess) {
        return nil;
    }
    
    size_t bufsize = 0;
    size_t moved = 0;
    size_t total = 0;
    
    //获取最大长度
    bufsize = CCCryptorGetOutputLength(cryptor, indata.length, true);
    char * buf = (char*)malloc(bufsize);
    bzero(buf, bufsize);
    
    //加解密
    ccret = CCCryptorUpdate(cryptor,
                            indata.bytes,indata.length,
                            buf, bufsize, &moved);
    
    total += moved;
    if (ccret!=kCCSuccess) {
        return nil;
    }
    
    //处理最后的数据块
    ccret = CCCryptorFinal(cryptor,
                           buf+total,
                           bufsize-total, &moved);
    if (ccret!=kCCSuccess) {
        return nil;
    }
    total +=moved;
    CCCryptorRelease(cryptor);
    
    retData = [NSData dataWithBytes:buf length:total];
    free(buf);
    
    return retData;
}


- (NSData *)AESOperation:(CCOperation)operation key:(NSString *)key iv:(NSString *)iv
{
    return TEST_AES(self, operation);
}

#pragma mark - 32位 小写
+(NSString *)MD5ForLower32Bate:(NSString *)str{
    
    //要进行UTF8的转码
    const char* input = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02x", result[i]];
    }
    
    return digest;
}

#pragma mark - 32位 大写
+(NSString *)MD5ForUpper32Bate:(NSString *)str{
    
    //要进行UTF8的转码
    const char* input = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02X", result[i]];
    }
    
    return digest;
}

#pragma mark - 16位 大写
+(NSString *)MD5ForUpper16Bate:(NSString *)str{
    
    NSString *md5Str = [self MD5ForUpper32Bate:str];
    
    NSString  *string;
    for (int i=0; i<24; i++) {
        string=[md5Str substringWithRange:NSMakeRange(8, 16)];
    }
    return string;
}


#pragma mark - 16位 小写
+(NSString *)MD5ForLower16Bate:(NSString *)str{
    
    NSString *md5Str = [self MD5ForLower32Bate:str];
    
    NSString  *string;
    for (int i=0; i<24; i++) {
        string=[md5Str substringWithRange:NSMakeRange(8, 16)];
    }
    return string;
}



@end
