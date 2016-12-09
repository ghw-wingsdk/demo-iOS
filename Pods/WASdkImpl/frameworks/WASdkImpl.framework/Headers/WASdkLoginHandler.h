//
//  WASDKLoginHandler.h
//  WASDKUI
//
//  Created by wuyx on 15/9/6.
//  Copyright (c) 2015年 GHW-T-01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WASdkIntf/WASdkIntf.h>
#import <WACommon/WACommon.h>

@interface WASdkLoginHandler : NSObject
+(void)loginWithResult:(WALoginResult*)loginResult delegate:(id<WALoginDelegate>)delegate;
+(void)loginWithResult:(WALoginResult*)loginResult extInfo:(NSString*)extInfo delegate:(id<WALoginDelegate>)delegate;
+(void)refreshTokenWithBlock:(void(^)(NSError* error ,NSString* token))block;
+(void)getLoginWay:(void(^)(NSError* error ,NSArray* loginWays))block;
@end
