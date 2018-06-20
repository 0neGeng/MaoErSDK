//
//  FindPwdViewController.m
//  MaoErSDK
//
//  Created by MRIOS on 2018/4/11.
//  Copyright © 2018年 Maor. All rights reserved.
//

#import "FindPwdViewController.h"
#import "MRSDKConst.h"
#import "HttpsTools.h"
#import "FindPwdViewModel.h"

@interface FindPwdViewController ()<LoginviewDelegate, UITextFieldDelegate>

@property(nonatomic, strong) LoginView *loginView;
@property(nonatomic) NSTimer *timer;       ///< 发送验证码倒计时定时器
@property(nonatomic) NSInteger timerCount; ///< 定时器计数器
@end

@implementation FindPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI
{
    LoginView *loginView = [[LoginView alloc] initWithFrame:self.view.bounds];
    //设置代理
    loginView.delegate = self;
    loginView.textFieldCount = 3;
    
    loginView.titleLabel.text = @"找回密码";
    _loginView = loginView;
    
    UIImageView *accountImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:MaoErPhoneNumberImageName]];
    accountImageView.size = CGSizeMake(accountImageView.width + 5, accountImageView.height - 5);
    accountImageView.contentMode = UIViewContentModeScaleAspectFit;
    _loginView.accountField.placeholder = MaoErSDKPhonePlaceholdText;
    _loginView.accountField.delegate = self;

    _loginView.accountField.leftView = accountImageView;
    _loginView.accountField.leftViewMode = UITextFieldViewModeAlways;
    
    UIImageView *authCodeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:MaoErPhoneAuthCodeImageName]];
    authCodeImageView.size = CGSizeMake(authCodeImageView.width + 5, authCodeImageView.height - 5);
    authCodeImageView.contentMode = UIViewContentModeScaleAspectFit;
    _loginView.authCodeField.leftView = authCodeImageView;
    _loginView.authCodeField.leftViewMode = UITextFieldViewModeAlways;
    _loginView.authCodeField.delegate = self;
    
    UIImageView *pwdImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:MaoErPhonePWDImageName]];
    pwdImageView.size = CGSizeMake(pwdImageView.width + 5, pwdImageView.height - 5);
    pwdImageView.contentMode = UIViewContentModeScaleAspectFit;
    _loginView.pwdField.leftView = pwdImageView;
    _loginView.pwdField.leftViewMode = UITextFieldViewModeAlways;
    _loginView.pwdField.delegate = self;
    //设置登陆按钮
    [_loginView.loginBtn setTitle:MaoErSDKUpperLeftButtonText forState:UIControlStateNormal];
    [_loginView.loginBtn setBackgroundColor:[UIColor colorWithRed:36 / 255.0 green:199 / 255.0 blue:214 / 255.0 alpha:1]];
    
    [_loginView.registBtn setTitle:MaoErSDKResetPwdButtonText forState:UIControlStateNormal];
    [_loginView.registBtn setBackgroundColor:[UIColor colorWithRed:228 / 255.0 green:167 / 255.0 blue:21 / 255.0 alpha:1]];
    
    [self.view addSubview:loginView];
}

#pragma mark --- 按钮点击的代理 -
-(void)clickButton:(UIButton *)button
{
    if ([button.titleLabel.text isEqualToString:MaoErSDKSendAuthCodeButtonText]){
        [self senAuthCode];
    }else if ([button.titleLabel.text isEqualToString:MaoErSDKResetPwdButtonText]){
        [self resetPWD];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


#pragma mark --- 网络请求 ---
//发送验证码
- (void)senAuthCode
{
    if (isTelephone(self.loginView.accountField.text)) {
        [self startTimer];
        //请求数据
        [FindPwdViewModel senAuthCodeWithView:self.loginView Success:^(id success) {
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:success options:NSJSONReadingMutableLeaves error:nil];
            NSLog(@"%@", dict);
            
        } failure:^(NSError *error) {
            
        }];
        
    } else {
        [self presentViewController:[FindPwdViewModel customAlertView:@"请输入正确的手机号码"] animated:YES completion:nil];
        
    }
}

//重置密码
- (void)resetPWD
{
    ///逻辑处理
    if (!isTelephone(self.loginView.accountField.text)) {
        [self presentViewController:[FindPwdViewModel customAlertView:@"请输入正确的手机号码"] animated:YES completion:nil];
    } else if (!self.loginView.authCodeField.text.length) {
        [self presentViewController:[FindPwdViewModel customAlertView:MaoErSDKAuthCodeNil] animated:YES completion:nil];
  
    } else if (!self.loginView.pwdField.text.length) {
        [self presentViewController:[FindPwdViewModel customAlertView:@"密码不能为空"] animated:YES completion:nil];
    } else {
        
        //请求数据
        [FindPwdViewModel resetPwdWithView:self.loginView Success:^(id success) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:success options:NSJSONReadingMutableLeaves error:nil];
            NSLog(@"%@", dict);
            if (dict[@"code"] != 0) {
                [self presentViewController:[FindPwdViewModel customAlertView:MaoErSDKAuthCodeNil] animated:YES completion:nil];
            } else { ///等0重置成功  2.返回到登陆界面
                [self.navigationController popViewControllerAnimated:YES];
            }
            
        } failure:^(NSError *error) {
            [self presentViewController:[FindPwdViewModel customAlertView:MaoErSDKErrorMsg] animated:YES completion:nil];
        }];
    }
}

/// 发送验证码倒计时
- (void)startTimer
{
    _loginView.sendAuthCodeBtn.enabled = NO;
    self.timerCount = 30;
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
    self.timer = timer;
}

- (void)onTimer
{
    if (self.timerCount > 0) {
        [_loginView.sendAuthCodeBtn setTitle:[NSString stringWithFormat:@"请等待%zd秒", self.timerCount] forState:UIControlStateNormal];
        self.timerCount --;
    } else {
        [self.timer invalidate];
        self.timer = nil;
        [_loginView.sendAuthCodeBtn setTitle:MaoErSDKSendAuthCodeButtonText forState:UIControlStateNormal];
        _loginView.sendAuthCodeBtn.enabled = YES;
    }
}
- (void)dealloc {
    NSLog(@"---finderPwd----");
}
@end
