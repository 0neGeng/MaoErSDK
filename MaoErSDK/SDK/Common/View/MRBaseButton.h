//
//  MRBaseButton.h
//  MaoErSDK
//
//  Created by MRIOS on 2018/4/8.
//  Copyright © 2018年 Maor. All rights reserved.
//

#import <UIKit/UIKit.h>

//发送验证码按钮的类型
typedef NS_ENUM(NSInteger, MRBaseButtonType){
    MRBaseButtonTypeSolid   = 0, ///< 带有背景色
    MRBaseButtonTypeHollow  = 1  ///< 空心带有边框
};

@interface MRBaseButton : UIButton

@property(nonatomic) MRBaseButtonType mrBaseButtonType;
@end
