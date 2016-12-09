//
//  WASDKAcountBinding.h
//  WASDKUI
//
//  Created by wuyx on 15/7/8.
//  Copyright (c) 2015年 GHW-T-01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WASdkIntf/WASdkIntf.h>
#import <WACommon/WACommon.h>
@interface WASdkAccountBinding : NSObject
@property(nonatomic,copy)NSString* userId;
@property(nonatomic,copy)NSString* preUserId;
@property(nonatomic,copy)NSString* prePlatform;
@property(nonatomic,copy)NSString* platform;
@property(nonatomic,copy)NSString* accessToken;
@property(nonatomic,copy)NSString* extInfo;

+(void)bindingAccountWithPlatform:(NSString *)platform bindingResult:(WABindingResult*)bindingResult extInfo:(NSString *)extInfo  delegate:(id<WAAccountBindingDelegate>)delegate;
+(void)queryBindedThirdPartyAccountWithCompleteBlock:(void(^)(NSError* error,NSArray<WAAccount *>* accounts))block;
+(void)queryBindedAccountWithCompleteBlock:(void(^)(NSError* error,NSArray* accounts))block;
+(void)unBindAccount:(WAAccount*)account block:(void(^)(NSError* error))block;
+(void)unBindAccount:(NSString*)platform userId:(NSString*)pUserId block:(void(^)(NSError* error))block;
@end
