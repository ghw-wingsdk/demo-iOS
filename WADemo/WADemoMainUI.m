//
//  GHWMainUI.m
//  GHWSDKDemo
//
//  Created by wuyx on 16/2/24.
//  Copyright © 2016年 GHW. All rights reserved.
//

#import "WADemoMainUI.h"
#import "WADemoButtonMain.h"
#import "WADemoButtonSwitch.h"
#import "WADemoLoginUI.h"
#import "WADemoAccountManagement.h"
#import "WADemoUtil.h"
#import "WADemoIapView.h"
#import "WADemoAppTrackingView.h"
#import "WADemoFBShareView.h"
#import "WADemoFBInviteView.h"
#import "WADemoFBGiftView.h"
#import "WADemoHotUpdateView.h"
#import "WADemoPayView.h"
#import "WADemoInvite.h"
#import "WADemoGiftView.h"
//#import <WASdkImpl/WASdkLoginHandler.h>
@interface WADemoMainUI () <WAPaymentDelegate>

@end

@implementation WADemoMainUI

-(instancetype)init{
    self = [super init];
    if (self) {
        //添加界面旋转通知
        [WADemoUtil addOrientationNotification:self selector:@selector(handleDeviceOrientationDidChange:) object:nil];
        [self initBtnAndLayout];
    }
    return self;
}
-(void)initBtnAndLayout{
    NSMutableArray* btns = [NSMutableArray array];
//    GHWButtonSwitch* btn1 = [[GHWButtonSwitch alloc]init];
//    [btn1 setTitle:@"启用LOGCAT" forState:UIControlStateNormal];
//    [btn1 addTarget:self action:@selector(logCat:) forControlEvents:UIControlEventTouchUpInside];
//    [btns addObject:btn1];
    WADemoButtonSwitch* btn2 = [[WADemoButtonSwitch alloc]init];
    [btn2 setTitle:@"启用应用墙" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(appWall:) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn2];
    WADemoButtonMain* btn3 = [[WADemoButtonMain alloc]init];
    [btn3 setTitle:@"登录" forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn3];
    WADemoButtonMain* btn4 = [[WADemoButtonMain alloc]init];
    [btn4 setTitle:@"账户管理" forState:UIControlStateNormal];
    [btn4 addTarget:self action:@selector(acctManagement) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn4];
    WADemoButtonMain* btn5 = [[WADemoButtonMain alloc]init];
//    [btn5 setTitle:@"应用内支付" forState:UIControlStateNormal];
//    [btn5 addTarget:self action:@selector(iap) forControlEvents:UIControlEventTouchUpInside];
//    [btns addObject:btn5];
    [btn5 setTitle:@"支付" forState:UIControlStateNormal];
    [btn5 addTarget:self action:@selector(pay) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn5];
    WADemoButtonMain* btn6 = [[WADemoButtonMain alloc]init];
    [btn6 setTitle:@"数据收集" forState:UIControlStateNormal];
    [btn6 addTarget:self action:@selector(appTracking) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn6];
    WADemoButtonMain* btn7 = [[WADemoButtonMain alloc]init];
    [btn7 setTitle:@"Facebook分享" forState:UIControlStateNormal];
    [btn7 addTarget:self action:@selector(facebookShare) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn7];
    WADemoButtonMain* btn8 = [[WADemoButtonMain alloc]init];
    [btn8 setTitle:@"邀请" forState:UIControlStateNormal];
    [btn8 addTarget:self action:@selector(facebookInvite) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn8];
    WADemoButtonMain* btn9 = [[WADemoButtonMain alloc]init];
    [btn9 setTitle:@"礼物" forState:UIControlStateNormal];
    [btn9 addTarget:self action:@selector(gifting) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn9];    
    WADemoButtonMain* btn11 = [[WADemoButtonMain alloc]init];
    [btn11 setTitle:@"检查更新" forState:UIControlStateNormal];
    [btn11 addTarget:self action:@selector(checkUpdate) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn11];
    WADemoButtonMain* btn12 = [[WADemoButtonMain alloc]init];
    [btn12 setTitle:@"购买商品" forState:UIControlStateNormal];
    [btn12 addTarget:self action:@selector(payProduct) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn12];
    WADemoButtonMain* btn10 = [[WADemoButtonMain alloc]init];
    [btn10 setTitle:@"闪退测试" forState:UIControlStateNormal];
    [btn10 addTarget:self action:@selector(crash) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn10];
    NSMutableArray* btnLayout = [NSMutableArray arrayWithArray:@[@2,@2,@2,@2,@2,@0,@1]];

    self.title = @"WADemo3.6.1";
    self.btnLayout = btnLayout;
    self.btns = btns;
}

#pragma mark Btn action
//Log
-(void)logCat:(WADemoButtonSwitch*)btn{
    if (btn.switchState == GHWButtonSwitchStateOn) {
        [btn setTitle:@"启用LOGCAT" forState:UIControlStateNormal];
        btn.switchState = GHWButtonSwitchStateOff;
    }else{
        [btn setTitle:@"禁用LOGCAT" forState:UIControlStateNormal];
        btn.switchState = GHWButtonSwitchStateOn;
    }
}
//应用墙
-(void)appWall:(WADemoButtonSwitch*)btn{
    if (btn.switchState == GHWButtonSwitchStateOn) {
        [btn setTitle:@"启用应用墙" forState:UIControlStateNormal];
        btn.switchState = GHWButtonSwitchStateOff;
        [WAApwProxy hideEntryFlowIcon];
        
    }else{
        [btn setTitle:@"禁用应用墙" forState:UIControlStateNormal];
        btn.switchState = GHWButtonSwitchStateOn;
        [WAApwProxy showEntryFlowIcon];
    }
}
//登录
-(void)login{
    UIViewController* vc = [WADemoUtil getCurrentVC];
    WADemoLoginUI* loginUI = [[WADemoLoginUI alloc]init];
    loginUI.hasBackBtn = YES;
    [vc.view addSubview:loginUI];
    [loginUI moveIn];
}

//账号管理
-(void)acctManagement{
    UIViewController* vc = [WADemoUtil getCurrentVC];
    WADemoAccountManagement* acctMgmt = [[WADemoAccountManagement alloc]init];
    acctMgmt.hasBackBtn = YES;
    [vc.view addSubview:acctMgmt];
    [acctMgmt moveIn];
}
//应用内支付
-(void)iap{
    UIViewController* vc = [WADemoUtil getCurrentVC];
    WADemoIapView* productList = [[WADemoIapView alloc]init];
    productList.hasBackBtn = YES;
    [vc.view addSubview:productList];
    [productList moveIn];
}
//数据收集
-(void)appTracking{
    UIViewController* vc = [WADemoUtil getCurrentVC];
    WADemoAppTrackingView* appTrackView = [[WADemoAppTrackingView alloc]init];
    appTrackView.hasBackBtn = YES;
    [vc.view addSubview:appTrackView];
    [appTrackView moveIn];
}
//facebook分享
-(void)facebookShare{
    UIViewController* vc = [WADemoUtil getCurrentVC];
    WADemoFBShareView* fbShareView = [[WADemoFBShareView alloc]init];
    fbShareView.hasBackBtn = YES;
    [vc.view addSubview:fbShareView];
    [fbShareView moveIn];
}
//facebook邀请
-(void)facebookInvite{
//    UIViewController* vc = [WADemoUtil getCurrentVC];
//    WADemoFBInviteView* fbInviteView = [[WADemoFBInviteView alloc]init];
//    fbInviteView.hasBackBtn = YES;
//    [vc.view addSubview:fbInviteView];
//    [fbInviteView moveIn];
    UIViewController* vc = [WADemoUtil getCurrentVC];
    WADemoInvite* inviteView = [[WADemoInvite alloc]init];
    inviteView.hasBackBtn = YES;
    [vc.view addSubview:inviteView];
    [inviteView moveIn];
}

//礼物
-(void)gifting{
    UIViewController* vc = [WADemoUtil getCurrentVC];
    WADemoGiftView* giftView = [[WADemoGiftView alloc]init];
    giftView.hasBackBtn = YES;
    [vc.view addSubview:giftView];
    [giftView moveIn];
}

- (void)crash {
    
    NSArray* array = [NSArray array];
    int i = (int)array[1];
    NSLog(@"%d",i);
    
}

- (void)pay
{
    UIViewController* vc = [WADemoUtil getCurrentVC];
    WADemoPayView* payView = [[WADemoPayView alloc]init];
    payView.hasBackBtn = YES;
    [vc.view addSubview:payView];
    [payView moveIn];
}

- (void)payProduct
{
    [WAPayProxy payWithProductId:@"10086" extInfo:@"" delegate:self];
}

-(void)handleDeviceOrientationDidChange:(NSNotification*)noti{
    [self setNeedsLayout];
}

-(void)checkUpdate{
    UIViewController* vc = [WADemoUtil getCurrentVC];
    WADemoHotUpdateView* hotUpdate = [[WADemoHotUpdateView alloc]init];
    hotUpdate.hasBackBtn = YES;
    [vc.view addSubview:hotUpdate];
    [hotUpdate moveIn];
}

#pragma mark 实现 WAPaymentDelegate
-(void)paymentDidCompleteWithResult:(WAIapResult*)iapResult andPlatform:(NSString*)platform{
    if (!iapResult) {
        NSLog(@"%@ 购买失败!", platform);
    }else{
        if (iapResult.resultCode == 1) {
            NSLog(@"%@ 支付成功.", platform);
        }else if (iapResult.resultCode == 2) {
            NSLog(@"%@ 支付失败.", platform);
        }else if (iapResult.resultCode == 3) {
            NSLog(@"%@ 取消.", platform);
        }else if (iapResult.resultCode == 4) {
            NSLog(@"%@ 上报失败.", platform);
        }else if (iapResult.resultCode == 5) {
            NSLog(@"%@ 商品未消耗.", platform);
        }else if (iapResult.resultCode == 6) {
            NSLog(@"%@ 创建订单失败.", platform);
        }
    }
}

-(void)paymentDidFailWithError:(NSError*)error andPlatform:(NSString*)platform{
    if (error) {
        NSLog(@"paymentDidFailWithError:%@",error.description);
    }
}

-(void)dealloc{
    [WADemoUtil removeOrientationNotification:self object:nil];
}

@end
