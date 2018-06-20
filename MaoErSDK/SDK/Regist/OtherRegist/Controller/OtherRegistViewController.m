//
//  OtherRegistViewController.m
//  MaoErSDK
//
//  Created by MRIOS on 2018/4/20.
//  Copyright © 2018年 Maor. All rights reserved.
//

#import "OtherRegistViewController.h"
#import "OtherRegistViewModel.h"
@interface OtherRegistViewController ()<LoginviewDelegate, UITextFieldDelegate>
@property(nonatomic, strong) LoginView *loginView;
@property(nonatomic) BOOL btnIsSelected;

@end

@implementation OtherRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //隐藏发送验证码的按钮
//    _loginView.sendAuthCodeBtn.hidden = YES;
    [_loginView.sendAuthCodeBtn removeFromSuperview];
}

- (void)setupUI
{
    LoginView *loginView = [[LoginView alloc] initWithFrame:self.view.bounds];
    loginView.delegate = self;
    loginView.textFieldCount = 3;
    
    loginView.titleLabel.text = @"账号注册";
    _loginView = loginView;
    
    UIImageView *accountImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:MaoErAccountImageName]];
    accountImageView.size = CGSizeMake(accountImageView.width + 5, accountImageView.height - 5);
    accountImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    ///< 重写属性
    //重写占位文字
    _loginView.accountField.placeholder = MaoErSDKAccountPlaceholdText;
    _loginView.accountField.leftView = accountImageView;
    _loginView.accountField.leftViewMode = UITextFieldViewModeAlways;
   
    
    UIImageView *authCodeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:MaoErPasswordImageName]];
    authCodeImageView.size = CGSizeMake(authCodeImageView.width + 5, authCodeImageView.height - 5);
    authCodeImageView.contentMode = UIViewContentModeScaleAspectFit;
    _loginView.authCodeField.placeholder = MaoErSDKPWDPlaceholdText;
    _loginView.authCodeField.leftView = authCodeImageView;
    _loginView.authCodeField.leftViewMode = UITextFieldViewModeAlways;
    
    
    UIImageView *pwdImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:MaoErPasswordImageName]];
    pwdImageView.size = CGSizeMake(pwdImageView.width + 5, pwdImageView.height - 5);
    pwdImageView.contentMode = UIViewContentModeScaleAspectFit;
    _loginView.pwdField.leftView = pwdImageView;
    _loginView.pwdField.leftViewMode = UITextFieldViewModeAlways;

    _loginView.accountField.delegate = self;
    _loginView.authCodeField.delegate = self;
    _loginView.pwdField.delegate = self;


    //设置登陆按钮
    [_loginView.loginBtn setTitle:MaoErSDKUpperLeftButtonText forState:UIControlStateNormal];
    [_loginView.loginBtn setBackgroundColor:[UIColor colorWithRed:36 / 255.0 green:199 / 255.0 blue:214 / 255.0 alpha:1]];
    
    [_loginView.registBtn setTitle:MaoErSDKUpperRightButtonText forState:UIControlStateNormal];
    [_loginView.registBtn setBackgroundColor:[UIColor colorWithRed:228 / 255.0 green:167 / 255.0 blue:21 / 255.0 alpha:1]];
    
    [_loginView.touristsBtn setTitle:MaoErSDKUserAgreementText forState:UIControlStateNormal];
    [_loginView.touristsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_loginView.touristsBtn setImage:[UIImage imageNamed:@"mr_check"] forState:UIControlStateNormal];
    [_loginView.touristsBtn setImage:[UIImage imageNamed:@"mr_checked"] forState:UIControlStateSelected];
    //用户协议默认是选中
    _loginView.touristsBtn.selected = YES;
    self.btnIsSelected = _loginView.touristsBtn.selected;

    
    [self.view addSubview:loginView];
}
#pragma mark --- loginViewDelegate ---
-(void)clickButton:(MRBaseButton *)button
{
    if ([button.titleLabel.text isEqualToString:MaoErSDKUpperRightButtonText]) {
        if (!self.loginView.accountField.text.length || !self.loginView.authCodeField.text.length || !self.loginView.pwdField.text.length) {
            
           UIAlertController *alert = [OtherRegistViewModel customAlertView:@"账号或者密码不能为空"];
            [self presentViewController:alert animated:YES completion:nil];
            
        } else if (!self.btnIsSelected) {
            
            UIAlertController *alert = [OtherRegistViewModel customAlertView:@"请接受用户协议" ];
            [self presentViewController:alert animated:YES completion:nil];
            
        } else {
            [OtherRegistViewModel registAccountWithView:self.loginView Success:^(id success) {
                
            } failure:^(NSError *error) {
                
            }];
        }
    } else if ([button.titleLabel.text containsString:MaoErSDKUserAgreementText]){
        
         [self setUserAgreement:button];
    } else {
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)setUserAgreement:(MRBaseButton *)button
{
    button.selected = button.selected ? NO : YES;
    self.btnIsSelected = button.selected;
}
@end
