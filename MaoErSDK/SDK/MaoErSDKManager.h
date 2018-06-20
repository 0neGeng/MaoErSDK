//
//  MaoErSDKManager.h
//  MaoErSDK
//
//  Created by MRIOS on 2018/4/21.
//  Copyright © 2018年 Maor. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface MaoErSDKManager : NSObject

///手机号登陆成功回调block
@property(nonatomic, copy) void (^loginResultMessageBlock)(id resultMessage);

///游客登录成功回调block
@property(nonatomic, copy) void (^touristsLoginResultMessagrBlock)(id resultMessage);

/**
 初始化页面
 viewController ： 调用此方法的控制器
 */
- (instancetype)initWithViewController:(UIViewController *)viewController;


@end
