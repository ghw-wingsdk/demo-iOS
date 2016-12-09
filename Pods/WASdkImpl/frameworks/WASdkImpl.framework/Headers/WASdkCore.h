//
//  WASDKCore.h
//  WASDKUI
//
//  Created by wuyx on 15/9/24.
//  Copyright (c) 2015年 GHW-T-01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WASdkIntf/WASdkIntf.h>
#import <WACommon/WACommon.h>
#import "WASdkParamConfigObj.h"

#define WASdkLog(fmt,...) {\
if([WACoreProxy isDebugMode]){\
NSLog((@"WASDK LOG [(version %@) %s ]:" fmt), [WASdkCore getVersion],__FUNCTION__, ##__VA_ARGS__);\
[WACoreProxy addLogWithString:[NSString stringWithFormat:(@"(version %@) %s ]:" fmt),[WASdkCore getVersion],__FUNCTION__, ##__VA_ARGS__]];\
}\
}

@interface WASdkCore : WACore

/**
 *  初始化
 */
+(void)init;
/**
 *  设置调试模式
 *
 *  @param sdkType 0 国外，1 国内
 */
+(void)setSDKType:(NSInteger)sdkType;
/**
 *  获取sdk类型 0 国外，1 国内
 */
+(NSInteger)getSDKType;
/**
 *  设置调试模式
 *
 *  @param isDebugMode
 */
+(void)setDebugMode:(BOOL)isDebugMode;

/**
 *  是否调试模式
 */
+(BOOL)isDebugMode;

/**
 *  获取gameUserId
 */
+(NSString*)getGameUserId;

/**
 *  获取serverId
 */
+(NSString*)getServerId;

/**
 *  设置userId
 */
+(NSString*)getUserId;

/**
 *  获取level
 */
+(int)getLevel;


/**
 *  appId
 */
+(NSString*)getAppId;

/**
 *  appKey
 */
+(NSString*)getAppKey;

/**
 *  clientId
 */
+(NSString*)getClientId;

/**
 *  设置clientId
 *
 *  @param clientId
 */
+(void)setClientId:(NSString*)clientId;

/**
 *  添加日志
 */
+(void)addLogWithString:(NSString*)string;

+(void)addEventContentWithString:(NSString*)string;

+(void)setParamConfig:(void(^)(NSError* error,WASdkParamConfigObj* config))block;

+(WASdkParamConfigObj*)getParamConfig;
/**
 *  版本信息
 */
+(NSString*)getVersion;
@end
