//
//  NSData+AES.h
//  MaoErSDK
//
//  Created by MRIOS on 2018/4/17.
//  Copyright © 2018年 Maor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (AES)

//加密  iv: 偏移量
- (NSData *)AESEncryptWithKey:(NSString *)key iv:(NSString *)iv;

//解密
- (NSData *)AESDecryptWithKey:(NSString *)key iv:(NSString *)iv;

// MD5加密
/*
 *由于MD5加密是不可逆的,多用来进行验证
 */
// 32位小写
+(NSString *)MD5ForLower32Bate:(NSString *)str;
// 32位大写
+(NSString *)MD5ForUpper32Bate:(NSString *)str;
// 16为大写
+(NSString *)MD5ForUpper16Bate:(NSString *)str;
// 16位小写
+(NSString *)MD5ForLower16Bate:(NSString *)str;


@end
