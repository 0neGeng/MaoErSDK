//
//  MrDeviceIdUtil.h
//  mrsdk
//
//  Created by zxq on 2018/2/22.
//  Copyright © 2018年 maoer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MrDeviceIdUtil : NSObject

+(NSString*) getIdfa;
+(NSString*)getAppVersionCode;
+(NSString*)getOsVersion;
+(NSString*)getBrand;
+(NSString*)getUUid;
+(NSString*)getMacAddress;
+(NSString*)getDeviceId;
+(NSString*)getPackageName;

@end
