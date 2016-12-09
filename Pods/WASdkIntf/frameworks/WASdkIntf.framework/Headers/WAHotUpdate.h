//
//  WAHotUpdate.h
//  WASdkIntfUI
//
//  Created by wuyx on 16/3/2.
//  Copyright © 2016年 GHW-T-01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WAHupProxy.h"
@interface WAHotUpdate : NSObject
-(void)checkUpdate:(void(^)(NSError* error,WAUpdateInfo* updateInfo))handler;
-(void)startUpdate:(WAUpdateInfo*)updateInfo handler:(void(^)(NSError* error))handler;
-(WAUpdateInfo*)getPatchInfo;
@end
