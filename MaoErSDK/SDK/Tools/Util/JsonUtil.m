//
//  JsonUtil.m
//  mrsdk
//
//  Created by zxq on 2018/2/13.
//  Copyright © 2018年 maoer. All rights reserved.
//

#import "JsonUtil.h"
#import "ObjectUtil.h"

@implementation JsonUtil

+ (NSString *)toJsonString:(id)obj
{
    NSDictionary* dict = [ObjectUtil getObjectData:obj];
    return [self toJsonStringWitDic :dict];
}

+ (NSString *)toJsonStringWitDic:(NSDictionary*)dict
{
    NSError* error = nil;
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

+(NSDictionary*) toDict:(NSString*)jsonStr
{
    NSData *data= [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:data
                                                    options:NSJSONReadingAllowFragments
                                                      error:&error];
    if(!error){
        if ([jsonObject isKindOfClass:[NSDictionary class]]){
            return (NSDictionary *)jsonObject;
        }
    }
    return nil;
}

@end
