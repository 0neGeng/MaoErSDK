//
//  MRNavigationController.m
//  MaoErSDK
//
//  Created by MRIOS on 2018/4/8.
//  Copyright © 2018年 Maor. All rights reserved.
//

#import "MRNavigationController.h"
#import "MRLoginViewController.h"
#import "MRSDKConst.h"
@interface MRNavigationController ()

@end

@implementation MRNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationBar.hidden = YES;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupUI];
}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    if (rootViewController == nil) {
        rootViewController = [[MRLoginViewController alloc] init];
    }
    self = [super initWithRootViewController:rootViewController];
    return self;
}
- (void)setupUI
{

    CGFloat height = [UIScreen mainScreen].bounds.size.height - MaoErSDKLoginInterfaceMargeTB * 2;
    CGFloat width = height - 20;
    self.view.size = CGSizeMake(width, height);
    self.view.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, [UIScreen mainScreen].bounds.size.height / 2);
    self.view.layer.cornerRadius = 6;
    self.view.clipsToBounds = YES;
}

///重写push方法，拦截push
#warning lose
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) {
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"mr_back.png"] style:UIBarButtonItemStylePlain target:self action:@selector(popViewControllerAnimated:)];
    }
    [super pushViewController:viewController animated:animated];
}





@end
