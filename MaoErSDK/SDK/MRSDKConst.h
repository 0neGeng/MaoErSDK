//
//  MRSDKConst.h
//  MaoErSDK
//
//  Created by MRIOS on 2018/4/4.
//  Copyright © 2018年 Maor. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 提示信息
 */

//请求出错
#define MaoErSDKErrorMsg @"请求超时，请重试"
//验证码为空
#define MaoErSDKAuthCodeNil @"请输入正确的验证码"

///登陆结果通知名称
#define MaoErSDKLoginResultNotificationName @"MR_LOGIN_BTN_CLICK"
///游客登录结果通知名称
#define MaoErSDKTouristsLoginResultNotificationName @"MR_TOURISTS_LOGIN_BTN_CLICK"

/**
 颜色字体属性
 */
//主题色
#define MaoErSDKThemeColor [UIColor blackColor]
//textfield背景色
#define MaoErSDKTextFieldBackgroundColor [UIColor whiteColor]
//标题的颜色
#define MaoErSDKTitleLabelColor [UIColor whiteColor]
//标题的字体大小
#define MaoErSDKTitleLabelFont [UIFont systemFontOfSize:26]
//按钮的字体大小
#define MaoErSDKButtonFont [UIFont systemFontOfSize:20]
//占位文职的颜色
#define MaoErSDKTextFieldPlaceholdColor [UIColor whiteColor]
//发松验证码字体以及边框颜色
#define MaoErSDKAuthCodeButtonColor [UIColor redColor]
//返回按钮的frmae
#define MaoErSDKBackButtonFrame CGSizeMake(30, 30)


/**
 间距
 */
//loginInterface上下间距
UIKIT_EXTERN const CGFloat  MaoErSDKLoginInterfaceMargeTB; // 默认控件居中，上下间距
//两行textfiext之间的间距
UIKIT_EXTERN const CGFloat  MaoErSDKTwoTextFieldMarge;
//三行textfiext之间的间距
UIKIT_EXTERN const CGFloat  MaoErSDKThreeTextFieldMarge;
//title顶部间距
UIKIT_EXTERN const CGFloat MaoErSDKTitleMargeTop; //20
//TextFiel的高度
UIKIT_EXTERN const CGFloat MaoErSDKTextFieldHeight; //50
//TextField 左右的间距
UIKIT_EXTERN const CGFloat MaoErSDKTitleMargeLeftR; //10
//ButtonH
UIKIT_EXTERN const CGFloat MaoErSDKBackButtonWH; //50
//返回按钮的位置
UIKIT_EXTERN const BOOL MaoErSDKBackButtonIsRight;



/**
 文字相关
 */
//左上上按钮文字
UIKIT_EXTERN NSString * const MaoErSDKUpperLeftButtonText;
//右上按钮文字
UIKIT_EXTERN NSString * const MaoErSDKUpperRightButtonText;
//右下按钮文字
UIKIT_EXTERN NSString * const MaoErSDKLowerRightButtonText;
//左下按钮文字
UIKIT_EXTERN NSString * const MaoErSDKLowerLeftButtonText;
//发送验证码
UIKIT_EXTERN NSString * const MaoErSDKSendAuthCodeButtonText;
//重置密码
UIKIT_EXTERN NSString * const MaoErSDKResetPwdButtonText;
//用户协议文案
UIKIT_EXTERN NSString * const MaoErSDKUserAgreementText;

// ********* 账号的占位文字 *********
UIKIT_EXTERN NSString * const MaoErSDKAccountPlaceholdText;
//手机号码输入框占位文字
UIKIT_EXTERN NSString * const MaoErSDKPhonePlaceholdText;
//验证码的占位文字
UIKIT_EXTERN NSString *const  MaoErSDKAuthCodePlaceholdText;
//密码的占位wen zi
UIKIT_EXTERN NSString * const MaoErSDKPWDPlaceholdText;

/**
 图片名称
 */
UIKIT_EXTERN NSString * const MaoErBackImageName;               ///返回按钮
UIKIT_EXTERN NSString * const MaoErPhoneNumberImageName;        ///< 手机号码
UIKIT_EXTERN NSString * const MaoErPhoneAuthCodeImageName;      ///< 手机验证码
UIKIT_EXTERN NSString * const MaoErPhonePWDImageName;           ///< 手机号密码

UIKIT_EXTERN NSString * const MaoErAccountImageName;            ///< 账号
UIKIT_EXTERN NSString * const MaoErPasswordImageName;           ///< 密码
/**
 * 网络请求地址
 */
UIKIT_EXTERN NSString * const initUrl;
UIKIT_EXTERN NSString * const userBaseUrl;
UIKIT_EXTERN NSString * const loginUrl;
UIKIT_EXTERN NSString * const activateUrl;
UIKIT_EXTERN NSString * const registUrl;
UIKIT_EXTERN NSString * const finderPwdUrl;
UIKIT_EXTERN NSString * const sendAuthCodeURL;
UIKIT_EXTERN NSString * const bindURL;
UIKIT_EXTERN NSString * const queryUserInfoURL;
//role
UIKIT_EXTERN NSString * const roleInfoURL;


#pragma mark 方法相关
BOOL isTelephone(NSString *telephoneNumber);                                       ///< 判断是不是正确的手机号

NSMutableDictionary * commonParameters (void);                                     ///< 共同参数

UIAlertController * customAlertView(NSString *titleString, NSString *alertString); ///<弹框提示
