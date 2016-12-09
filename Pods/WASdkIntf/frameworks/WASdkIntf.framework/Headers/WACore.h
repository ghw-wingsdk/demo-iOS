//
//  WACore.h
//  WASdkIntfUI
//
//  Created by wuyx on 16/3/1.
//  Copyright © 2016年 GHW-T-01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface WACore : NSObject
-(void)initialize;
-(void)initAppEventTracker;
-(void)setSDKType:(NSInteger)sdkType;
-(NSInteger)getSDKType;
-(BOOL)isDebugMode;
-(void)setDebugMode:(BOOL)isDebugMode;
-(BOOL)displayLog;
-(NSString*)getUserId;
-(void)setServerId:(NSString *)serverId;
-(NSString*)getGameUserId;
-(NSString*)getServerId;
-(void)setLevel:(int)level;
-(int)getLevel;
-(void)setGameUserId:(NSString*)gameUserId;
-(void)addLogWithString:(NSString*)string;
-(void)addLogWithoutBtn:(NSString*)string;
-(NSString*)getSdkVersion;
-(NSString*)getWaSdkServerUrl;
-(NSString*)getAppKey;
-(NSString*)getPublishChannel;
-(NSString*)getChannel;
-(NSString*)getAppID;
-(NSString*)getOS;
-(NSString*)getSdkVer;
-(NSString*)getSdkId;
-(NSString*)getSessionId;
-(NSString*)getDeepLinkWithUrl:(NSURL*)url;
-(void)fetchDeferredAppLink:(void(^)(NSURL *url, NSError *error))handler;
-(void)addEventContentWithString:(NSString*)string;
-(void)eventLogWithPlatform:(NSString*)platform eventName:(NSString*)eventName parameters:(NSDictionary*)parameters color:(UIColor*)color;
@end
