//
//  OtherRegistViewModel.m
//  MaoErSDK
//
//  Created by MRIOS on 2018/4/20.
//  Copyright © 2018年 Maor. All rights reserved.
//

#import "OtherRegistViewModel.h"
#import "MRSDKConst.h"
#import "LoginView.h"
#import "HttpsTools.h"
@implementation OtherRegistViewModel


+ (void)registAccountWithView:(LoginView *)view
                 Success:(void(^)(id success))succsee
                 failure:(void(^)(NSError *error))failure
{
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",userBaseUrl,finderPwdUrl];
    NSDictionary *dict = @{
                           @"username"    : view.accountField.text,
                           @"verify"      : @"",
                           @"password"    : view.pwdField.text,
                           @"type"        : @"user"
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
