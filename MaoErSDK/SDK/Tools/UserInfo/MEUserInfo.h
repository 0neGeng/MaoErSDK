//
//  MEUserInfo.h
//  MaoErSDK
//
//  Created by MRIOS on 2018/4/17.
//  Copyright © 2018年 Maor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MEUserInfo : NSObject
/**
 用户账号 -> 可能是手机号，也可能是别的账号
 */
@property(nonatomic, copy) NSString *accountNumber;

/**
 密码
 */
@property(nonatomic, copy) NSString *passWord;
/**
 userID
 */
@property(nonatomic, copy) NSString *userID;

/**
 保存数据到用户沙盒
 */
- (void)saveUseInfoToSanbox;

/**
 从沙盒里面取数据
 */
- (void)laodUserInfoFromSanbox;


/**
 清空用户数据
 */
- (void)removeUserInfoFromSanbox;


@end
