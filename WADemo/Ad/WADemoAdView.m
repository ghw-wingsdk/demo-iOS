//
//  WADemoAdView.m
//  WADemo
//
//  Created by hank on 2017/9/1.
//  Copyright © 2017年 GHW. All rights reserved.
//

#import "WADemoAdView.h"
#import "WADemoMaskLayer.h"
#import "WADemoButtonMain.h"
#import "WADemoUtil.h"
#import <WASdkIntf/WASdkIntf.h>
#import <Toast/Toast.h>
#import "WADemoLoginUI.h"

@interface WADemoAdView () <WAAdRewardedVideoCachedDelegate, WAAdRewardedVideoDelegate>

@property (nonatomic, strong) WADemoButtonMain* btn1;

@end

@implementation WADemoAdView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //添加界面旋转通知
        [WADemoUtil addOrientationNotification:self selector:@selector(handleDeviceOrientationDidChange:) object:nil];
        
        [WAAdProxy setWAAdRewardedVideoCachedDelegate:self];
        
        [self initViews];
    }
    return self;
}


-(void)handleDeviceOrientationDidChange:(NSNotification*)noti{
    [self setNeedsLayout];
}

-(void)initViews
{
    NSMutableArray* btns = [NSMutableArray array];
    _btn1 = [[WADemoButtonMain alloc]init];
    self.btn1.tag = 1;
    [self.btn1 setTitle:@"获取可播放广告个数" forState:UIControlStateNormal];
    [self.btn1 addTarget:self action:@selector(buttonEvents:) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:self.btn1];
    
    WADemoButtonMain* btn2 = [[WADemoButtonMain alloc]init];
    btn2.tag = 2;
    [btn2 setTitle:@"播放广告" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(buttonEvents:) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn2];
    
    

    
    
    NSMutableArray* btnLayout = [NSMutableArray arrayWithArray:@[@1,@1]];
    //
    self.title = @"广告";
    self.btnLayout = btnLayout;
    self.btns = btns;
}

- (void)buttonEvents:(WADemoButtonMain *)button
{
    if (button.tag == 1)
    {
        NSInteger canPlayVideoAd = [WAAdProxy checkRewardedVideo];
        NSString *msg = [NSString stringWithFormat:@"有%ld个广告可播放", (long)canPlayVideoAd];
        [button setTitle:msg forState:UIControlStateNormal];
    }
    else if (button.tag == 2)
    {
        if (! [WAUserProxy getCurrentLoginResult])
        {
            UIViewController* vc = [WADemoUtil getCurrentVC];
            WADemoLoginUI *loginUI = [[WADemoLoginUI alloc]initWithFrame:self.bounds];
            loginUI.hasBackBtn = YES;
            [vc.view addSubview:loginUI];
            [loginUI moveIn:nil];
            
            [self makeToast:@"请先登录"];
            return;
        }
        
        if ([WAAdProxy checkRewardedVideo] > 0)
            [WAAdProxy displayRewardedVideoWithExtInfo:nil delegate:self];
        else
            [self makeToast:@"没有广告可播放"];
    }
}

#pragma mark 实现WAAdRewardedVideoCachedDelegate
- (void)adDidRewardedVideoCachedWithCacheCount:(NSInteger)cacheCount
{
    NSString *msg = [NSString stringWithFormat:@"有%ld个广告可播放", (long)cacheCount];
    [self.btn1 setTitle:msg forState:UIControlStateNormal];
}

#pragma mark 实现WAAdRewardedVideoDelegate
- (void) adPreDisplayRewardedVideoWithCampaignId:(NSString *)campaignId
                                         adSetId:(NSString *)adSetId
                                        rewarded:(NSString *)rewarded
                                   rewardedCount:(NSInteger)rewardedCount
                                         extInfo:(NSString *)extInfo
{
    [self makeToast:@"视频准备播放"];
}

- (void) adDidCancelRewardedVideoWithCampaignId:(NSString *)campaignId
                                        adSetId:(NSString *)adSetId
                                        process:(WAAdCancelType)process
                                        extInfo:(NSString *)extInfo
{
    if (process == WAAdCancelTypePlayBefore)        // 播放前取消（播放前提示页面）
    {
        [self makeToast:@"播放前取消广告视频播放！"];
    }
    else if (process == WAAdCancelTypePlaying)      // 播放过程中取消
    {
        [self makeToast:@"播放过程中取消广告视频播放！"];
    }
    else if (process == WAAdCancelTypePlayAfter)    // 播放后取消（下载页面取消）
    {
        [self makeToast:@"下载页面取消广告视频播放！"];
    }
}

- (void) adDidFailToLoadRewardedVideoWithCampaignId:(NSString *)campaignId
                                            adSetId:(NSString *)adSetId
                                            extInfo:(NSString *)extInfo
{
    [self makeToast:@"播放广告视频失败！"];
}

- (void) adDidDisplayRewardedVideoWithCampaignId:(NSString *)campaignId
                                         adSetId:(NSString *)adSetId
                                        rewarded:(NSString *)rewarded
                                   rewardedCount:(NSInteger)rewardedCount
                                         extInfo:(NSString *)extInfo
{
    [self makeToast:@"视频播放完成"];
}

- (void) adDidClickRewardedVideoWithCampaignId:(NSString *)campaignId
                                       adSetId:(NSString *)adSetId
                                      rewarded:(NSString *)rewarded
                                 rewardedCount:(NSInteger)rewardedCount
                                       extInfo:(NSString *)extInfo
{
    [self makeToast:@"点击去下载"];
}

-(void)dealloc
{
    [WADemoUtil removeOrientationNotification:self object:nil];
}

@end
