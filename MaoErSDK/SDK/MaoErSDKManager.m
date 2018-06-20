//
//  MaoErSDKManager.m
//  MaoErSDK
//
//  Created by MRIOS on 2018/4/21.
//  Copyright © 2018年 Maor. All rights reserved.
//

#import "MaoErSDKManager.h"
#import "MRNavigationController.h"
#import "MRLoginViewController.h"
@interface MaoErSDKManager()
@property(nonatomic, strong) id loginResultData;
@property(nonatomic, strong) id touristsLoginResultData;
@end

@implementation MaoErSDKManager


- (instancetype)initWithViewController:(UIViewController *)viewController
{
    MaoErSDKManager *manager = [super init];
    MRNavigationController *nav = [[MRNavigationController alloc] initWithRootViewController:nil];
    [viewController addChildViewController:nav];
    [viewController.view addSubview:nav.view];
    [self addNotification];
    return manager;

}

- (void)addNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logBtnClick:) name:MaoErSDKLoginResultNotificationName object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(touristsLogBtnClick:) name:MaoErSDKTouristsLoginResultNotificationName object:nil];
}

#pragma mark --- NSNotification ---
- (void)logBtnClick:(NSNotification *)center
{
    if (self.loginResultMessageBlock) {
        self.loginResultMessageBlock(center.userInfo);
    }
}
- (void)touristsLogBtnClick:(NSNotification *)center
{
    if (_touristsLoginResultMessagrBlock) {
        _touristsLoginResultMessagrBlock(center.userInfo);
    }
}

#pragma mark --- dealloc ---
- (void)dealloc
{
    NSLog(@"-------dealloc--------");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
