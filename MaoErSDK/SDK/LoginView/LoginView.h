//
//  LoginView.h
//  MaoErSDK
//
//  Created by MRIOS on 2018/4/4.
//  Copyright © 2018年 Maor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MRBaseButton.h"
#import "MRBaseTextField.h"


///点击按钮的代理
@protocol LoginviewDelegate <NSObject>

- (void)clickButton:(UIButton *)button;

@end

@interface LoginView : UIView


//////界面控件
@property(nonatomic, strong) UILabel *titleLabel;///< 标题
@property(nonatomic, strong) UIButton *backButton; ///< 返回按钮
@property(nonatomic, strong) MRBaseTextField *accountField;///< 账号输入框
@property(nonatomic, strong) MRBaseTextField *authCodeField;///< 验证码输入框
@property(nonatomic, strong) MRBaseTextField *pwdField;///< 密码输入框

///按钮
@property(nonatomic, strong) MRBaseButton *sendAuthCodeBtn;///< 发送验证码
@property(nonatomic, strong) MRBaseButton *loginBtn;///< 登陆按钮
@property(nonatomic, strong) MRBaseButton *registBtn;///< 注册按钮
@property(nonatomic, strong) MRBaseButton *touristsBtn;///< 游客登陆
@property(nonatomic, strong) MRBaseButton *finderBtn;///< 找回密码

//////业务判断
@property(nonatomic, assign) NSInteger textFieldCount;///< textFiexd的行数

@property(nonatomic, assign) BOOL isInputCode;

@property(nonatomic, weak) id<LoginviewDelegate> delegate;
@end
