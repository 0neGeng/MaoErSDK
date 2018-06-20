//
//  MRBaseButton.m
//  MaoErSDK
//
//  Created by MRIOS on 2018/4/8.
//  Copyright © 2018年 Maor. All rights reserved.
//

#import "MRBaseButton.h"

@implementation MRBaseButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupAppearance];
    }
    return self;
}

- (void)setupAppearance{
    self.layer.cornerRadius = 5;
}
@end
