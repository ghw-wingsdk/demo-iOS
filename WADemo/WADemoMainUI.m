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
#import "WADemoUserCenterViewController.h"
#import "WADemoAccountManagement.h"
#import <WACommon/WAHelper.h>
#import "WADemoClientidSetting.h"
#import "WADemoAdMobView.h"
#import "WADemoAlertView.h"

//#import <WASdkImpl/WASdkLoginHandler.h>
@interface WADemoMainUI () <WAPaymentDelegate>

@property (nonatomic, strong) WADemoLoginUI* loginUI;
@property (nonatomic, strong) WADemoIapView* productList;
@property (nonatomic, strong) WADemoAppTrackingView* appTrackView;
@property (nonatomic, strong) WADemoFBShareView* fbShareView;
@property (nonatomic, strong) WADemoInvite* inviteView;
@property (nonatomic, strong) WADemoGiftView* giftView;
@property (nonatomic, strong) WADemoPayView* payView;
@property (nonatomic, strong) WADemoHotUpdateView* hotUpdate;
@property (nonatomic, strong) WADemoAdView* adView;
@property (nonatomic, strong) WADemoAccountManagement* accountView;
@property (nonatomic, strong) WADemoAccountManagement* usercenterView;
@property (nonatomic, strong) WADemoAdMobView* adMobView;


//@property (nonatomic, strong) WADemoCscViewController *cscVC;

@end

@implementation WADemoMainUI

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        [self initBtnAndLayout];
        


        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [WAUserProxy checkConsentPreferencesWithCompletion:^(NSError *error, BOOL isShow) {
             
                    dispatch_async(dispatch_get_main_queue(), ^{
                        for (UIButton *button in self.btns) {
                            if (button.tag == 300) {
                                NSString *title = [NSString stringWithFormat:@"Consent弹窗(%@)", isShow ? @"开启" : @"关闭"];
                                [button setTitle:title forState:UIControlStateNormal];
                            }
                        }
                    });
             
            }];
            
            
            BOOL isOpenDeleteAccount =[WAUserProxy isOpenDeleteAccount ];

            dispatch_async(dispatch_get_main_queue(), ^{
                for (UIButton *button in self.btns) {
                    if (button.tag == 400) {
                        NSString *title = [NSString stringWithFormat:@"账号删除UI(%@)", isOpenDeleteAccount ? @"开启" : @"关闭"];
                        [button setTitle:title forState:UIControlStateNormal];
                    }
                }
            });
        });

        
        
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
//    WADemoButtonMain* btn9 = [[WADemoButtonMain alloc]init];
//    [btn9 setTitle:@"礼物" forState:UIControlStateNormal];
//    [btn9 addTarget:self action:@selector(gifting) forControlEvents:UIControlEventTouchUpInside];
//    [btns addObject:btn9];
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
    WADemoButtonMain* btn15 = [[WADemoButtonMain alloc]init];
    [btn15 setTitle:@"隐私政策" forState:UIControlStateNormal];
    [btn15 addTarget:self action:@selector(privacy) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn15];
    WADemoButtonMain* btn16 = [[WADemoButtonMain alloc]init];
    [btn16 setTitle:@"用户中心" forState:UIControlStateNormal];
    [btn16 addTarget:self action:@selector(userCenter) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn16];
    
    WADemoButtonMain* btn17 = [[WADemoButtonMain alloc]init];
    [btn17 setTitle:@"客服中心" forState:UIControlStateNormal];
    [btn17 addTarget:self action:@selector(customerCenter) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn17];
    
    WADemoButtonMain* btn10 = [[WADemoButtonMain alloc]init];
    [btn10 setTitle:@"闪退测试" forState:UIControlStateNormal];
    [btn10 addTarget:self action:@selector(crash) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn10];
    
    
    WADemoButtonMain* btn18 = [[WADemoButtonMain alloc]init];
    [btn18 setTitle:@"调起评分界面" forState:UIControlStateNormal];
    [btn18 addTarget:self action:@selector(oepnReview) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn18];
    
    
    btn18 = [[WADemoButtonMain alloc]init];
    [btn18 setTitle:@"账号删除UI" forState:UIControlStateNormal];
    [btn18 addTarget:self action:@selector(openDeleteUI) forControlEvents:UIControlEventTouchUpInside];
    btn18.tag= 400;
    [btns addObject:btn18];
    

    
//    btn18 = [[WADemoButtonMain alloc]init];
//    [btn18 setTitle:@"事件测试" forState:UIControlStateNormal];
//    [btn18 addTarget:self action:@selector(trackTest) forControlEvents:UIControlEventTouchUpInside];
//    [btns addObject:btn18];
    
    btn18 = [[WADemoButtonMain alloc]init];
    [btn18 setTitle:@"游戏评分" forState:UIControlStateNormal];
    [btn18 addTarget:self action:@selector(openGameReview) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn18];
    
    
    btn18 = [[WADemoButtonMain alloc]init];
    [btn18 setTitle:@"设置clientid" forState:UIControlStateNormal];
    [btn18 addTarget:self action:@selector(elseTest) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn18];
    

    
    
    
    btn18 = [[WADemoButtonMain alloc]init];
    [btn18 setTitle:@"AdMob" forState:UIControlStateNormal];
    [btn18 addTarget:self action:@selector(showAdmob) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn18];
    
    
    
    btn18 = [[WADemoButtonMain alloc]init];
    [btn18 setTitle:@"Consent弹窗" forState:UIControlStateNormal];
    [btn18 addTarget:self action:@selector(showConsentPreferences) forControlEvents:UIControlEventTouchUpInside];
    btn18.tag=300;
    [btns addObject:btn18];
    
    
    
    
    NSMutableArray* btnLayout = [NSMutableArray arrayWithArray:@[@2,@2,@2,@2,@2,@2,@2,@0,@2,@2,@2,@2,@2,@2]];

    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app版本
    NSString *appVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    self.title = [NSString stringWithFormat:@"WADemo%@", appVersion];
    self.btnLayout = btnLayout;
    self.btns = btns;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
      
        
//        UIViewController* vc = [WADemoUtil getCurrentVC];
//        [WAUserProxy bindingAccountWithPlatform:WA_PLATFORM_WINGA extInfo:nil delegate:self];
//        [WAUserProxy bindingAccountWithPlatform:WA_PLATFORM_WINGA extInfo:@"" delegate:self];
//        [WAUserProxy loginWithPlatform:WA_PLATFORM_GHG extInfo:nil delegate:self];
//        [WAUserProxy openAccountManager:self];


    });
    
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
    _accountView = [[WADemoAccountManagement alloc]initWithFrame:self.bounds];
    self.accountView.hasBackBtn = YES;
    [vc.view addSubview:self.accountView];
    [self.accountView moveIn:nil];

    
    
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

//打开评分界面
- (void)oepnReview {
    
    [WAUserProxy openReview];
}


//闪退
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
    
//    if([SKStoreReviewController respondsToSelector:@selector(requestReview)]) {// iOS 10.3 以上支持
//        //防止键盘遮挡
//        [[UIApplication sharedApplication].keyWindow endEditing:YES];
//        [SKStoreReviewController requestReview];
//    }
//
    
    
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
//    [[WADemoUtil getCurrentVC].navigationController pushViewController:cscVC animated:YES];
    
    [[WADemoUtil getCurrentVC] presentViewController:cscVC animated:YES completion:nil];
}

- (void)privacy
{
    if (![WACoreProxy getPrivacyUrl] || [@"" isEqualToString:[WACoreProxy getPrivacyUrl]]) {
        [self makeToast:@"没有配置隐私政策"];
        return;
    }
    [WACoreProxy showPrivacyUI:^(){
        [self makeToast:@"已关闭隐私政策"];
    }];
}


- (void)userCenter
{
    UIViewController* vc = [WADemoUtil getCurrentVC];
    _usercenterView = [[WADemoUserCenterViewController alloc]initWithFrame:self.bounds];
    self.usercenterView.hasBackBtn = YES;
    [vc.view addSubview:self.usercenterView];
    [self.usercenterView moveIn:nil];

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
    }
    NSLog(@"%@", msg);
    [self makeToast:[NSString stringWithFormat:@"%@ 支付成功.", platform]];
}

-(void)paymentDidFailWithError:(NSError*)error andPlatform:(NSString*)platform{
    
    NSString * msg=@"支付失败";
    if (error.code == 2) {
        msg = [NSString stringWithFormat:@"%@ 支付失败.", platform];
    }else if (error.code == 3) {
        msg = [NSString stringWithFormat:@"%@ 取消.", platform];
    }else if (error.code == 4) {
        msg = [NSString stringWithFormat:@"%@ 上报失败.", platform];
    }else if (error.code == 5) {
        msg = [NSString stringWithFormat:@"%@ 商品未消耗.", platform];
    }else if (error.code == 6) {
        msg = [NSString stringWithFormat:@"%@ 创建订单失败.", platform];
    }
    
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
    if(self.accountView)
       [self.accountView deviceOrientationDidChange];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}

- (void)openDeleteUI{
    
    [WAUserProxy requestDeleteAccoutUI:^(NSError *error, NSUInteger status) {
        if(error){
            
            [self makeToast:error.userInfo[WAErrorDeveloperMessageKey]];

            return;
        }
        
        if(status==WA_ACCOUNT_DELETE_UI_SUCCESS ){
            
            [self makeToast:@"注销成功，cp需要退出到登录页"];

        }
    }];
    
    
}


- (void)tempTest{
    

    NSString *testClientid = [WAHelper getGroupTestSdkClientid];
    WALog(@"group.client=====%@",testClientid);
    
    
}

- (void)openGameReview{
    [WAUserProxy openGameReview:^(OpenGameReviewState status) {
        switch (status) {
            case OpenGameReviewStateError:
                [self makeToast:@"打开游戏评价失败,请检测游戏评价开关是否开启"];

                break;
            case OpenGameReviewStateReject:
                [self makeToast:@"游戏评价结果：不，谢谢！"];

                break;
                break;
            case OpenGameReviewStateOpenAiHelp:
                [self makeToast:@"游戏评价结果：我要提意见"];

                break;
                break;
            case OpenGameReviewStateOpentReview:
                [self makeToast:@"游戏评价结果：提交好评(无法获取用户是否点击评分以及具体的评分分数)"];

                break;
            default:
                break;
        }
        
    }];
    
}


- (void)trackTest{
    
    
 



}

-(void)elseTest{
    
    
    UIViewController* vc = [WADemoUtil getCurrentVC];
    WADemoClientidSetting * clientidview = [[WADemoClientidSetting alloc]initWithFrame:self.bounds];
    clientidview.hasBackBtn = YES;
    [vc.view addSubview:clientidview];
    [clientidview moveIn:nil];
    
    

    
    
}
- (void)showConsentPreferences{
    
    [WAUserProxy showConsentPreferences];
    
//    NSMutableDictionary* mParamValueDict = [NSMutableDictionary dictionary];
//    [mParamValueDict setObject:@"0" forKey:@"status"];
//    WAEvent* event = [[WAEvent alloc] init];
//    
//    event.defaultParamValues = mParamValueDict;
//    event.defaultEventName = WAEventPrivacyClick;
//
//    event.channelSwitcherDict = @{WA_PLATFORM_APPSFLYER:@YES,WA_PLATFORM_CHARTBOOST:@YES,WA_PLATFORM_FACEBOOK:@YES,WA_PLATFORM_WINGA:@YES,WA_PLATFORM_FIREBASE:@YES};
//    [event trackEvent];

    

}
- (void)showAdmob{
    
    UIViewController* vc = [WADemoUtil getCurrentVC];
    _adMobView = [[WADemoAdMobView alloc]initWithFrame:self.bounds];
    self.adMobView.hasBackBtn = YES;
    [vc.view addSubview:self.adMobView];
    [self.adMobView moveIn:nil];
    
//    WAAdMobViewController * adMobViewController =[[WAAdMobViewController alloc] init];
//    [[WADemoUtil getCurrentVC] presentViewController:adMobViewController animated:YES completion:^{
//        
//    }];
    
}

// 客服中心
- (void)customerCenter{

    
    [WAUserProxy showCustomerCenterWithCompletion:^(WACustomerResult *customerResult) {
        
        if (customerResult.error) {
            
            [self makeToast:customerResult.error.userInfo[WAErrorDeveloperMessageKey]];


            return;
        }
        
        switch (customerResult.operationType) {
                //帐号删除回调
            case WACustomerOperationTypeDeleteAccount:
            {
                if (customerResult.deleteStatus==WA_ACCOUNT_DELETE_UI_SUCCESS) {
                    [self makeToast:@"注销成功，cp需要退出到登录页"];

                }
                
            }
                
                break;
                //帐号管理中的新建帐号回调
            case WACustomerOperationTypeNewAccount:
            {
                NSLog(@"WACustomerOperationTypeNewAccount===");

                WALoginResult*result = customerResult.loginResult;
                WADemoAlertView* alert = [[WADemoAlertView alloc]initWithTitle:@"客服中心新建成功" message:[NSString stringWithFormat:@"platform:%@\npUserId:%@\npToken:%@\nuserId:%@\ntoken:%@",result.platform,result.pUserId,result.pToken,result.userId,result.token] cancelButtonTitle:@"Sure" otherButtonTitles:nil block:nil];
                [alert show];
            }
                
                break;
                //帐号管理中的切换帐号回调
            case WACustomerOperationTypeSwitchAccount:
            {
                NSLog(@"WACustomerOperationTypeSwitchAccount===");

                NSError * error =customerResult.error;
                WALoginResult*result = customerResult.loginResult;

                WADemoAlertView* alert = [[WADemoAlertView alloc]initWithTitle:@"客服中心切换成功" message:[NSString stringWithFormat:@"userId:%@\ntoken:%@\nplatform:%@\npUserId:%@\npToken:%@\nextends:%@ 是否为游客登录:%d",result.userId,result.token,result.platform,result.pUserId,result.pToken,result.extends,result.isGuestAccount] cancelButtonTitle:@"Sure" otherButtonTitles:nil block:nil];
                [alert show];
                
         
            }
                
                break;
                //帐号管理中的绑定帐号回调
            case WACustomerOperationTypeBindAccount:
            {
                NSError * error =customerResult.error;
                WABindingResult*result = customerResult.bindingResult;

                NSString * message =[NSString stringWithFormat:@"客服中心绑定%@成功\n,userId:%@\ntoken:%@\n mobile:%@\n email:%@\n ",result.platform,result.userId,result.accessToken,result.mobile,result.email];
                
                WADemoAlertView* alert = [[WADemoAlertView alloc]initWithTitle:@"绑定成功" message:message cancelButtonTitle:@"Sure" otherButtonTitles:nil block:nil];
                [alert show];
       
                
                
                
            }
                
                break;
                
                

                
            default:
                break;
        }

        
    }];
}


@end

