//
//  WAIAd.h
//  WASdkIntfUI
//
//  Created by hank on 2017/8/15.
//  Copyright © 2017年 GHW-T-01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WAAdProxy.h"

@interface WAIAd : NSObject

/** 加载广告 */
- (void)loadAd;

/** 设置视频广告缓存完回调 */
- (void)setWAAdRewardedVideoCachedDelegate:(id<WAAdRewardedVideoCachedDelegate>)delegate;

/** 检测可播放广告数量 */
- (NSInteger) checkRewardedVideo;

/** 显示广告 */
- (void) displayRewardedVideoWithExtInfo:(NSString *)extInfo delegate:(id<WAAdRewardedVideoDelegate>)delegate;

- (void)applicationDidBecomeActive:(UIApplication *)application;

- (void)applicationDidEnterBackground:(UIApplication *)application;

@end
