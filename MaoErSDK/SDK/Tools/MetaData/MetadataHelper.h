//
//  MetadataHelper.h
//  mrsdk
//
//  Created by zxq on 2018/2/19.
//  Copyright © 2018年 maoer. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface MetadataHelper : NSObject

+(NSString*)getMrGameId;
+(NSString*)getMrAdId;
+(NSString*)getMrPlatform;
+(UIInterfaceOrientationMask)getUISupportedInterfaceOrientations;

@end
