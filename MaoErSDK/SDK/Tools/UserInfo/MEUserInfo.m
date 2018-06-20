//
//  MEUserInfo.m
//  MaoErSDK
//
//  Created by MRIOS on 2018/4/17.
//  Copyright © 2018年 Maor. All rights reserved.
//

#import "MEUserInfo.h"

/**
 all data keys
 新增存储属性需要更新keys,同时更新对应的增删改查方法
*/
#define UserAccount          @"UserAccount"
#define UserPwd              @"UserPwd"
#define UserID               @"UserID"

@implementation MEUserInfo

- (void)laodUserInfoFromSanbox
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.accountNumber = [defaults objectForKey:UserAccount];
    self.passWord      = [defaults objectForKey:UserPwd];
    self.userID        = [defaults objectForKey:UserID];

}

- (void)saveUseInfoToSanbox
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.accountNumber forKey:UserAccount];
    [defaults setObject:self.passWord forKey:UserPwd];
    [defaults setObject:self.userID forKey:UserID];
}

- (void)removeUserInfoFromSanbox
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:UserAccount];
    [defaults removeObjectForKey:UserPwd];
    [defaults removeObjectForKey:UserID];
}


@end
