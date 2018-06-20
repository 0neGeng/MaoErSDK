//
//  ViewController.m
//  MaoErSDK
//
//  Created by MRIOS on 2018/4/4.
//  Copyright © 2018年 Maor. All rights reserved.
//

#import "ViewController.h"
#import "MaoErSDK.h"
#import "MRNavigationController.h"
#import "UIView+Frame.h"
///375
@interface ViewController ()

@property(nonatomic, strong) MaoErSDKManager *manager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self test];

}


- (void)test
{
    

    MaoErSDKManager *manager = [[MaoErSDKManager alloc] initWithViewController:self];
    self.manager = manager;
    //
    manager.loginResultMessageBlock = ^(id resultMessage) {
        NSLog(@"%@", resultMessage);
    };
    manager.touristsLoginResultMessagrBlock = ^(id resultMessage) {
        NSLog(@"%@", resultMessage);
    };
   
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)buttonClick
{
    
}
@end
