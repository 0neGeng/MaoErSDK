//
//  MRBaseTextField.m
//  MaoErSDK
//
//  Created by MRIOS on 2018/4/20.
//  Copyright © 2018年 Maor. All rights reserved.
//

#import "MRBaseTextField.h"
#import "MRSDKConst.h"
@implementation MRBaseTextField


- (void)layoutSubviews
{
    [super layoutSubviews];
    [self setupUI];
}
///定义全局UI
- (void)setupUI
{
    self.backgroundColor = MaoErSDKTextFieldBackgroundColor;

//    [self setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
}
@end
