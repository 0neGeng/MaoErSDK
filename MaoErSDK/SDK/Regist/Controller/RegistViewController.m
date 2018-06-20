//
//  RegistViewController.m
//  MaoErSDK
//
//  Created by MRIOS on 2018/4/11.
//  Copyright © 2018年 Maor. All rights reserved.
//

#import "RegistViewController.h"
#import "LoginView.h"
#import "UIView+Frame.h"
#import "OtherRegistViewController.h"

@interface RegistViewController ()<LoginviewDelegate, UITextFieldDelegate>
@property(nonatomic, strong) LoginView *loginView;
@property(nonatomic) NSTimer *timer;       ///< 发送验证码倒计时定时器
@property(nonatomic) NSInteger timerCount; ///< 定时器计数器
@property(nonatomic) BOOL btnIsSelected;
@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginBtnChangeState) name:UITextFieldTextDidEndEditingNotification object:_loginView.accountField];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginBtnChangeState) name:UITextFieldTextDidEndEditingNotification object:_loginView.pwdField];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginBtnChangeState) name:UITextFieldTextDidEndEditingNotification object:_loginView.authCodeField];
}

- (void)setupUI
{
    LoginView *loginView = [[LoginView alloc] initWithFrame:self.view.bounds];
    loginView.delegate = self;
    loginView.textFieldCount = 3;
    
    loginView.titleLabel.text = @"账号注册";
    _loginView = loginView;
    
    UIImageView *accountImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:MaoErPhoneNumberImageName]];
    accountImageView.size = CGSizeMake(accountImageView.width + 5, accountImageView.height - 5);
    accountImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    //重写占位文字
     _loginView.accountField.placeholder = MaoErSDKPhonePlaceholdText;
    _loginView.accountField.leftView = accountImageView;
    _loginView.accountField.leftViewMode = UITextFieldViewModeAlways;
    _loginView.accountField.delegate = self;
    
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
    
    [_loginView.registBtn setTitle:MaoErSDKUpperRightButtonText forState:UIControlStateNormal];
    [_loginView.registBtn setBackgroundColor:[UIColor colorWithRed:228 / 255.0 green:167 / 255.0 blue:21 / 255.0 alpha:1]];
    
    [_loginView.touristsBtn setTitle:MaoErSDKUserAgreementText forState:UIControlStateNormal];
    [_loginView.touristsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_loginView.touristsBtn setImage:[UIImage imageNamed:@"mr_check"] forState:UIControlStateNormal];
    [_loginView.touristsBtn setImage:[UIImage imageNamed:@"mr_checked"] forState:UIControlStateSelected];
    //用户协议默认是选中
    _loginView.touristsBtn.selected = YES;
    self.btnIsSelected = _loginView.touristsBtn.selected;
    
    [_loginView.finderBtn setTitle:@"其它方式注册" forState:UIControlStateNormal];
    [_loginView.finderBtn setTitleColor:[UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1] forState:UIControlStateNormal];
    
    [self.view addSubview:loginView];
}
-(void)clickButton:(MRBaseButton *)button
{

    
    if ([button.titleLabel.text isEqualToString:MaoErSDKUpperRightButtonText]){
        [self registAccount];
    } else if ([button.titleLabel.text isEqualToString:MaoErSDKSendAuthCodeButtonText]){
        [self sendAuthCode];
    } else if ([button.titleLabel.text containsString:MaoErSDKUserAgreementText]){
        [self setUserAgreement:button];
    } else if ([button.titleLabel.text containsString:@"其它方式注册"]){
        OtherRegistViewController *otherRegistVC = [[OtherRegistViewController alloc] init];
        [self.navigationController pushViewController:otherRegistVC animated:YES];
    }else {
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)setUserAgreement:(MRBaseButton *)button
{
    button.selected = button.selected ? NO : YES;
    self.btnIsSelected = button.selected;
}

- (void)loginBtnChangeState
{
    if (!_loginView.accountField.text.length || !_loginView.pwdField.text.length || !_loginView.authCodeField.text.length)
    {
        _loginView.registBtn.backgroundColor = [UIColor blackColor];
        _loginView.userInteractionEnabled = NO;
    } else {
        
            _loginView.registBtn.backgroundColor = [UIColor redColor];
            _loginView.userInteractionEnabled = YES;
    }
    
}
#pragma mark --- 网络请求 ---
 //发送验证码
- (void)sendAuthCode
{
  
    if (!isTelephone(_loginView.accountField.text)) {///< 手机号码输入有误
        [self customAlertView:@"请输入正确的手机号" withAlertTitle:MaoErSDKUpperRightButtonText];
        
    } else {
        NSString *accountStr = _loginView.accountField.text;
        NSString *urlStr = [NSString stringWithFormat:@"%@%@", userBaseUrl, sendAuthCodeURL];
        //转圈圈
        [MEProgressHUD showMessage:@"Loading..." toView:self.loginView];
        
        NSDictionary *dict =  @{
                                @"phone" :accountStr,
                                @"type"  : @"1"
                                };
        
        NSMutableDictionary *parameters = commonParameters();
        [parameters addEntriesFromDictionary:dict]; ///< 添加公共参数
        [HttpsTools post:urlStr params:parameters success:^(id json) {
            //隐藏hud
            [MEProgressHUD hideHUDForView:self.loginView];
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingMutableLeaves error:nil];
              [self startTimer];
            NSLog(@"%@",dict);
            ///发送成功的话倒计时
            
            
        } failure:^(NSError *error) {
            [MEProgressHUD hideHUDForView:self.loginView];
        }];
        
    }
}
//注册账号
- (void)registAccount
{
    
    if (!_loginView.accountField.text.length || !_loginView.pwdField.text.length || !_loginView.authCodeField.text.length) {
        
        [self customAlertView:@"输入框不能为空" withAlertTitle:@"注册"];
        
    } else if (!self.btnIsSelected) { //判断是否同意用户协议
        [self customAlertView:@"请接受用户协议" withAlertTitle:@"注册"];
    } else {
        
        NSString *accountStr = _loginView.accountField.text;
        NSString *pwdStr = _loginView.pwdField.text;
        NSString *authCodeStr = _loginView.authCodeField.text;
        NSString *urlStr = [NSString stringWithFormat:@"%@%@", userBaseUrl, registUrl];
        //转圈圈
        [MEProgressHUD showMessage:@"Loading..." toView:self.loginView];
        
        NSDictionary *parameters =  @{
                                      @"username" : accountStr,
                                      @"password" : pwdStr,
                                      @"verify"   : authCodeStr, //验证码
                                      @"type"    : @"phone"
                                      };
        
        [HttpsTools post:urlStr params:parameters success:^(id json) {
            //隐藏hud
            [MEProgressHUD hideHUDForView:self.loginView];
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingMutableLeaves error:nil];
            NSLog(@"%@",dict);
            
        } failure:^(NSError *error) {
            [MEProgressHUD hideHUDForView:self.loginView];
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
#pragma mark --- 通用的alertView ---
- (void)customAlertView:(NSString *)alertString withAlertTitle:(NSString *)title
{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:alertString preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    
    UIAlertAction *aa = [UIAlertAction actionWithTitle:@"q" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:cancelAction];
    [alert addAction:sureAction];
    [self presentViewController:alert animated:YES completion:nil];
}
@end
