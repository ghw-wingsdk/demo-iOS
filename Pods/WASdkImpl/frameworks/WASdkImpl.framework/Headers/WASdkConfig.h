//
//  WASDKConfig.h
//  WASDKUI
//
//  Created by wuyx on 15/7/2.
//  Copyright (c) 2015年 GHW-T-01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WASdkConfig : NSObject
+(NSString*)getWASDKServerUrl;
+(NSString*)getAppKey;
+(NSString*)getPublishChannel;
+(NSString*)getChannel;
+(NSString*)getAppID;
+(NSString*)getOS;
+(NSString*)getSdkVer;
+(NSString *)getSdkId;
+(void)setAppKey:(NSString*)appKey;
+(void)setAppId:(NSString*)appKey;
@end
