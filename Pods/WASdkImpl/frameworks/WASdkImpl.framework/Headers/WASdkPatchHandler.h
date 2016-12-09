//
//  WASDKPatchHandler.h
//  testDownload
//
//  Created by wuyx on 15/10/21.
//  Copyright © 2015年 GHW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WACommon/WACommon.h>
#import <WASdkIntf/WASdkIntf.h>
@interface WASdkPatchHandler : NSObject
+(void)downloadPatchZipWithHandler:(void(^)(NSError* error))handler andUpdateInfo:(WAUpdateInfo*)updateInfo;
+(void)checkUpdate:(void(^)(NSError* error,WAUpdateInfo* updateInfo))handler;
+(void)startUpdate:(WAUpdateInfo*)updateInfo handler:(void(^)(NSError* error))handler;
+(void)waxStart;
+(void)checkPatchInfoWithHandler:(void (^)(NSError* error,WAUpdateInfo* info,int code,NSString* msg))handler;
+(WAUpdateInfo*)getPatchInfo;
+(void)waxStartWithPath:(NSString*)path;
@end
