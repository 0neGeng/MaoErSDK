//
//  MetadataHelper.m
//  mrsdk
//
//  Created by zxq on 2018/2/19.
//  Copyright © 2018年 maoer. All rights reserved.
//

#import "MetadataHelper.h"

@implementation MetadataHelper

static NSDictionary* _infoPlistDict = nil;

+(NSString*)getMrGameId
{
    return [self getMetaDataString:@"Mr_GAME_ID"];
}

+(NSString*)getMrAdId
{
    return [self getMetaDataString:@"Mr_ADID"];
}

+(NSString*)getMrPlatform
{
    return [self getMetaDataString:@"Mr_PLATFORM"];
}

+(UIInterfaceOrientationMask)getUISupportedInterfaceOrientations
{
    NSArray *orientations = [self getMetaDataArray:@"UISupportedInterfaceOrientations"];
    if(orientations.count > 0) {
        UIInterfaceOrientationMask mask = [self getUIInterfaceOrientationMaskByStr:[orientations objectAtIndex:0]] ;
        int index = 1;
        while (index < orientations.count) {
            mask |= [self getUIInterfaceOrientationMaskByStr:[orientations objectAtIndex:index]];
            index++;
        }
        return mask;
    }
    return UIInterfaceOrientationMaskAll;
}

+(UIInterfaceOrientationMask)getUIInterfaceOrientationMaskByStr :(NSString*)str
{
    UIInterfaceOrientationMask mask = UIInterfaceOrientationMaskAll;
    if([str isEqualToString:@"UIInterfaceOrientationLandscapeLeft"]) {
        mask = UIInterfaceOrientationMaskLandscapeLeft;
    }else if([str isEqualToString:@"UIInterfaceOrientationLandscapeRight"]) {
        mask = UIInterfaceOrientationMaskLandscapeRight;
    }else if([str isEqualToString:@"UIInterfaceOrientationPortrait"]) {
        mask = UIInterfaceOrientationMaskPortrait;
    }else if([str isEqualToString:@"UIInterfaceOrientationPortraitUpsideDown"]) {
        mask = UIInterfaceOrientationMaskPortraitUpsideDown;
    }
    
    return mask;
}

+(NSString*) getMetaDataString:(NSString*)key
{
    NSDictionary *dict = [self getInfoPlistDict];
    return (NSString*)dict[key];
}

+(NSArray*)getMetaDataArray:(NSString*)key
{
    NSDictionary *dict = [self getInfoPlistDict];
    return (NSArray*)dict[key];
}

+(NSDictionary*) getInfoPlistDict
{
    if(_infoPlistDict) {
        return _infoPlistDict;
    }
    NSString* File = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] initWithContentsOfFile:File];
    _infoPlistDict = dict;
    return dict;
}

@end
