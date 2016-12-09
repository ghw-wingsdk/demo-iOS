//
//  WASDKAccountCreateHandler.h
//  WASDKUI
//
//  Created by wuyx on 16/1/21.
//  Copyright © 2016年 GHW-T-01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WASdkIntf/WASdkIntf.h>
#import <WACommon/WACommon.h>
@interface WASdkAccountCreateHandler : NSObject
+(void)createNewAccount:(void(^)(NSError* error,WALoginResult* result))block;
@end
