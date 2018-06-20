//
//  LoginView.m
//  MaoErSDK
//
//  Created by MRIOS on 2018/4/4.
//  Copyright © 2018年 Maor. All rights reserved.
//

#import "LoginView.h"
#import "UIView+Frame.h"
#import "MRSDKConst.h"

@interface LoginView ()<UITextFieldDelegate>

@property(nonatomic, weak) UIView *textbackView; ///< textField的superview

@end

@implementation LoginView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    //主题色
    self.backgroundColor = MaoErSDKThemeColor;
    //标题
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = MaoErSDKTitleLabelColor;
    _titleLabel.font = MaoErSDKTitleLabelFont;
    
    //返回按钮
    
    _backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, MaoErSDKBackButtonWH, MaoErSDKBackButtonWH)];
    [_backButton setBackgroundImage:[UIImage imageNamed:MaoErBackImageName] forState:UIControlStateNormal];
    [_backButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //输入框的背景view
    UIView *textbackView = [[UIView alloc] init];
    textbackView.layer.cornerRadius = 5;
    textbackView.clipsToBounds = YES;
    _textbackView = textbackView;
    _accountField = [[MRBaseTextField alloc] init];
    _accountField.returnKeyType = UIReturnKeyDone;
    
    _sendAuthCodeBtn = [MRBaseButton buttonWithType:UIButtonTypeCustom];
    [_sendAuthCodeBtn setTitleColor:MaoErSDKAuthCodeButtonColor forState:UIControlStateNormal];
    [_sendAuthCodeBtn setTitle:MaoErSDKSendAuthCodeButtonText forState:UIControlStateNormal];
    _sendAuthCodeBtn.mrBaseButtonType = 1;
    [_sendAuthCodeBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _authCodeField = [[MRBaseTextField alloc] init];
    _authCodeField.returnKeyType = UIReturnKeyDone;
    _authCodeField.placeholder = MaoErSDKAuthCodePlaceholdText;
 
    _pwdField = [[MRBaseTextField alloc] init];
    _pwdField.secureTextEntry = YES;
    _pwdField.returnKeyType = UIReturnKeyGo;
    
    [textbackView addSubview:_accountField]; ///> 添加账号
    [textbackView addSubview:_sendAuthCodeBtn]; ///> 发送验证码
    [textbackView addSubview:_authCodeField]; ///> 验证码输入框
    [textbackView addSubview:_pwdField]; ///> 密码输入框
    
    _loginBtn = [MRBaseButton buttonWithType:UIButtonTypeCustom];
    _loginBtn.titleLabel.font = MaoErSDKButtonFont;
    [_loginBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _registBtn = [MRBaseButton buttonWithType:UIButtonTypeCustom];
    _registBtn.titleLabel.font = MaoErSDKButtonFont;
    [_registBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _touristsBtn = [MRBaseButton buttonWithType:UIButtonTypeCustom];
    _touristsBtn.titleLabel.font = MaoErSDKButtonFont;
    [_touristsBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _finderBtn = [MRBaseButton buttonWithType:UIButtonTypeCustom];
    _finderBtn.titleLabel.font = MaoErSDKButtonFont;
    [_finderBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self addSubview:_titleLabel];
    [self addSubview:_backButton];
    [self addSubview:textbackView];
    [self addSubview:_loginBtn];
    [self addSubview:_registBtn];
    [self addSubview:_touristsBtn];
    [self addSubview:_finderBtn];
    
    //画圆角
    [self setupCornerReadusWithRadii:9];
    
}

#pragma mark -- 画圆角
- (void)setupCornerReadusWithRadii:(CGFloat)radii {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(radii, radii)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
    
    
}
#pragma mark --布局子控件
- (void)layoutSubviews {
    [super layoutSubviews];
    [_titleLabel sizeToFit];
    _titleLabel.centerX = self.centerX;
    _titleLabel.y = MaoErSDKTitleMargeTop;
    
    //记录pwdField上面的UITextField
    UITextField *pwdTopTextField;
    
    //输入框的顶部距离
    CGFloat topMarge;
    if (_textFieldCount == 3) {
        pwdTopTextField = _authCodeField;
        
        _backButton.hidden = NO;
        //隐藏发送验证码的
        _sendAuthCodeBtn.hidden = NO;
        ///根据外界传的属性，决定返回按钮的位置
        _backButton.size = MaoErSDKBackButtonFrame;
        _backButton.centerY = _titleLabel.centerY;
       
        ///顶部间距
        topMarge = MaoErSDKThreeTextFieldMarge; ///两行的时候是10 三行的时候是2
        if (MaoErSDKBackButtonIsRight) {
            _backButton.x = self.width - _backButton.width - MaoErSDKTitleMargeLeftR;
        } else {
            _backButton.x = MaoErSDKTitleMargeLeftR;
        }
        
    } else {///登陆界面不需要返回按钮和验证码输入框
        topMarge = MaoErSDKTwoTextFieldMarge;
        [_authCodeField removeFromSuperview];
        pwdTopTextField = _accountField;
        _backButton.hidden = YES;       ///< 返回按钮
        _sendAuthCodeBtn.hidden = YES;  ///< 发送验证码
    }

    //账号和密码的容器
    _textbackView.frame = CGRectMake(MaoErSDKTitleMargeLeftR , CGRectGetMaxY(_titleLabel.frame) + MaoErSDKTitleMargeTop, self.width - MaoErSDKTitleMargeLeftR * 2, (MaoErSDKTextFieldHeight * _textFieldCount) + ((_textFieldCount - 1) * topMarge));
    
    //账号和密码
    _accountField.frame = CGRectMake(0, 0, _textbackView.width, MaoErSDKTextFieldHeight);
    
    //发送验证码的button
    [_sendAuthCodeBtn sizeToFit];
    if (_sendAuthCodeBtn.mrBaseButtonType == 1) /// < 空心的
    {
        _sendAuthCodeBtn.height = _accountField.height - 10; ///< 暂定上下间距为10
        _sendAuthCodeBtn.layer.borderColor = MaoErSDKAuthCodeButtonColor.CGColor;
        _sendAuthCodeBtn.layer.borderWidth = 1;
    } else {
        _sendAuthCodeBtn.height = _accountField.height;
    }
    _sendAuthCodeBtn.width = _sendAuthCodeBtn.width + 10;///<暂定宽度+10
    _sendAuthCodeBtn.x = CGRectGetMaxX(_accountField.frame) - _sendAuthCodeBtn.width - 10;
    _sendAuthCodeBtn.centerY = _accountField.centerY;
    
    ///其他界面
    if (_textFieldCount == 3) {  ///布局验证码输入框
        _authCodeField.frame = CGRectMake(0, CGRectGetMaxY(_accountField.frame) + topMarge, _textbackView.width, MaoErSDKTextFieldHeight);
    }
    _pwdField.frame = CGRectMake(0, CGRectGetMaxY(pwdTopTextField.frame) + topMarge, _textbackView.width, MaoErSDKTextFieldHeight);
    _pwdField.placeholder = MaoErSDKPWDPlaceholdText;
    
    if (_textFieldCount == 3) { ///上面的两个按钮隐藏一个
        _loginBtn.hidden = YES;
        //更新注册按钮的frame
        _registBtn.frame = CGRectMake(0, CGRectGetMaxY(_textbackView.frame) + MaoErSDKTitleMargeTop, _pwdField.width - MaoErSDKTitleMargeTop, MaoErSDKTextFieldHeight);
        _registBtn.centerX = self.centerX;
        
        ///如果是注册界面，需要添加注册条款
        if ([self.titleLabel.text containsString:@"注册"]) {
            _touristsBtn.titleLabel.font = [UIFont systemFontOfSize:12];
            _finderBtn.titleLabel.font = [UIFont systemFontOfSize:12];
            
          
            [_touristsBtn sizeToFit];
            _touristsBtn.origin = CGPointMake(_registBtn.x, CGRectGetMaxY(self.frame) - _touristsBtn.height - 5);
       
            [_finderBtn sizeToFit];
//            _finderBtn.origin = CGPointMake(CGRectGetMaxX(_registBtn.frame) - _finderBtn.width, _touristsBtn.y);
            _finderBtn.x = CGRectGetMaxX(_registBtn.frame) - _finderBtn.width;
            _finderBtn.centerY = _touristsBtn.centerY;

        }
        

    } else { //是登录
        //登陆btn
        _loginBtn.frame = CGRectMake(_textbackView.x, CGRectGetMaxY(_textbackView.frame) + MaoErSDKTitleMargeTop, (self.width - 4 * MaoErSDKTitleMargeLeftR) / 2, MaoErSDKTextFieldHeight);
        
        //注册btn
        _registBtn.frame = CGRectMake(CGRectGetMaxX(_loginBtn.frame) + MaoErSDKTitleMargeLeftR * 2, _loginBtn.y, _loginBtn.width, MaoErSDKTextFieldHeight);
        
        //游客登陆btn
        [_touristsBtn sizeToFit];
        _touristsBtn.origin = CGPointMake(_loginBtn.x, CGRectGetMaxY(_loginBtn.frame) + MaoErSDKTitleMargeTop);
        
        //找回密码btn
        [_finderBtn sizeToFit];
        _finderBtn.origin = CGPointMake(CGRectGetMaxX(_registBtn.frame) - _finderBtn.width, _touristsBtn.y);

    }

}

#pragma mark -- 统一处理按钮的点击事件
- (void)buttonClick:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(clickButton:)]) {
        [self.delegate clickButton:button];
    }
}

@end
