//
//  MRSDKConst.m
//  MaoErSDK
//
//  Created by MRIOS on 2018/4/4.
//  Copyright © 2018年 Maor. All rights reserved.
//

#import "MRSDKConst.h"
#import "MrDeviceIdUtil.h"
#import "MetadataHelper.h"


#define SDK_VERSION @"v1.0.3"

const CGFloat  MaoErSDKLoginInterfaceMargeTB = 20; 

const CGFloat MaoErSDKTitleMargeTop = 20; //20
//TextFiel的高度
const CGFloat MaoErSDKTextFieldHeight = 50;//50
//TextField 左右的间距
const CGFloat MaoErSDKTitleMargeLeftR = 10; //10
//ButtonH
const CGFloat MaoErSDKBackButtonWH = 50; //50
const BOOL MaoErSDKBackButtonIsRight = NO;     ///< 返回按钮的位置默认在左边
const CGFloat  MaoErSDKTwoTextFieldMarge = 20;  ///< 两行textfiext之间的间距
const CGFloat  MaoErSDKThreeTextFieldMarge = 3; ///< 三行textfiext之间的间距

/**
 用户相关借口
 */
NSString * const userBaseUrl       = @"https://api.maoergame.com/sdk/";  ///< base

NSString * const loginUrl          = @"?ct=user&ac=login";               ///< 登陆

NSString * const activateUrl       = @"?ct=user&ac=activate";            ///< 是否登陆

NSString * const registUrl         = @"?ct=user&ac=register";            ///< 注册

NSString * const initUrl           = @"?ct=user&ac=init";                ///< 初始化

NSString * const sendAuthCodeURL   = @"?ct=user&ac=send";                ///< 发送验证码

NSString * const finderPwdUrl      = @"?ct=user&ac=findpsw";             ///< 找回密码

NSString * const bindURL           = @"?ct=user&ac=bind";                ///< 干啥的

NSString * const queryUserInfoURL  = @"?ct=user&ac=detailinfo";          ///< 手机号注册




/**
 文字相关
 */

NSString * const MaoErSDKUpperLeftButtonText        = @"登录";       ///< 左上上按钮文字

NSString * const MaoErSDKUpperRightButtonText       = @"注册";       ///< 右上按钮文字

NSString * const MaoErSDKLowerRightButtonText       = @"找回密码 >";  ///< 右下按钮文字

NSString * const MaoErSDKLowerLeftButtonText        = @"游客登陆 >";  ///< 左下按钮文字

NSString * const MaoErSDKSendAuthCodeButtonText     = @"发送验证码";   ///< 发送验证码

NSString * const MaoErSDKResetPwdButtonText         = @"重置密码";    ///< 重置密码

NSString * const MaoErSDKUserAgreementText          = @"我已阅读并同意用户服务条款"; ///< 用户协议文案

//占位文字
NSString * const MaoErSDKAccountPlaceholdText   = @"请输入账号";   ///< 账号的占位文字

NSString * const MaoErSDKPhonePlaceholdText     = @"请输入手机号"; ///< 手机号码输入框占位文字

NSString * const MaoErSDKAuthCodePlaceholdText  = @"请输入验证码"; ///< 验证码输入框占位文字

NSString * const MaoErSDKPWDPlaceholdText       = @"请输入密码";   ///< 密码输入框占位文字


/**
 图片相关
 */
NSString * const MaoErBackImageName             = @"MaoErSDK_ImageResource.bundle/Resource/mr_back";    ///返回按钮
NSString * const MaoErPhoneNumberImageName      = @"MaoErSDK_ImageResource.bundle/Resource/mr_phone";   ///< 手机号码
NSString * const MaoErPhoneAuthCodeImageName    = @"MaoErSDK_ImageResource.bundle/Resource/mr_code";    ///< 手机验证码
NSString * const MaoErPhonePWDImageName         = @"MaoErSDK_ImageResource.bundle/Resource/mr";         ///< 手机号密码

NSString * const MaoErAccountImageName          = @"MaoErSDK_ImageResource.bundle/Resource/mr_user";    ///< 账号
NSString * const MaoErPasswordImageName         = @"MaoErSDK_ImageResource.bundle/Resource/mr";          ///< 密码

/**
 规则相关借口
 */
NSString * const roleDomainURL     = @"https://api.maoergame.com/role/";///< 规则查询baseUrl
NSString * const roleInfoURL       = @"?ct=role";
/**
 支付相关
 */
/**
 礼物相关
 */

#pragma mark 方法相关
BOOL isTelephone(NSString *telephoneNumber)
{
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    NSString * China = @"\\d{3}-\\d{8}|\\d{4}-\\d{7}";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    NSPredicate *regextestphs = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    NSPredicate *regextestchina = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", China];

    return  [regextestmobile evaluateWithObject:telephoneNumber]   ||
    [regextestphs evaluateWithObject:telephoneNumber]      ||
    [regextestct evaluateWithObject:telephoneNumber]       ||
    [regextestcu evaluateWithObject:telephoneNumber]       ||
    [regextestcm evaluateWithObject:telephoneNumber]       ||
    [regextestchina evaluateWithObject:telephoneNumber];
}

NSNumber * getTimestamp(void)
{
    UInt64 recordTime = [[NSDate date] timeIntervalSince1970];
    NSNumber *number = [NSNumber numberWithLong:recordTime];
    return number;
}

NSMutableDictionary *commonParameters (void)
{
    NSMutableDictionary *baseRequestPars = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                            [MrDeviceIdUtil getDeviceId]       , @"deviceid", ///< 设备udid
                                            [MetadataHelper getMrGameId]       , @"gameid",
                                            [MetadataHelper getMrPlatform]     , @"platform",
                                            [MetadataHelper getMrAdId]         , @"adid",
                                            @"ios"                             , @"os",
                                            [MrDeviceIdUtil getOsVersion]      , @"osversion",
                                            [MrDeviceIdUtil getAppVersionCode] , @"appversion",
                                            SDK_VERSION                        , @"sdkversion",
                                            [MrDeviceIdUtil getBrand]          , @"brand",
                                            getTimestamp()                     , @"time",
                                            [MrDeviceIdUtil getIdfa]           , @"imei",
                                            [MrDeviceIdUtil getMacAddress]     , @"mac",
                                            [MrDeviceIdUtil getPackageName]    , @"packagename",
                                            nil];
    return baseRequestPars;
}

UIAlertController * customAlertView(NSString *titleString, NSString *alertString)
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:titleString message:alertString preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action];
    return alert;
}
