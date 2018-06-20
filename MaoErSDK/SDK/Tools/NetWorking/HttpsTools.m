//
//  HttpsTools.m
//  MaoErSDK
//
//  Created by MRIOS on 2018/4/17.
//  Copyright © 2018年 Maor. All rights reserved.
//

#import "HttpsTools.h"
#import "LocalDataProtection.h"
#import "Md5Util.h"
#import "JsonUtil.h"
#import "Base64Util.h"
@implementation HttpsTools

+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{
    //创建session
    NSURLSession *session = [NSURLSession sharedSession];
    //停止所有任务
    [session invalidateAndCancel];
    //网络请求的url
    NSURL *url1 = [NSURL URLWithString:url];
    //创建请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url1];
    //设置请求类型
    request.HTTPMethod = @"POST";
    //超时时间
    request.timeoutInterval = 10.0f;
    request.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    //参数处理
    NSString *requestParams = [HttpsTools getRequestParams:params];

    NSData *postRequestData = [requestParams dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPBody = postRequestData;
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error) {
                failure(error);
            } else {
                success(data);
            }
        });
    }];
    [task resume];

    
}

+ (NSString *)getRequestParams:(NSDictionary *)patrameter
{
    
    NSString *rawRequest = [JsonUtil toJsonStringWitDic:[self signRequestParams:patrameter]];
    NSString *base64Request = [Base64Util base64Encode:rawRequest];
    NSString *encodeRequest = [base64Request stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    encodeRequest = [encodeRequest stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
    return [[NSString alloc] initWithFormat:@"data=%@", encodeRequest];;
}
#pragma mark 签名
+ (NSMutableDictionary*) signRequestParams:(NSDictionary *)parameter
{
    NSString *rawRequestValues = @"";
    NSMutableDictionary *rawRequestParamMap = [parameter mutableCopy];
    NSArray<NSString*> *allKeys = rawRequestParamMap.allKeys;
    
    NSArray<NSString*> *paramKeys = [allKeys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
        return [obj1 compare:obj2];
    }];
    for(NSString *key in paramKeys) {
        NSObject *obj = rawRequestParamMap[key];
        NSString *value = @"";
        if([obj isKindOfClass:[NSString class]]) {
            value = rawRequestParamMap[key];
        }else if([obj isKindOfClass:[NSNumber class]]) {
            value = ((NSNumber*)obj).stringValue;
        }
        
        if([key isEqualToString:@"password"]) {
            value = [LocalDataProtection encryptBase64:value]; //[Base64Util base64Encode:value];
            [rawRequestParamMap setObject:value forKey:key];
        }
        rawRequestValues = [rawRequestValues stringByAppendingString:value];
    }
    NSString *str = [rawRequestValues stringByAppendingString:@"2Y3SK8UFP9A7L"];
    NSString *sign = [Md5Util md5EncodeFromStr:str];
    [rawRequestParamMap setObject:sign forKey:@"sign"];
    
    return rawRequestParamMap;
}
@end
