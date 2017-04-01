//
//  WASDKSwitchConfig.h
//  WASDKUI
//
//  Created by wuyx on 15/11/25.
//  Copyright © 2015年 GHW-T-01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WACommon/WACommon.h>
#import <WASdkIntf/WASdkIntf.h>

@interface WASdkParamConfig : NSObject
+(void)requestWithCompleteBlock:(void(^)(NSError* error,WAParamConfigObj* config))block;
+(WAParamConfigObj*)parserWithDict:(NSDictionary*)dict;
@end
