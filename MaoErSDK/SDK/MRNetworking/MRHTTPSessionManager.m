//
//  MRHTTPSessionManager.m
//  MaoErSDK
//
//  Created by MRIOS on 2018/4/16.
//  Copyright © 2018年 Maor. All rights reserved.
//

#import "MRHTTPSessionManager.h"

@implementation MRHTTPSessionManager

+ (NSURLSessionDataTask *)POST:(NSString *)URLString
                    parameters:(nullable id)parameters
                       success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                       failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure
{
    
    NSURL *url = [NSURL URLWithString:URLString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    
    NSURLSession *session = [NSURLSession sharedSession];
    [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
    }];
    return nil;
}

@end

