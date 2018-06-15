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
#import "WADemoAdView.h"
#import <Toast/Toast.h>
#import "WADemoCscViewController.h"

@interface WADemoMainUI () <WAPaymentDelegate>

@property (nonatomic, strong) WADemoLoginUI* loginUI;
@property (nonatomic, strong) WADemoAccountManagement* acctMgmt;
@property (nonatomic, strong) WADemoIapView* productList;
@property (nonatomic, strong) WADemoAppTrackingView* appTrackView;
@property (nonatomic, strong) WADemoFBShareView* fbShareView;
@property (nonatomic, strong) WADemoInvite* inviteView;
@property (nonatomic, strong) WADemoGiftView* giftView;
@property (nonatomic, strong) WADemoPayView* payView;
@property (nonatomic, strong) WADemoHotUpdateView* hotUpdate;
@property (nonatomic, strong) WADemoAdView* adView;

@end

@implementation WADemoMainUI

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initBtnAndLayout];
    }
    return self;
}
-(void)initBtnAndLayout{
    NSMutableArray* btns = [NSMutableArray array];
//    WADemoButtonSwitch* btn1 = [[WADemoButtonSwitch alloc]init];
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
    WADemoButtonMain* btn13 = [[WADemoButtonMain alloc]init];
    [btn13 setTitle:@"广告" forState:UIControlStateNormal];
    [btn13 addTarget:self action:@selector(ad) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn13];
    WADemoButtonMain* btn14 = [[WADemoButtonMain alloc]init];
    [btn14 setTitle:@"客服系统" forState:UIControlStateNormal];
    [btn14 addTarget:self action:@selector(csc) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn14];
//    WADemoButtonMain* btn15 = [[WADemoButtonMain alloc]init];
//    btn15.hidden = YES;
//    [btns addObject:btn15];
    
    WADemoButtonMain* btn10 = [[WADemoButtonMain alloc]init];
    [btn10 setTitle:@"闪退测试" forState:UIControlStateNormal];
    [btn10 addTarget:self action:@selector(crash) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn10];
    
    NSMutableArray* btnLayout = [NSMutableArray arrayWithArray:@[@2,@2,@2,@2,@2,@2,@0,@1]];

    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    CFShow((__bridge CFTypeRef)(infoDictionary));
    // app版本
    NSString *appVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    self.title = [NSString stringWithFormat:@"WADemo%@", appVersion];
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
    _loginUI = [[WADemoLoginUI alloc]initWithFrame:self.bounds];
    self.loginUI.hasBackBtn = YES;
    [vc.view addSubview:self.loginUI];
    [self.loginUI moveIn:nil];
}

//账号管理
-(void)acctManagement{
    UIViewController* vc = [WADemoUtil getCurrentVC];
    _acctMgmt = [[WADemoAccountManagement alloc]initWithFrame:self.bounds];
    self.acctMgmt.hasBackBtn = YES;
    [vc.view addSubview:self.acctMgmt];
    [self.acctMgmt moveIn:nil];
}
//应用内支付
-(void)iap{
    UIViewController* vc = [WADemoUtil getCurrentVC];
    _productList = [[WADemoIapView alloc]initWithFrame:self.bounds];
    self.productList.hasBackBtn = YES;
    [vc.view addSubview:self.productList];
    [self.productList moveIn:nil];
}
//数据收集
-(void)appTracking{
    UIViewController* vc = [WADemoUtil getCurrentVC];
    _appTrackView = [[WADemoAppTrackingView alloc]initWithFrame:self.bounds];
    self.appTrackView.hasBackBtn = YES;
    [vc.view addSubview:self.appTrackView];
    [self.appTrackView moveIn:nil];
}
//facebook分享
-(void)facebookShare{
    UIViewController* vc = [WADemoUtil getCurrentVC];
    _fbShareView = [[WADemoFBShareView alloc]initWithFrame:self.bounds];
    self.fbShareView.hasBackBtn = YES;
    [vc.view addSubview:self.fbShareView];
    [self.fbShareView moveIn:nil];
}
//facebook邀请
-(void)facebookInvite{
//    UIViewController* vc = [WADemoUtil getCurrentVC];
//    WADemoFBInviteView* fbInviteView = [[WADemoFBInviteView alloc]init];
//    fbInviteView.hasBackBtn = YES;
//    [vc.view addSubview:fbInviteView];
//    [fbInviteView moveIn];
    UIViewController* vc = [WADemoUtil getCurrentVC];
    _inviteView = [[WADemoInvite alloc]initWithFrame:self.bounds];
    self.inviteView.hasBackBtn = YES;
    [vc.view addSubview:self.inviteView];
    [self.inviteView moveIn:nil];
}

//礼物
-(void)gifting{
    UIViewController* vc = [WADemoUtil getCurrentVC];
    _giftView = [[WADemoGiftView alloc]initWithFrame:self.bounds];
    self.giftView.hasBackBtn = YES;
    [vc.view addSubview:self.giftView];
    [self.giftView moveIn:nil];
}

- (void)crash {
    
    NSArray* array = [NSArray array];
    int i = (int)array[1];
    NSLog(@"%d",i);
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms://itunes.apple.com/gb/app/yi-dong-cai-bian/id391945719?mt=8"]];
    
//    NSURL * url = [NSURL URLWithString:@"https://itunes.apple.com/cn/app/%E5%BE%AE%E4%BF%A1/id414478124?mt=8"];
//    NSURL * url = [NSURL URLWithString:@"weixin://"];
//    // 如果已经安装了这个应用,就跳转
//    if ([[UIApplication sharedApplication] canOpenURL:url]) {
//        [[UIApplication sharedApplication] openURL:url];
//    }
    
}

- (void)pay
{
    UIViewController* vc = [WADemoUtil getCurrentVC];
    _payView = [[WADemoPayView alloc]initWithFrame:self.bounds];
    self.payView.hasBackBtn = YES;
    [vc.view addSubview:self.payView];
    [self.payView moveIn:nil];
}

- (void)payProduct
{
    [self alertViewWithTitle:@"购买商品"
                     message:nil
                 placeholder:@"请输入商品ID"
                    callBack:^(NSString *text){
                        [WAPayProxy payWithProductId:text extInfo:@"" delegate:self];
                    }];
}

- (void)ad
{
    UIViewController* vc = [WADemoUtil getCurrentVC];
    _adView = [[WADemoAdView alloc]initWithFrame:self.bounds];
    self.adView.hasBackBtn = YES;
    [vc.view addSubview:self.adView];
    [self.adView moveIn:nil];
}

- (void)csc
{
//    if (! self.cscVC)
//        _cscVC = [[WADemoCscViewController alloc] init];
//
//    [self addSubview:self.cscVC.view];
//    [self.cscVC moveIn:nil];
    
    WADemoCscViewController *cscVC = [[WADemoCscViewController alloc] init];
    [[WADemoUtil getCurrentVC].navigationController pushViewController:cscVC animated:YES];
}

-(void)checkUpdate{
    UIViewController* vc = [WADemoUtil getCurrentVC];
    _hotUpdate = [[WADemoHotUpdateView alloc]initWithFrame:self.bounds];
    self.hotUpdate.hasBackBtn = YES;
    [vc.view addSubview:self.hotUpdate];
    [self.hotUpdate moveIn:nil];
}

#pragma mark 实现 WAPaymentDelegate
-(void)paymentDidCompleteWithResult:(WAIapResult*)iapResult andPlatform:(NSString*)platform{
    NSString *msg;
    if (!iapResult) {
        msg = [NSString stringWithFormat:@"%@ 购买失败!", platform];
    }else{
        if (iapResult.resultCode == 1) {
            msg = [NSString stringWithFormat:@"%@ 支付成功.", platform];
        }else if (iapResult.resultCode == 2) {
            msg = [NSString stringWithFormat:@"%@ 支付失败.", platform];
        }else if (iapResult.resultCode == 3) {
            msg = [NSString stringWithFormat:@"%@ 取消.", platform];
        }else if (iapResult.resultCode == 4) {
            msg = [NSString stringWithFormat:@"%@ 上报失败.", platform];
        }else if (iapResult.resultCode == 5) {
            msg = [NSString stringWithFormat:@"%@ 商品未消耗.", platform];
        }else if (iapResult.resultCode == 6) {
            msg = [NSString stringWithFormat:@"%@ 创建订单失败.", platform];
        }
    }
    NSLog(@"%@", msg);
    [self makeToast:msg];
}

-(void)paymentDidFailWithError:(NSError*)error andPlatform:(NSString*)platform{
    if (error) {
        NSLog(@"paymentDidFailWithError:%@",error.description);
        [self makeToast:error.description];
    }
}

- (void)alertViewWithTitle:(NSString *)title message:(NSString *)message placeholder:(NSString *)placeholder callBack:(void (^ __nullable)(NSString *text))callBack
{
    UIAlertController *alertConrl = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertConrl addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.placeholder = placeholder;
    }];
    [alertConrl addAction:[UIAlertAction actionWithTitle:@"确定"
                                                   style:UIAlertActionStyleDefault
                                                 handler:^(UIAlertAction * _Nonnull action) {
                                                     if (callBack)
                                                         callBack(alertConrl.textFields.firstObject.text);
                                                 }]];
    [alertConrl addAction:[UIAlertAction actionWithTitle:@"取消"
                                                   style:UIAlertActionStyleCancel
                                                 handler:nil]];
    [[WADemoUtil getCurrentVC] presentViewController:alertConrl animated:true completion:nil];
}

- (void)deviceOrientationDidChange
{
    [super deviceOrientationDidChange];
    
    if (self.loginUI)
        [self.loginUI deviceOrientationDidChange];
    
    if (self.acctMgmt)
        [self.acctMgmt deviceOrientationDidChange];
    
    if (self.productList)
        [self.productList deviceOrientationDidChange];
    
    if (self.appTrackView)
        [self.appTrackView deviceOrientationDidChange];
    
    if (self.fbShareView)
        [self.fbShareView deviceOrientationDidChange];
    
    if (self.inviteView)
        [self.inviteView deviceOrientationDidChange];
    
    if (self.giftView)
        [self.giftView deviceOrientationDidChange];
    
    if (self.payView)
        [self.payView deviceOrientationDidChange];
    
    if (self.hotUpdate)
        [self.hotUpdate deviceOrientationDidChange];
}

@end
