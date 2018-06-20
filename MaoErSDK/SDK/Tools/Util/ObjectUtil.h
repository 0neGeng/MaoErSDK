//
//  ObjectUtil.h
//  mrsdk
//
//  Created by zxq on 2018/2/13.
//  Copyright © 2018年 maoer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ObjectUtil : NSObject

+ (NSDictionary*)getObjectData:(id)obj;
+ (id)getObjectInternal:(id)obj;

@end
