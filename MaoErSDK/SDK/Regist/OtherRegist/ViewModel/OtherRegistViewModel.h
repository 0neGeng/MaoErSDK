//
//  OtherRegistViewModel.h
//  MaoErSDK
//
//  Created by MRIOS on 2018/4/20.
//  Copyright © 2018年 Maor. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LoginView;
@interface OtherRegistViewModel : NSObject

/**
 注册账号
 */
+ (void)registAccountWithView:(LoginView *)view
                 Success:(void(^)(id success))succsee
                 failure:(void(^)(NSError *error))failure;

/**
 信息提示框
 */
+ (UIAlertController *)customAlertView:(NSString *)alertStr;
@end
