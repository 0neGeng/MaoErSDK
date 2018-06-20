//
//  JsonUtil.h
//  mrsdk
//
//  Created by zxq on 2018/2/13.
//  Copyright © 2018年 maoer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonUtil : NSObject

+ (NSString *)toJsonString:(id)obj;
+ (NSString *)toJsonStringWitDic:(NSDictionary*)dict;
+(NSDictionary*) toDict:(NSString*)jsonStr;

@end
