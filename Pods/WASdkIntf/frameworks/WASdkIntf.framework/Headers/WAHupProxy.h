//
//  WAHupProxy.h
//  WASdkIntfUI
//
//  Created by wuyx on 16/3/2.
//  Copyright © 2016年 GHW-T-01. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WAUpdateInfo;
/*!
 @discussion WAHupProxy 该类为热更新的代理类。
 - - -
 */
@interface WAHupProxy : NSObject
/*!
 @abstract 检查更新
 @param handler 回调
 */
+(void)checkUpdate:(void(^)(NSError* error,WAUpdateInfo* updateInfo))handler;
/*!
 @abstract 开始更新
 @param handler 回调
 */
+(void)startUpdate:(WAUpdateInfo*)updateInfo handler:(void(^)(NSError* error))handler;
/*!
 @abstract 获取更新包信息
 @return WAUpdateInfo 更新包信息
 */
+(WAUpdateInfo*)getPatchInfo;
@end
