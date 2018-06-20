//
//  Base64Util.h
//  mrsdk
//
//  Created by zxq on 2018/2/17.
//  Copyright © 2018年 maoer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Base64Util : NSObject

+ (NSString *)base64Encode:(NSString *)source;  //加密
+ (NSString *)base64Decode:(NSString *)source;  //解密

@end
