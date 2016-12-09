//
//  WAAppTracking.m
//  WASDKDemo
//
//  Created by wuyx on 16/2/25.
//  Copyright © 2016年 WA. All rights reserved.
//

#import "WADemoAppTrackingView.h"
#import "WADemoUtil.h"
#import "WADemoButtonMain.h"
#import "WADemoPostEventView.h"
@implementation WADemoAppTrackingView

-(instancetype)init{
    self = [super init];
    if (self) {
        //添加界面旋转通知
        [WADemoUtil addOrientationNotification:self selector:@selector(handleDeviceOrientationDidChange:) object:nil];
        [self initBtnAndLayout];
    }
    return self;
}

-(void)handleDeviceOrientationDidChange:(NSNotification*)noti{
    [self setNeedsLayout];
}

-(void)initBtnAndLayout{
    NSMutableArray* btns = [NSMutableArray array];
//    WADemoButtonMain* btn1 = [[WADemoButtonMain alloc]init];
//    [btn1 setTitle:@"register" forState:UIControlStateNormal];
//    [btn1 addTarget:self action:@selector(register_) forControlEvents:UIControlEventTouchUpInside];
//    [btns addObject:btn1];
    WADemoButtonMain* btn2 = [[WADemoButtonMain alloc]init];
    [btn2 setTitle:@"login" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn2];
    WADemoButtonMain* btn3 = [[WADemoButtonMain alloc]init];
    [btn3 setTitle:@"initiatedPayment" forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(initiatedPayment) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn3];
    WADemoButtonMain* btn23 = [[WADemoButtonMain alloc]init];
    [btn23 setTitle:@"payment" forState:UIControlStateNormal];
    [btn23 addTarget:self action:@selector(payment) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn23];
    WADemoButtonMain* btn4 = [[WADemoButtonMain alloc]init];
    [btn4 setTitle:@"initiatedPurchase" forState:UIControlStateNormal];
    [btn4 addTarget:self action:@selector(initiatedPurchase) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn4];
    
    WADemoButtonMain* btn24 = [[WADemoButtonMain alloc]init];
    [btn24 setTitle:@"purchase" forState:UIControlStateNormal];
    [btn24 addTarget:self action:@selector(purchase) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn24];
    
    WADemoButtonMain* btn5 = [[WADemoButtonMain alloc]init];
    [btn5 setTitle:@"levelAchieve" forState:UIControlStateNormal];
    [btn5 addTarget:self action:@selector(levelAchieve) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn5];
//    WADemoButtonMain* btn6 = [[WADemoButtonMain alloc]init];
//    [btn6 setTitle:@"addToCart" forState:UIControlStateNormal];
//    [btn6 addTarget:self action:@selector(addToCart) forControlEvents:UIControlEventTouchUpInside];
//    [btns addObject:btn6];
//    WADemoButtonMain* btn7 = [[WADemoButtonMain alloc]init];
//    [btn7 setTitle:@"addToWishlist" forState:UIControlStateNormal];
//    [btn7 addTarget:self action:@selector(addToWishlist) forControlEvents:UIControlEventTouchUpInside];
//    [btns addObject:btn7];
//    WADemoButtonMain* btn8 = [[WADemoButtonMain alloc]init];
//    [btn8 setTitle:@"search" forState:UIControlStateNormal];
//    [btn8 addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
//    [btns addObject:btn8];
//    WADemoButtonMain* btn9 = [[WADemoButtonMain alloc]init];
//    [btn9 setTitle:@"spentCredits" forState:UIControlStateNormal];
//    [btn9 addTarget:self action:@selector(spentCredits) forControlEvents:UIControlEventTouchUpInside];
//    [btns addObject:btn9];
//    WADemoButtonMain* btn10 = [[WADemoButtonMain alloc]init];
//    [btn10 setTitle:@"achievementUnlocked" forState:UIControlStateNormal];
//    [btn10 addTarget:self action:@selector(achievementUnlocked) forControlEvents:UIControlEventTouchUpInside];
//    [btns addObject:btn10];
//    WADemoButtonMain* btn11 = [[WADemoButtonMain alloc]init];
//    [btn11 setTitle:@"contentView" forState:UIControlStateNormal];
//    [btn11 addTarget:self action:@selector(contentView) forControlEvents:UIControlEventTouchUpInside];
//    [btns addObject:btn11];
    WADemoButtonMain* btn12 = [[WADemoButtonMain alloc]init];
    [btn12 setTitle:@"share" forState:UIControlStateNormal];
    [btn12 addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn12];
    WADemoButtonMain* btn13 = [[WADemoButtonMain alloc]init];
    [btn13 setTitle:@"invite" forState:UIControlStateNormal];
    [btn13 addTarget:self action:@selector(invite) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn13];
//    WADemoButtonMain* btn14 = [[WADemoButtonMain alloc]init];
//    [btn14 setTitle:@"reEngage" forState:UIControlStateNormal];
//    [btn14 addTarget:self action:@selector(reEngage) forControlEvents:UIControlEventTouchUpInside];
//    [btns addObject:btn14];
    WADemoButtonMain* btn15 = [[WADemoButtonMain alloc]init];
    [btn15 setTitle:@"update" forState:UIControlStateNormal];
    [btn15 addTarget:self action:@selector(update) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn15];
    WADemoButtonMain* btn16 = [[WADemoButtonMain alloc]init];
    [btn16 setTitle:@"openedFromPushNotification" forState:UIControlStateNormal];
    [btn16 addTarget:self action:@selector(openedFromPushNotification) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn16];
    WADemoButtonMain* btn17 = [[WADemoButtonMain alloc]init];
    [btn17 setTitle:@"userCreate" forState:UIControlStateNormal];
    [btn17 addTarget:self action:@selector(userCreate) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn17];
    WADemoButtonMain* btn18 = [[WADemoButtonMain alloc]init];
    [btn18 setTitle:@"userInfoUpdate" forState:UIControlStateNormal];
    [btn18 addTarget:self action:@selector(userInfoUpdate) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn18];
    
    WADemoButtonMain* btn19 = [[WADemoButtonMain alloc]init];
    [btn19 setTitle:@"taskUpdate" forState:UIControlStateNormal];
    [btn19 addTarget:self action:@selector(taskUpdate) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn19];
    
    WADemoButtonMain* btn20 = [[WADemoButtonMain alloc]init];
    [btn20 setTitle:@"goldUpdate" forState:UIControlStateNormal];
    [btn20 addTarget:self action:@selector(goldUpdate) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn20];
    
    WADemoButtonMain* btn21 = [[WADemoButtonMain alloc]init];
    [btn21 setTitle:@"userImport" forState:UIControlStateNormal];
    [btn21 addTarget:self action:@selector(userImport) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn21];
    WADemoButtonMain* btn22 = [[WADemoButtonMain alloc]init];
    [btn22 setTitle:@"custom" forState:UIControlStateNormal];
    [btn22 addTarget:self action:@selector(custom) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn22];
    NSMutableArray* btnLayout = [NSMutableArray arrayWithArray:@[@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1,@1]];
    self.title = @"数据收集";
    self.btnLayout = btnLayout;
    self.btns = btns;
}



- (void)register_ {
    
    WADemoPostEventView* view = [[WADemoPostEventView alloc]initWithNaviHeight:self.naviHeight eventName:WAEventCompleteRegistration];
    [self addSubview:view];
    
}

- (void)login {

    WADemoPostEventView* view = [[WADemoPostEventView alloc]initWithNaviHeight:self.naviHeight eventName:WAEventLogin];
    [self addSubview:view];
}

- (void)initiatedPayment {
    WADemoPostEventView* view = [[WADemoPostEventView alloc]initWithNaviHeight:self.naviHeight eventName:WAEventInitiatedPayment];
    [self addSubview:view];
}

- (void)payment {
    WADemoPostEventView* view = [[WADemoPostEventView alloc]initWithNaviHeight:self.naviHeight eventName:WAEventPayment];
    [self addSubview:view];
}
- (void)initiatedPurchase {
    
    WADemoPostEventView* view = [[WADemoPostEventView alloc]initWithNaviHeight:self.naviHeight eventName:WAEventInitiatedPurchase];
    [self addSubview:view];
}

- (void)purchase {
    
    WADemoPostEventView* view = [[WADemoPostEventView alloc]initWithNaviHeight:self.naviHeight eventName:WAEventPurchase];
    [self addSubview:view];
}

- (void)heartbeat {
    
}

- (void)levelAchieve {
    WADemoPostEventView* view = [[WADemoPostEventView alloc]initWithNaviHeight:self.naviHeight eventName:WAEventLevelAchieved];
    [self addSubview:view];
    
}
- (void)addToCart {
    
    WADemoPostEventView* view = [[WADemoPostEventView alloc]initWithNaviHeight:self.naviHeight eventName:WAEventAddToCart];
    [self addSubview:view];
}

- (void)addToWishlist {
    
    WADemoPostEventView* view = [[WADemoPostEventView alloc]initWithNaviHeight:self.naviHeight eventName:WAEventAddToWishlist];
    [self addSubview:view];
}
- (void)search {
    
    WADemoPostEventView* view = [[WADemoPostEventView alloc]initWithNaviHeight:self.naviHeight eventName:WAEventSearch];
    [self addSubview:view];
}
- (void)spentCredits {
    
    WADemoPostEventView* view = [[WADemoPostEventView alloc]initWithNaviHeight:self.naviHeight eventName:WAEventSpentCredits];
    [self addSubview:view];
}
- (void)achievementUnlocked {
    
    WADemoPostEventView* view = [[WADemoPostEventView alloc]initWithNaviHeight:self.naviHeight eventName:WAEventAchievementUnlocked];
    [self addSubview:view];
}
- (void)contentView {
    
    WADemoPostEventView* view = [[WADemoPostEventView alloc]initWithNaviHeight:self.naviHeight eventName:WAEventContentView];
    [self addSubview:view];
}
- (void)share {
    
    WADemoPostEventView* view = [[WADemoPostEventView alloc]initWithNaviHeight:self.naviHeight eventName:WAEventShare];
    [self addSubview:view];
}
- (void)invite {
    
    WADemoPostEventView* view = [[WADemoPostEventView alloc]initWithNaviHeight:self.naviHeight eventName:WAEventInvite];
    [self addSubview:view];
}
- (void)reEngage {
    
    WADemoPostEventView* view = [[WADemoPostEventView alloc]initWithNaviHeight:self.naviHeight eventName:WAEventReEngage];
    [self addSubview:view];
    
}
- (void)update {
    
    WADemoPostEventView* view = [[WADemoPostEventView alloc]initWithNaviHeight:self.naviHeight eventName:WAEventUpdate];
    [self addSubview:view];
}

- (void)openedFromPushNotification {
    
    WADemoPostEventView* view = [[WADemoPostEventView alloc]initWithNaviHeight:self.naviHeight eventName:WAEventOpenedFromPushNotification];
    [self addSubview:view];
}



- (void)userCreate {
    
    WADemoPostEventView* view = [[WADemoPostEventView alloc]initWithNaviHeight:self.naviHeight eventName:WAEventUserCreate];
    [self addSubview:view];
}
//- (void)userInfoInit {
//
//    NSDictionary *params = @{
//                             WAEventParameterNameNickName:@"nickName",
//                             WAEventParameterNameVip:@10,
//                             WAEventParameterNameStatus:@1,
//                             WAEventParameterNameBindGameGold:@100,
//                             WAEventParameterNameGameGold:@1000,
//                             WAEventParameterNameLevel:@15,
//                             WAEventParameterNameFighting:@1000,
//                             WAEventParameterNameRoleType:@"roleType"
//                             };
//    [WATrackProxy trackWithEventName:WAEventUserInfoInit valueToSum:0 params:params];
//
//}

- (void)userInfoUpdate {
    
    WADemoPostEventView* view = [[WADemoPostEventView alloc]initWithNaviHeight:self.naviHeight eventName:WAEventUserInfoUpdate];
    [self addSubview:view];
}

- (void)taskUpdate {
    
    WADemoPostEventView* view = [[WADemoPostEventView alloc]initWithNaviHeight:self.naviHeight eventName:WAEventTaskUpdate];
    [self addSubview:view];
}

- (void)goldUpdate {
    
    WADemoPostEventView* view = [[WADemoPostEventView alloc]initWithNaviHeight:self.naviHeight eventName:WAEventGoldUpdate];
    [self addSubview:view];
}
- (void)userImport {
    WADemoPostEventView* view = [[WADemoPostEventView alloc]initWithNaviHeight:self.naviHeight eventName:WAEventUserImport];
    [self addSubview:view];

}

- (void)custom {
    WADemoPostEventView* view = [[WADemoPostEventView alloc]initWithNaviHeight:self.naviHeight eventName:@"customEvent"];
    [self addSubview:view];
}

-(void)dealloc{
    [WADemoUtil removeOrientationNotification:self object:nil];
}

@end
