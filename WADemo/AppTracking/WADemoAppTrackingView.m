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

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initBtnAndLayout];
    }
    return self;
}

-(void)initBtnAndLayout{
    NSMutableArray* btns = [NSMutableArray array];

    
    
    WADemoButtonMain* btn = [[WADemoButtonMain alloc]init];
    [btn setTitle:@"进服" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(userImport) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn];
    
    
    WADemoButtonMain* btn17 = [[WADemoButtonMain alloc]init];
    [btn17 setTitle:@"创角" forState:UIControlStateNormal];
    [btn17 addTarget:self action:@selector(userCreate) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn17];
    
    
    
    WADemoButtonMain* btn2 = [[WADemoButtonMain alloc]init];
    [btn2 setTitle:@"点击购买" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(initiatedPurchase) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn2];

    WADemoButtonMain* btn24 = [[WADemoButtonMain alloc]init];
    [btn24 setTitle:@"购买完成" forState:UIControlStateNormal];
    [btn24 addTarget:self action:@selector(purchase) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn24];
    
    WADemoButtonMain* btn5 = [[WADemoButtonMain alloc]init];
    [btn5 setTitle:@"等级事件" forState:UIControlStateNormal];
    [btn5 addTarget:self action:@selector(levelAchieve) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn5];


    WADemoButtonMain* btn18 = [[WADemoButtonMain alloc]init];
    [btn18 setTitle:@"更新用户信息" forState:UIControlStateNormal];
    [btn18 addTarget:self action:@selector(userInfoUpdate) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn18];
    
    WADemoButtonMain* btn19 = [[WADemoButtonMain alloc]init];
    [btn19 setTitle:@"关键等级" forState:UIControlStateNormal];
    [btn19 addTarget:self action:@selector(self_lv) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn19];
    
    WADemoButtonMain* btn20 = [[WADemoButtonMain alloc]init];
    [btn20 setTitle:@"完成新手任务" forState:UIControlStateNormal];
    [btn20 addTarget:self action:@selector(tutorialCompleted) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn20];

    WADemoButtonMain* btn22 = [[WADemoButtonMain alloc]init];
    [btn22 setTitle:@"custom" forState:UIControlStateNormal];
    [btn22 addTarget:self action:@selector(custom) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn22];
    NSMutableArray* btnLayout = [NSMutableArray arrayWithArray:@[@2,@2,@2,@2,@1]];
    self.title = @"数据收集";
    self.btnLayout = btnLayout;
    self.btns = btns;
}


- (void)tutorialCompleted{
    WATutorialCompletedEvent *event =[[WATutorialCompletedEvent alloc] init];
    [event trackEvent];

    
}
//关键等级时调用
- (void)self_lv{
    int level = 20;
    WALvXEvent * event =[[WALvXEvent alloc] initWithLevel:level];
    [event trackEvent];

    
}
- (void)initiatedPurchase {

    // sdk4.6.0 新增
    WAInitiatedPurchaseEvent * purchseEvent =[[WAInitiatedPurchaseEvent alloc] init];
    [purchseEvent trackEvent];

    
    
    
    /*
    WAEvent* event = [[WAEvent alloc]init];
    event.defaultEventName =WAEventInitiatedPurchase;
    [event trackEvent];
    */
    
    

}

- (void)purchase {

    WAPurchaseEvent * event =[[WAPurchaseEvent alloc] initWithItemName:@"钻石001" itemAmount:1 price:1.99];
    [event trackEvent];


}

- (void)levelAchieve {
    
    int currentLevel = 4;
    
    
    NSDictionary*optionalParameterDic = @{
          /*可选*/
          WAEventParameterNameScore:@10,
          WAEventParameterNameFighting:@600,
      };
    
    
    WALevelAchievedEvent * event =[[WALevelAchievedEvent alloc] initWithCurrentLevel:currentLevel optionalParameter:optionalParameterDic];
    [event trackEvent];

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
    
    NSString * serverId= @"1110";
    NSString * gameUserId= @"1199110";
    NSString * nickname= @"昵称";
    
    NSTimeInterval interval = [[NSDate date] timeIntervalSince1970] * 1000;
    long longInterval = (long)interval;
    
    
    NSDictionary *optionalParameterDic = @{
            /*可选*/
            WAEventParameterNameVip:@10,                 //等级
            WAEventParameterNameRoleType:@"角色类型",     //角色类型
            WAEventParameterNameGender:@1,               //性别
            WAEventParameterNameStatus:@1,               //状态标识 -1锁定。 1未锁定
            WAEventParameterNameBindGameGold:@110,       //绑定钻石
            WAEventParameterNameGameGold:@100,           //用户钻石数
            WAEventParameterNameFighting:@100,           //战斗力
        };
    
    
    WAUserCreateEvent * event =[[WAUserCreateEvent alloc] initWithServerId:serverId gameUserId:gameUserId nickname:nickname registerTime:longInterval optionalParameter:optionalParameterDic];
    [event trackEvent];
    
}


- (void)userInfoUpdate {
    NSString * nickname= @"昵称";

    NSDictionary *optionalParameterDic = @{

        /*可选*/
        WAEventParameterNameRoleType:@"角色类型",     //角色类型
        WAEventParameterNameVip:@10,                 //等级
        WAEventParameterNameStatus:@1,               //状态标识 -1锁定。 1未锁定

        };
    WAUserInfoUpdateEvent* event =[[WAUserInfoUpdateEvent alloc] initWithNickname:nickname optionalParameter:optionalParameterDic];
    [event trackEvent];

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
    NSString * serverId= @"1110";
    NSString * gameUserId= @"1199110";
    NSString * nickname= @"昵称";
    int level =3;
    BOOL isFristEnter =YES;//是否第一次进服

    WAUserImportEvent * event =[[WAUserImportEvent alloc] initWithServerId:serverId gameUserId:gameUserId nickname:nickname level:level isFirstEnter:isFristEnter];
    [event trackEvent];

}

- (void)custom {
    
    WAEvent* event = [[WAEvent alloc]init];
    event.defaultEventName =@"custom_event_name";
    event.defaultValue = 1;
    [event trackEvent];
}

- (void)deviceOrientationDidChange
{
    [super deviceOrientationDidChange];
    if ([self.subviews.lastObject isKindOfClass:[WADemoPostEventView class]])
    {
        WADemoPostEventView* viewCurr = self.subviews.lastObject;
        [viewCurr deviceOrientationDidChange];
    }
}

@end

