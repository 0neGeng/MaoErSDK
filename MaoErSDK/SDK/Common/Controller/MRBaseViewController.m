
//
//  MRBaseViewController.m
//  MaoErSDK
//
//  Created by MRIOS on 2018/4/11.
//  Copyright © 2018年 Maor. All rights reserved.
//

#import "MRBaseViewController.h"
#import "MRSDKConst.h"
@interface MRBaseViewController ()<UITextFieldDelegate>

@end

@implementation MRBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.frame = self.navigationController.view.bounds;;

}

#pragma mark --- textfieldViewDelegate ---
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end
