//
//  LocalDataProtection.h
//  mrsdk
//
//  Created by zxq on 2018/2/18.
//  Copyright © 2018年 maoer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocalDataProtection : NSObject

+(NSString*)encryptBase64 :(NSString*)content;
+(NSString*)decryptBase64 :(NSString*)content;

@end
