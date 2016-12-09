//
//  WASDKSwitchAccountHandler.h
//  WASDKUI
//
//  Created by wuyx on 15/12/15.
//  Copyright © 2015年 GHW-T-01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WASdkIntf/WASdkIntf.h>
#import <WACommon/WACommon.h>
@interface WASdkAccountSwitchHandler : NSObject<WALoginDelegate>
/**
 *  切换账户
 */
+(void)switchAccount:(NSString*)accountType completeBlock:(void(^)(NSError* error,WALoginResult* result))block;
@end
