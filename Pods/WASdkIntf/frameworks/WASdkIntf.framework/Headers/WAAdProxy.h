//
//  WAAdProxy.h
//  WASdkIntfUI
//
//  Created by hank on 2017/8/15.
//  Copyright © 2017年 GHW-T-01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, WAAdCancelType) {
    WAAdCancelTypePlayBefore = 0, // 播放前取消（播放前提示页面）
    WAAdCancelTypePlaying,        // 播放过程中取消
    WAAdCancelTypePlayAfter,      // 播放后取消（下载页面取消）
};

/** 广告激励视频代理 */
@protocol WAAdRewardedVideoDelegate <NSObject>

/*!
 @abstract 显示视频前页面成功时回调
 @param campaignId 活动Id
 @param adSetId 广告Id
 @param rewarded 奖励物品
 @param rewardedCount 奖励物品数量
 @param extInfo CP扩展字段
 */
- (void) adPreDisplayRewardedVideoWithCampaignId:(NSString *)campaignId
                                           adSetId:(NSString *)adSetId
                                          rewarded:(NSString *)rewarded
                                     rewardedCount:(NSInteger)rewardedCount
                                           extInfo:(NSString *)extInfo;

/*!
 @abstract 点击叉按钮后回调
 @param campaignId 活动Id
 @param adSetId 广告Id
 @param process WAAdCancelTypePlayBefore 播放前取消，WAAdCancelTypePlaying 播放过程中取消, WAAdCancelTypeAfter 播放后取消（下载页面取消）
 @param extInfo CP扩展字段
 */
- (void) adDidCancelRewardedVideoWithCampaignId:(NSString *)campaignId
                                       adSetId:(NSString *)adSetId
                                       process:(WAAdCancelType)process
                                       extInfo:(NSString *)extInfo;

/*!
 @abstract 加载视频失败回调
 @param campaignId 活动Id
 @param adSetId 广告Id
 @param extInfo CP扩展字段
 */
- (void) adDidFailToLoadRewardedVideoWithCampaignId:(NSString *)campaignId
                                           adSetId:(NSString *)adSetId
                                           extInfo:(NSString *)extInfo;

/*!
 @abstract 播放视频结束回调
 @param campaignId 活动Id
 @param adSetId 广告Id
 @param rewarded 奖励物品
 @param rewardedCount 奖励物品数量
 @param extInfo CP扩展字段
 */
- (void) adDidDisplayRewardedVideoWithCampaignId:(NSString *)campaignId
                                        adSetId:(NSString *)adSetId
                                       rewarded:(NSString *)rewarded
                                  rewardedCount:(NSInteger)rewardedCount
                                        extInfo:(NSString *)extInfo;

/*!
 @abstract 播放完视频点击回调
 @param campaignId 活动Id
 @param adSetId 广告Id
 @param rewarded 奖励物品
 @param rewardedCount 奖励物品数量
 @param extInfo CP扩展字段
 */
- (void) adDidClickRewardedVideoWithCampaignId:(NSString *)campaignId
                                      adSetId:(NSString *)adSetId
                                     rewarded:(NSString *)rewarded
                                rewardedCount:(NSInteger)rewardedCount
                                      extInfo:(NSString *)extInfo;

@end

/** 视频广告缓存完代理 */
@protocol WAAdRewardedVideoCachedDelegate <NSObject>

/*!
 @abstract 视频广告缓存完成回调
 @param cacheCount 可用广告数量
 */
- (void)adDidRewardedVideoCachedWithCacheCount:(NSInteger)cacheCount;

@end

@interface WAAdProxy : NSObject

/** 加载广告 */
+ (void)loadAd;

/*!
 @abstract 设置视频广告缓存完回调
 @param delegate WAAdRewardedVideoCachedDelegate代理
 */
+ (void)setWAAdRewardedVideoCachedDelegate:(id<WAAdRewardedVideoCachedDelegate>)delegate;

/*!
 @abstract 检测可播放广告数量
 */
+ (NSInteger) checkRewardedVideo;

/*!
 @abstract 显示广告
 @param extInfo CP扩展字段
 @param delegate WAAdRewardedVideoDelegate代理
 */
+ (void) displayRewardedVideoWithExtInfo:(NSString *)extInfo delegate:(id<WAAdRewardedVideoDelegate>)delegate;

@end
