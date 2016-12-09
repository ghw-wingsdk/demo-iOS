//
//  GHWPostEventView.m
//  GHWSDKUI
//
//  Created by wuyx on 16/1/27.
//  Copyright © 2016年 GHW-T-01. All rights reserved.
//

#import "WADemoPostEventView.h"
#import "WADemoPostEventViewBtn.h"
#import "WADemoEventTableView.h"
#import "WADemoEventData.h"
#import "WADemoUtil.h"
@interface WADemoPostEventView()
@property(nonatomic,strong)WADemoPostEventViewBtn* defBtn;
@property(nonatomic,strong)WADemoPostEventViewBtn* afBtn;
@property(nonatomic,strong)WADemoPostEventViewBtn* fbBtn;
@property(nonatomic,strong)WADemoPostEventViewBtn* cbBtn;
@property(nonatomic,strong)WADemoPostEventViewBtn* ghwBtn;
@property(nonatomic,strong)WADemoEventTableView* afTV;
@property(nonatomic,strong)UIButton* closeBtn;
@property(nonatomic,strong)UIButton* postBtn;
@property(nonatomic)float naviHeight;
@property(nonatomic,weak)UIViewController* viewController;
@end
@implementation WADemoPostEventView
-(instancetype)init{
    self = [super init];
    if (self) {
        [self initUI];
    }
    return self;
}

-(instancetype)initWithViewControllerView:(UIViewController*)viewController eventName:(NSString*)eventName{
    self = [super init];
    if (self) {
        self.viewController = viewController;
        self.eventName = eventName;
        [self initData];
        [self initUI];
    }
    return self;
}

-(instancetype)initWithNaviHeight:(float)naviHeight eventName:(NSString*)eventName{
    self = [super init];
    if (self) {
        self.naviHeight = naviHeight;
        self.eventName = eventName;
        [self initData];
        [self initUI];
    }
    return self;
}



-(void)initData{
    
    self.afParam = [WADemoEventData getEventDataWithEventName:self.eventName];
    self.fbParam = [WADemoEventData getEventDataWithEventName:self.eventName];
    self.cbParam = [WADemoEventData getEventDataWithEventName:self.eventName];
    self.ghwParam = [WADemoEventData getEventDataWithEventName:self.eventName];
    self.defParam = [WADemoEventData getEventDataWithEventName:self.eventName];
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

-(void)handleDeviceOrientationDidChange:(NSNotification*)noti{
    [self setNeedsLayout];
}

-(void)initUI{
    
    //添加界面旋转通知
    [WADemoUtil addOrientationNotification:self selector:@selector(handleDeviceOrientationDidChange:) object:nil];
    
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.layer.borderWidth = 1;
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    
    _afBtn = [[WADemoPostEventViewBtn alloc]init];
    [_afBtn setTitle:@"AF" forState:UIControlStateNormal];
    _afBtn.tag = 1;
    [_afBtn addTarget:self action:@selector(changeChannel:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_afBtn];
    
    _fbBtn = [[WADemoPostEventViewBtn alloc]init];
    [_fbBtn setTitle:@"FB" forState:UIControlStateNormal];
    _fbBtn.tag = 2;
    [_fbBtn addTarget:self action:@selector(changeChannel:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_fbBtn];
    
    _cbBtn = [[WADemoPostEventViewBtn alloc]init];
    [_cbBtn setTitle:@"CB" forState:UIControlStateNormal];
    [_cbBtn addTarget:self action:@selector(changeChannel:) forControlEvents:UIControlEventTouchUpInside];
    _cbBtn.tag = 3;
    [self addSubview:_cbBtn];
    
    _ghwBtn = [[WADemoPostEventViewBtn alloc]init];
    _ghwBtn.tag = 4;
    [_ghwBtn addTarget:self action:@selector(changeChannel:) forControlEvents:UIControlEventTouchUpInside];
    [_ghwBtn setTitle:@"GHW" forState:UIControlStateNormal];
    [self addSubview:_ghwBtn];
    
    _defBtn = [[WADemoPostEventViewBtn alloc]init];
    _defBtn.tag = 5;
    [_defBtn addTarget:self action:@selector(changeChannel:) forControlEvents:UIControlEventTouchUpInside];
    [_defBtn setTitle:@"DEF" forState:UIControlStateNormal];
    [self addSubview:_defBtn];
    
    _afTV = [[WADemoEventTableView alloc]initWithFrame:CGRectZero channel:GHWEventTableViewChannelAF param:_afParam];
    _afTV.eventView = self;
    [self addSubview:_afTV];
    
    _postBtn = [[UIButton alloc]init];
    [_postBtn setTitle:@"Post" forState:UIControlStateNormal];
    [_postBtn setBackgroundColor:[UIColor greenColor]];
    [_postBtn addTarget:self action:@selector(postData) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_postBtn];
    
    _closeBtn = [[UIButton alloc]init];
    [_closeBtn setTitle:@"Close" forState:UIControlStateNormal];
    [_closeBtn setBackgroundColor:[UIColor redColor]];
    [_closeBtn addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_closeBtn];
    
    
}

-(void)closeView{
    [self removeFromSuperview];
}


-(void)changeChannel:(UIButton*)btn{
    GHWEventTableViewChannel channel;
    WADemoEventData* param;
    if (btn.tag == 1) {
        channel = GHWEventTableViewChannelAF;
        param = _afParam;
    }else if(btn.tag == 2){
        channel = GHWEventTableViewChannelFB;
        param = _fbParam;
    }else if(btn.tag == 3){
        channel = GHWEventTableViewChannelCB;
        param = _cbParam;
    }else if(btn.tag == 4){
        channel = GHWEventTableViewChannelGHW;
        param = _ghwParam;
    }else if(btn.tag == 5){
        channel = GHWEventTableViewChannelDEF;
        param = _defParam;
    }
    [_afTV removeFromSuperview];
    _afTV = [[WADemoEventTableView alloc]initWithFrame:CGRectZero channel:channel param:param];
    _afTV.eventView = self;
    [self addSubview:_afTV];
    [self setNeedsDisplay];
}

-(void)layoutSubviews{
    float screenH = [UIScreen mainScreen].bounds.size.height;
    float screenW = [UIScreen mainScreen].bounds.size.width;
    if (_naviHeight!=0) {
        self.frame = CGRectMake(0, _naviHeight, screenW, screenH - _naviHeight);
    }else{
        float statusBarH = [UIApplication sharedApplication].statusBarFrame.size.height;
        float naviBarH = 0;
        if (_viewController.navigationController) {
            naviBarH = _viewController.navigationController.navigationBar.bounds.size.height;
        }
        self.frame = CGRectMake(0, naviBarH + statusBarH, screenW, screenH - naviBarH - statusBarH);
    }
    
    float btn_space = 5;
    float btn_w = (screenW - 6*btn_space)/5;
    float btn_h = 40;
    float btn_x = btn_space;
    float btn_y = btn_space;
    _afBtn.frame = CGRectMake(btn_x, btn_y, btn_w, btn_h);
    
    CGRect frame = _afBtn.frame;
    frame.origin.x += btn_w + btn_space;
    _fbBtn.frame = frame;
    
    frame.origin.x += btn_w + btn_space;
    _cbBtn.frame = frame;
    
    frame.origin.x += btn_w + btn_space;
    _ghwBtn.frame = frame;
    
    frame.origin.x += btn_w + btn_space;
    _defBtn.frame = frame;
    
    float aftv_space = 5;
    float aftv_x = aftv_space;
    float aftv_y = _ghwBtn.frame.origin.y + _ghwBtn.frame.size.height + aftv_space;
    float aftv_w = screenW - 2*aftv_space;
    float aftv_h = 250;
    _afTV.frame = CGRectMake(aftv_x, aftv_y, aftv_w, aftv_h);
    
    float post_space = 40;
    float post_x = aftv_x;
    float post_y = aftv_y + aftv_h + post_space;
    float post_w = aftv_w;
    float post_h = 50;
    _postBtn.frame = CGRectMake(post_x, post_y, post_w, post_h);
    
    float close_space = 10;
    float close_y = post_y + post_h + close_space;
    frame = _postBtn.frame;
    frame.origin.y = close_y;
    _closeBtn.frame = frame;
    
}


-(NSDictionary*)dealWithParam:(WADemoEventData*)data{
    __block NSMutableDictionary* m_dict = [NSMutableDictionary dictionary];
    [data.params enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        WADemoEventParam* param = obj;
        if (param.paramType == GHWParamTypeString) {
            [m_dict setObject:param.paramDefValue forKey:param.paramName];
        }else{
            [m_dict setObject:[NSNumber numberWithInt:param.paramDefValue.intValue] forKey:param.paramName];
        }
    }];
    
    return m_dict;
}

-(void)postData{
    
//    WAIEvent* event = [[WAIEvent alloc]init];
    WAEvent* event = [[WAEvent alloc]init];
    
    event.channelSwitcherDict = @{WA_PLATFORM_APPSFLYER:[NSNumber numberWithBool:_afParam.on],WA_PLATFORM_CHARTBOOST:[NSNumber numberWithBool:_cbParam.on],WA_PLATFORM_FACEBOOK:[NSNumber numberWithBool:_fbParam.on],WA_PLATFORM_WINGA:[NSNumber numberWithBool:_ghwParam.on]};
    
    if (_defParam.eventNameOn) {
        event.defaultEventName = self.defParam.eventName;
    }
    if (_defParam.paramDictOn) {
        event.defaultParamValues = [self dealWithParam:_defParam];
    }
    
    event.defaultValue = [self.defParam.value doubleValue];
    
    
    
    NSMutableDictionary* mEventNameDict = [NSMutableDictionary dictionary];
    if (_afParam.eventNameOn) {
        [mEventNameDict setObject:_afParam.eventName forKey:WA_PLATFORM_APPSFLYER];
    }
    if (_cbParam.eventNameOn) {
        [mEventNameDict setObject:_cbParam.eventName forKey:WA_PLATFORM_CHARTBOOST];
    }
    if (_ghwParam.eventNameOn) {
        [mEventNameDict setObject:_ghwParam.eventName forKey:WA_PLATFORM_WINGA];
    }
    if (_fbParam.eventNameOn) {
        [mEventNameDict setObject:_fbParam.eventName forKey:WA_PLATFORM_FACEBOOK];
    }
    
    event.eventNameDict = mEventNameDict;
    event.valueDict = @{WA_PLATFORM_APPSFLYER:[NSNumber numberWithInt:[_afParam.value doubleValue]],WA_PLATFORM_CHARTBOOST:[NSNumber numberWithInt:[_cbParam.value doubleValue]],WA_PLATFORM_FACEBOOK:[NSNumber numberWithInt:[_fbParam.value doubleValue]],WA_PLATFORM_WINGA:[NSNumber numberWithInt:[_ghwParam.value doubleValue]]};
    
    
    NSMutableDictionary* mParamValueDict = [NSMutableDictionary dictionary];
    if (_afParam.paramDictOn) {
        [mParamValueDict setObject:[self dealWithParam:_afParam] forKey:WA_PLATFORM_APPSFLYER];
    }
    if (_cbParam.paramDictOn) {
        [mParamValueDict setObject:[self dealWithParam:_cbParam] forKey:WA_PLATFORM_CHARTBOOST];
    }
    if (_ghwParam.paramDictOn) {
        [mParamValueDict setObject:[self dealWithParam:_ghwParam] forKey:WA_PLATFORM_WINGA];
    }
    if (_fbParam.paramDictOn) {
        [mParamValueDict setObject:[self dealWithParam:_fbParam] forKey:WA_PLATFORM_FACEBOOK];
    }
    
    event.paramValuesDict = mParamValueDict;
    
    [event trackEvent];
}

-(void)TEST{
    
    WAEvent* event = [[WAEvent alloc]init];
    event.defaultEventName = WAEventLevelAchieved;
    event.defaultValue = 1;
    event.defaultParamValues = @{
                                 WAEventParameterNameScore:@100,
                                 WAEventParameterNameFighting:@1000,
                                 WAEventParameterNameLevelInfo:@"levelInfo",
                                 WAEventParameterNameLevelType:@2,
                                 WAEventParameterNameDescription:@"description"
                                 };
    event.eventNameDict = @{WA_PLATFORM_APPSFLYER:WAEventLevelAchieved,WA_PLATFORM_CHARTBOOST:WAEventLevelAchieved,WA_PLATFORM_FACEBOOK:@"FacebookLevelAchieved",WA_PLATFORM_WINGA:WAEventLevelAchieved};
    event.valueDict = @{WA_PLATFORM_APPSFLYER:@1,WA_PLATFORM_CHARTBOOST:@1,WA_PLATFORM_FACEBOOK:@2,WA_PLATFORM_WINGA:@1};
    event.channelSwitcherDict = @{WA_PLATFORM_APPSFLYER:@NO,WA_PLATFORM_FACEBOOK:@YES,WA_PLATFORM_WINGA:@YES,WA_PLATFORM_CHARTBOOST:@YES};
    event.channelSwitcherDict = @{WA_PLATFORM_APPSFLYER:@NO};
    event.paramValuesDict =
    @{
      WA_PLATFORM_APPSFLYER:@{
              WAEventParameterNameScore:@100,
              WAEventParameterNameFighting:@1000,
              WAEventParameterNameLevelInfo:@"levelInfo",
              WAEventParameterNameLevelType:@2,
              WAEventParameterNameDescription:@"description"
              },
      WA_PLATFORM_CHARTBOOST:@{
              WAEventParameterNameScore:@100,
              WAEventParameterNameFighting:@1000,
              WAEventParameterNameLevelInfo:@"levelInfo",
              WAEventParameterNameLevelType:@2,
              WAEventParameterNameDescription:@"description"
              },
      WA_PLATFORM_FACEBOOK:@{
              WAEventParameterNameScore:@100,
              WAEventParameterNameFighting:@1000,
              WAEventParameterNameLevelInfo:@"FacebookLevelInfo",
              WAEventParameterNameLevelType:@2,
              WAEventParameterNameDescription:@"FacebookDescription"
              },
      WA_PLATFORM_WINGA:@{
              WAEventParameterNameScore:@100,
              WAEventParameterNameFighting:@1000,
              WAEventParameterNameLevelInfo:@"levelInfo",
              WAEventParameterNameLevelType:@2,
              WAEventParameterNameDescription:@"description"
              }
      };
    
    [event trackEvent];
}

/*
 -(void)postData{
 GHWSDKEvent* event = [[GHWSDKEvent alloc]init];
 
 WAEventData* params = _afParam;
 event.channelSwitcherDict = @{WA_PLATFORM_APPSFLYER:[NSNumber numberWithBool:_afParam.on],WA_PLATFORM_CHARTBOOST:[NSNumber numberWithBool:_cbParam.on],WA_PLATFORM_FACEBOOK:[NSNumber numberWithBool:_fbParam.on],WA_PLATFORM_WINGA:[NSNumber numberWithBool:_ghwParam.on]};
 
 if (_defParam.eventNameOn) {
 event.defaultEventName = self.defParam.eventName;
 }
 if (_defParam.paramDictOn) {
 event.defaultParamValues = @{
 WAEventParameterNameLevel:[NSNumber numberWithInt:[_defParam.level intValue]],
 WAEventParameterNameScore:[NSNumber numberWithInt:[_defParam.score intValue]],
 WAEventParameterNameFighting:[NSNumber numberWithInt:[_defParam.fighting intValue]],
 WAEventParameterNameLevelInfo:_defParam.levelInfo,
 WAEventParameterNameLevelType:[NSNumber numberWithInt:[_defParam.levelType intValue]],
 WAEventParameterNameDescription:_defParam.desc
 };
 }
 
 event.defaultValue = [self.defParam.value doubleValue];
 
 
 
 NSMutableDictionary* mEventNameDict = [NSMutableDictionary dictionary];
 if (_afParam.eventNameOn) {
 [mEventNameDict setObject:_afParam.eventName forKey:WA_PLATFORM_APPSFLYER];
 }
 if (_cbParam.eventNameOn) {
 [mEventNameDict setObject:_cbParam.eventName forKey:WA_PLATFORM_CHARTBOOST];
 }
 if (_ghwParam.eventNameOn) {
 [mEventNameDict setObject:_ghwParam.eventName forKey:WA_PLATFORM_WINGA];
 }
 if (_fbParam.eventNameOn) {
 [mEventNameDict setObject:_fbParam.eventName forKey:WA_PLATFORM_FACEBOOK];
 }
 
 event.eventNameDict = mEventNameDict;
 event.valueDict = @{WA_PLATFORM_APPSFLYER:[NSNumber numberWithInt:[_afParam.value doubleValue]],WA_PLATFORM_CHARTBOOST:[NSNumber numberWithInt:[_cbParam.value doubleValue]],WA_PLATFORM_FACEBOOK:[NSNumber numberWithInt:[_fbParam.value doubleValue]],WA_PLATFORM_WINGA:[NSNumber numberWithInt:[_ghwParam.value doubleValue]]};
 
 
 NSMutableDictionary* mParamValueDict = [NSMutableDictionary dictionary];
 if (_afParam.paramDictOn) {
 [mParamValueDict setObject:@{
 WAEventParameterNameLevel:[NSNumber numberWithInt:[_afParam.level intValue]],
 WAEventParameterNameScore:[NSNumber numberWithInt:[_afParam.score intValue]],
 WAEventParameterNameFighting:[NSNumber numberWithInt:[_afParam.fighting intValue]],
 WAEventParameterNameLevelInfo:_afParam.levelInfo,
 WAEventParameterNameLevelType:[NSNumber numberWithInt:[_afParam.levelType intValue]],
 WAEventParameterNameDescription:_afParam.desc
 } forKey:WA_PLATFORM_APPSFLYER];
 }
 if (_cbParam.paramDictOn) {
 [mParamValueDict setObject:@{
 WAEventParameterNameLevel:[NSNumber numberWithInt:[_cbParam.level intValue]],
 WAEventParameterNameScore:[NSNumber numberWithInt:[_cbParam.score intValue]],
 WAEventParameterNameFighting:[NSNumber numberWithInt:[_cbParam.fighting intValue]],
 WAEventParameterNameLevelInfo:_cbParam.levelInfo,
 WAEventParameterNameLevelType:[NSNumber numberWithInt:[_cbParam.levelType intValue]],
 WAEventParameterNameDescription:_cbParam.desc
 } forKey:WA_PLATFORM_CHARTBOOST];
 }
 if (_ghwParam.paramDictOn) {
 [mParamValueDict setObject:@{
 WAEventParameterNameLevel:[NSNumber numberWithInt:[_ghwParam.level intValue]],
 WAEventParameterNameScore:[NSNumber numberWithInt:[_ghwParam.score intValue]],
 WAEventParameterNameFighting:[NSNumber numberWithInt:[_ghwParam.fighting intValue]],
 WAEventParameterNameLevelInfo:_ghwParam.levelInfo,
 WAEventParameterNameLevelType:[NSNumber numberWithInt:[_ghwParam.levelType intValue]],
 WAEventParameterNameDescription:_ghwParam.desc
 } forKey:WA_PLATFORM_WINGA];
 }
 if (_fbParam.paramDictOn) {
 [mParamValueDict setObject:@{
 WAEventParameterNameLevel:[NSNumber numberWithInt:[_fbParam.level intValue]],
 WAEventParameterNameScore:[NSNumber numberWithInt:[_fbParam.score intValue]],
 WAEventParameterNameFighting:[NSNumber numberWithInt:[_fbParam.fighting intValue]],
 WAEventParameterNameLevelInfo:_fbParam.levelInfo,
 WAEventParameterNameLevelType:[NSNumber numberWithInt:[_fbParam.levelType intValue]],
 WAEventParameterNameDescription:_fbParam.desc
 } forKey:WA_PLATFORM_FACEBOOK];
 }
 
 
 
 event.paramValuesDict = mParamValueDict;
 
 [event trackEvent];
 }
 
 
 */

-(void)dealloc{
    [WADemoUtil removeOrientationNotification:self object:nil];
}
@end
