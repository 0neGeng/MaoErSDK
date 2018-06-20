//
//  FindPwdViewModel.h
//  MaoErSDK
//
//  Created by MRIOS on 2018/4/20.
//  Copyright © 2018年 Maor. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LoginView.h"

@interface FindPwdViewModel : NSObject
/**
 发送验证码
 */
+ (void)senAuthCodeWithView:(LoginView *)view
                    Success:(void(^)(id success))success
                    failure:(void(^)(NSError *error))failure;


/**
 重置密码
 */
+ (void)resetPwdWithView:(LoginView *)view
                 Success:(void(^)(id success))succsee
                 failure:(void(^)(NSError *error))failure;

/**
 信息提示框
 */
+ (UIAlertController *)customAlertView:(NSString *)alertStr;
@end
