//
//  MRHTTPSessionManager.h
//  MaoErSDK
//
//  Created by MRIOS on 2018/4/16.
//  Copyright © 2018年 Maor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MRHTTPSessionManager : NSObject

+ (NSURLSessionDataTask *)POST:(NSString *)URLString
                            parameters:(id)parameters
                               success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@end
