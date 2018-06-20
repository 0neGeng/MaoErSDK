//
//  FindPwdViewModel.m
//  MaoErSDK
//
//  Created by MRIOS on 2018/4/20.
//  Copyright © 2018年 Maor. All rights reserved.
//

#import "FindPwdViewModel.h"
#import "MRSDKConst.h"
#import "HttpsTools.h"
@implementation FindPwdViewModel
/**
 发送验证码
 */
+ (void)senAuthCodeWithView:(LoginView *)view
                    Success:(void(^)(id success))success
                    failure:(void(^)(NSError *error))failure
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",userBaseUrl,sendAuthCodeURL];
    NSDictionary *dict = @{
                           @"phone" : view.accountField.text,
                           @"type"  : @"3"
                           };
    NSMutableDictionary *parameters = commonParameters();
    [parameters addEntriesFromDictionary:dict];
    [HttpsTools post:urlStr params:parameters success:^(id json) {
        
        success(json);
        
    } failure:^(NSError *error) {
        
        failure(error);
        
    }];
}

/**
 重置密码
 */
+ (void)resetPwdWithView:(LoginView *)view
                 Success:(void(^)(id success))succsee
                 failure:(void(^)(NSError *error))failure
{
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",userBaseUrl,finderPwdUrl];
    NSDictionary *dict = @{
                           @"phone"    : view.accountField.text,
                           @"verify"   : view.authCodeField.text,
                           @"password" : view.pwdField.text,
                           };
    NSMutableDictionary *parameters = commonParameters();
    [parameters addEntriesFromDictionary:dict];
    [HttpsTools post:urlStr params:parameters success:^(id json) {
        
        succsee(json);
        
    } failure:^(NSError *error) {
        
        failure(error);
    }];
    
}


+ (UIAlertController *)customAlertView:(NSString *)alertStr
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"找回密码" message:alertStr preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action];
    return alert;
}
@end
