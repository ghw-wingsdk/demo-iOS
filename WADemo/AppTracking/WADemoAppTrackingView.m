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
#import <Toast/Toast.h>

@interface WADemoAppTrackingView ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField * gameUseridtextField;
@property (nonatomic, strong) UITextField * serverIdtextField;
@property (nonatomic, strong) UITextField * leveltextField; //进服级别


@end


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

    
    self.gameUseridtextField = [[UITextField alloc] init];
    self.gameUseridtextField.text=@"gameuserid001";
    self.gameUseridtextField.returnKeyType=UIReturnKeyDone;
    self.gameUseridtextField.delegate=self;
    self.gameUseridtextField.tag = 1;
    [btns addObject:self.gameUseridtextField];
    
    btn = [[WADemoButtonMain alloc]init];
    [btn setTitle:@"设置角色id" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(startSetGameUserId) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn];
    
    
    
    
    self.serverIdtextField = [[UITextField alloc] init];
    self.serverIdtextField.text=@"serverid_001";
    self.serverIdtextField.returnKeyType=UIReturnKeyDone;
    self.serverIdtextField.delegate=self;
    self.serverIdtextField.tag = 2;
    [btns addObject:self.serverIdtextField];
    
    btn = [[WADemoButtonMain alloc]init];
    [btn setTitle:@"设置serverid" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(startSetServerId) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn];
    
    
    
    self.leveltextField = [[UITextField alloc] init];
    self.leveltextField.text=@"0";
    self.leveltextField.returnKeyType=UIReturnKeyDone;
    self.leveltextField.delegate=self;
    self.leveltextField.placeholder = @"进服等级";
    self.leveltextField.keyboardType= UIKeyboardTypePhonePad;
    self.leveltextField.tag = 3;
    [btns addObject:self.leveltextField];
    
    
    
    btn = [[WADemoButtonMain alloc]init];
    [btn setTitle:@"进服V1" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(userImport1) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn];
    
    
    btn = [[WADemoButtonMain alloc]init];
    [btn setTitle:@"进服V2" forState:UIControlStateNormal];
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
    [btn5 setTitle:@"等级事件step=1" forState:UIControlStateNormal];
    [btn5 addTarget:self action:@selector(levelAchieve1) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn5];

    
    btn5 = [[WADemoButtonMain alloc]init];
    [btn5 setTitle:@"等级事件step=5" forState:UIControlStateNormal];
    [btn5 addTarget:self action:@selector(levelAchieve2) forControlEvents:UIControlEventTouchUpInside];
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
    
    
    btn22 = [[WADemoButtonMain alloc]init];
   [btn22 setTitle:@"清理首次进服缓存" forState:UIControlStateNormal];
   [btn22 addTarget:self action:@selector(clearCaches) forControlEvents:UIControlEventTouchUpInside];
   [btns addObject:btn22];
    
    NSMutableArray* btnLayout = [NSMutableArray arrayWithArray:@[@2,@2,@2,@2,@2,@2,@2,@2,@2]];
    self.title = @"数据收集";
    self.btnLayout = btnLayout;
    self.btns = btns;
    
    
    
}

- (void)clearCaches{
    NSUserDefaults *setting = [NSUserDefaults standardUserDefaults];

    // 获取所有的键（NSUserDefaults 内部并没有直接提供获取所有键的 API，但可以通过运行时获取）
    NSDictionary *allSettings = [setting dictionaryRepresentation];

    // 遍历所有存储的键
    for (NSString *key in allSettings) {
        // 判断 key 是否以 "isFirstEnter" 前缀开头
        if ([key hasPrefix:@"isFirstEnter"]) {
            // 删除这个键
            NSLog(@"缓存key==%@",key);
            [setting removeObjectForKey:key];
        }
    }

    // 同步保存
    [setting synchronize];
}
- (void)tutorialCompleted{
    WATutorialCompletedEvent *event =[[WATutorialCompletedEvent alloc] init];
    [event trackEvent];

    
}
//关键等级时调用
- (void)self_lv{
    [self dismissAllKeyboards];

    int level = 20;
    WALvXEvent * event =[[WALvXEvent alloc] initWithLevel:level];
    [event trackEvent];

    
}
- (void)initiatedPurchase {

    // sdk4.5.0 新增
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
    [self dismissAllKeyboards];

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
    [self dismissAllKeyboards];

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
int level =0;


- (void)startSetGameUserId{
    
    [self dismissAllKeyboards];
    [WACoreProxy setGameUserId:self.gameUseridtextField.text];
    
}

- (void)startSetServerId{
    [self dismissAllKeyboards];

    [WACoreProxy setGameUserId:self.serverIdtextField.text];
    
}


- (void)userImport1{
    
    NSString * serverId=self.serverIdtextField.text;
    NSString * gameUserId= self.gameUseridtextField.text;
    NSString * nickname= @"昵称";
    
    WAUserImportEvent * event =[[WAUserImportEvent alloc] initWithServerId:serverId gameUserId:gameUserId nickname:nickname level:[self.leveltextField.text intValue] isFirstEnter:YES];
    [event trackEvent];
}

- (void)userImport {
    [self dismissAllKeyboards];

    level =[self.leveltextField.text intValue];
    NSString * serverId=self.serverIdtextField.text;
    NSString * gameUserId= self.gameUseridtextField.text;
    NSString * nickname= @"昵称";

    WAUserImportEventV2 * event =[[WAUserImportEventV2 alloc] initWithServerId:serverId gameUserId:gameUserId nickname:nickname level:level ];
    [event trackEvent];

}


- (void)levelAchieve1 {
    [self dismissAllKeyboards];
    level=1+level;
    [self makeToast:[NSString stringWithFormat:@"level=%d",level]];

    
    NSDictionary*optionalParameterDic = @{
          /*可选*/
          WAEventParameterNameScore:@10,
          WAEventParameterNameFighting:@600,
      };
    
    
    WALevelAchievedEvent * event =[[WALevelAchievedEvent alloc] initWithCurrentLevel:level optionalParameter:optionalParameterDic];
    [event trackEvent];

}
- (void)levelAchieve2 {
    [self dismissAllKeyboards];
    level=5+level;
    [self makeToast:[NSString stringWithFormat:@"level=%d",level]];

    
    NSDictionary*optionalParameterDic = @{
          /*可选*/
          WAEventParameterNameScore:@10,
          WAEventParameterNameFighting:@600,
      };
    
    
    WALevelAchievedEvent * event =[[WALevelAchievedEvent alloc] initWithCurrentLevel:level optionalParameter:optionalParameterDic];
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


- (void)dismissAllKeyboards {
    // 尝试让当前视图放弃第一响应者状态
    [self endEditing:YES];

}

@end

