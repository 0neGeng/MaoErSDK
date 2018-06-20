//
//  MEProgressHUD+WG.h
//  MaoErSDK
//
//  Created by MRIOS on 2018/4/16.
//  Copyright © 2018年 Maor. All rights reserved.
//

#import "MEProgressHUD.h"

@interface MEProgressHUD (WG)
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (MEProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;


+ (void)showSuccess:(NSString *)success;
+ (void)showError:(NSString *)error;

+ (MEProgressHUD *)showMessage:(NSString *)message;

+ (void)hideHUDForView:(UIView *)view;
+ (void)hideHUD;
@end
