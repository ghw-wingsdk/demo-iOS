//
//  WASDKCatchHandler.h
//  WASDKUI
//
//  Created by wuyx on 16/2/26.
//  Copyright © 2016年 GHW-T-01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WACommon/WACommon.h>
@interface WASdkCacheHandler : NSObject
+(void)clearLoginCache;
+(void)setCurrentLoginPlatform:(NSString *)platform;
+(NSString*)getCurrentLoginPlatform;
@end
