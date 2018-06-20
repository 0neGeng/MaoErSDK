//
//  MRLoginViewController.m
//  MaoErSDK
//
//  Created by MRIOS on 2018/4/8.
//  Copyright © 2018年 Maor. All rights reserved.
//

#import "MRLoginViewController.h"
#import "LoginView.h"
#import "UIView+Frame.h"
#import "RegistViewController.h"
#import "FindPwdViewController.h"
#import "MEProgressHUD+WG.h"
#import "MrDeviceIdUtil.h"
#import "MRSDKConst.h"
@interface MRLoginViewController ()<LoginviewDelegate, UITextFieldDelegate>

@property(nonatomic, strong) LoginView *loginView;

@end

@implementation MRLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];

}

- (void)setupUI
{

    LoginView *loginView = [[LoginView alloc] initWithFrame:self.view.bounds];
    loginView.delegate = self;
    loginView.textFieldCount = 2;
    
    loginView.titleLabel.text = @"游戏登录";
    _loginView = loginView;
    
    UIImageView *accountImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:MaoErAccountImageName]];
    accountImageView.size = CGSizeMake(accountImageView.width + 5, accountImageView.height - 5);
    accountImageView.contentMode = UIViewContentModeScaleAspectFit;
    _loginView.accountField.leftView = accountImageView;
    _loginView.accountField.leftViewMode = UITextFieldViewModeAlways;
    _loginView.accountField.placeholder = MaoErSDKAccountPlaceholdText;
    _loginView.accountField.delegate = self;
        
    
    UIImageView *pwdImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:MaoErPasswordImageName]];
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
    
    [_loginView.touristsBtn setTitle:MaoErSDKLowerLeftButtonText forState:UIControlStateNormal];
    [_loginView.touristsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [_loginView.finderBtn setTitle:MaoErSDKLowerRightButtonText forState:UIControlStateNormal];
    [_loginView.finderBtn setTitleColor:[UIColor colorWithRed:102 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1] forState:UIControlStateNormal];
    

    [self.view addSubview:loginView];
}
-(void)clickButton:(UIButton *)button
{

    
    if ([button.titleLabel.text isEqualToString:MaoErSDKUpperLeftButtonText]){
        [self fetchLoginData];
        
    }else if ([button.titleLabel.text isEqualToString:MaoErSDKUpperRightButtonText]){
        RegistViewController *vc = [[RegistViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([button.titleLabel.text isEqualToString:MaoErSDKLowerLeftButtonText]){
        [self fetchTouristsLoginData];
    } else if ([button.titleLabel.text isEqualToString:MaoErSDKLowerRightButtonText]){
        FindPwdViewController *vc = [[FindPwdViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        
    }
}


#pragma mark --- textfieldViewDelegate ---
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark --- 登陆 ---
- (void)fetchLoginData
{
    if (!_loginView.accountField.text.length  || !_loginView.pwdField.text.length) {

        UIAlertController *alert = customAlertView(@"游戏登陆", @"账号和密码为空");
        [self presentViewController:alert animated:YES completion:nil];
    } else {
        
        NSString *accountStr = _loginView.accountField.text;
        NSString *pwdStr = _loginView.pwdField.text;
        
        NSString *urlStr = [NSString stringWithFormat:@"%@%@", userBaseUrl, loginUrl];
        //转圈圈
        [MEProgressHUD showMessage:@"Loading..." toView:self.loginView];

        NSDictionary *dict =  @{
                                      @"type"     : @"r2",
                                      @"username" : accountStr,
                                      @"password" : pwdStr
                                      };
        NSMutableDictionary *parameters = commonParameters();
        [parameters addEntriesFromDictionary:dict];
        [HttpsTools post:urlStr params:parameters success:^(id json) {
            //隐藏hud
            [MEProgressHUD hideHUDForView:self.loginView];
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingMutableLeaves error:nil];
    
            [[NSNotificationCenter defaultCenter] postNotificationName:MaoErSDKLoginResultNotificationName object:nil userInfo:dict];
            
        } failure:^(NSError *error) {
            [MEProgressHUD hideHUDForView:self.loginView];
        }];
        
    }
}

///游客登陆的数据请求
- (void)fetchTouristsLoginData
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", userBaseUrl, loginUrl];
    //转圈圈
    [MEProgressHUD showMessage:@"Loading..." toView:self.loginView];
    
    NSDictionary *dict =  @{
                            @"openid"   : [MrDeviceIdUtil getDeviceId],
                            @"opentype" : @"1",
                            @"type"     : @"open"
                            };
    NSMutableDictionary *parameters = commonParameters();
    [parameters addEntriesFromDictionary:dict];
    [HttpsTools post:urlStr params:parameters success:^(id json) {
        //隐藏hud
        [MEProgressHUD hideHUDForView:self.loginView];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingMutableLeaves error:nil];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:MaoErSDKTouristsLoginResultNotificationName object:nil userInfo:dict];
        
    } failure:^(NSError *error) {///NSError
        [MEProgressHUD hideHUDForView:self.loginView];
        
    }];
}
- (void)dealloc
{
    NSLog(@"-----dealloc------");
}
@end
