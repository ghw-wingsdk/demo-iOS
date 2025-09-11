//
//  WADemoAdMobView.m
//  WADemo
//
//  Created by lpw on 2024/5/30.
//

#import "WADemoAdMobView.h"
#import "WADemoMaskLayer.h"
#import "WADemoButtonMain.h"
#import "WADemoUtil.h"
#import <WASdkIntf/WASdkIntf.h>
#import <Toast/Toast.h>
#import "WADemoLoginUI.h"
#import <GoogleMobileAds/GoogleMobileAds.h>

@interface WADemoAdMobView ()<UITextFieldDelegate,GADFullScreenContentDelegate>
@property (nonatomic, strong) UIView *bannerView;

@property (nonatomic, strong) WADemoButtonMain* btn1;
@property (nonatomic, strong) UITextField * textField;
@property (nonatomic, strong) WADemoButtonMain * openAdButton;
@property (nonatomic) BOOL openAdStatus;


@end

@implementation WADemoAdMobView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //添加界面旋转通知
        [WADemoUtil addOrientationNotification:self selector:@selector(handleDeviceOrientationDidChange:) object:nil];
        
        
        // 注册通知监听
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(handleUserDidEarnRewardNotification:)
                                                     name:@"UserDidEarnRewardNotification"
                                                   object:nil];
        
        [self initViews];
    }
    return self;
}


-(void)handleDeviceOrientationDidChange:(NSNotification*)noti{
    [self setNeedsLayout];
}

-(void)initViews
{
    self.openAdStatus =[[NSUserDefaults standardUserDefaults] boolForKey:@"openAdStatus"];
    
    NSMutableArray* btns = [NSMutableArray array];

    self.bannerView = [[UIView alloc] init];
    self.bannerView.backgroundColor = [UIColor grayColor];
    [btns addObject:self.bannerView];
    [WAAdMobProxy bindBannerAdWithViewController:[WADemoUtil getCurrentVC] containerView:self.bannerView];

    
    _btn1 = [[WADemoButtonMain alloc]init];
    self.btn1.tag = 1000;
    [self.btn1 setTitle:@"横幅是否开启" forState:UIControlStateNormal];
    [self.btn1 addTarget:self action:@selector(buttonEvents:) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:self.btn1];
    
    
    
    _btn1 = [[WADemoButtonMain alloc]init];
    self.btn1.tag = 1000;
    [self.btn1 setTitle:@"插页是否开启" forState:UIControlStateNormal];
    [self.btn1 addTarget:self action:@selector(buttonEvents:) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:self.btn1];
    
    
    _btn1 = [[WADemoButtonMain alloc]init];
    self.btn1.tag = 1;
    [self.btn1 setTitle:@"检查插页广告" forState:UIControlStateNormal];
    [self.btn1 addTarget:self action:@selector(buttonEvents:) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:self.btn1];
    
    WADemoButtonMain* btn2 = [[WADemoButtonMain alloc]init];
    btn2.tag = 2;
    [btn2 setTitle:@"显示插页广告" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(buttonEvents:) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn2];
    
    
    

    btn2 = [[WADemoButtonMain alloc]init];
    btn2.tag = 3;
    [btn2 setTitle:@"开屏是否开启" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(buttonEvents:) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn2];
    
    btn2 = [[WADemoButtonMain alloc]init];
    btn2.tag = 3;
    [btn2 setTitle:@"检查开屏广告" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(buttonEvents:) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn2];
    
    btn2 = [[WADemoButtonMain alloc]init];
    btn2.tag = 4;
    [btn2 setTitle:@"显示开屏广告" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(buttonEvents:) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn2];
    
    
    
    
    self.textField = [[UITextField alloc] init];
    self.textField.text=@"Reward001";
    self.textField.returnKeyType=UIReturnKeyDone;
    self.textField.delegate=self;
    self.textField.tag = 5;
    [btns addObject:self.textField];
    
    
    
    btn2 = [[WADemoButtonMain alloc]init];
    [btn2 setTitle:@"激励是否开启" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(buttonEvents:) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn2];
    
    
    btn2 = [[WADemoButtonMain alloc]init];
    btn2.tag = 6;
    [btn2 setTitle:@"显示激励广告" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(buttonEvents:) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn2];
    
    
    
    

    
    
    btn2 = [[WADemoButtonMain alloc]init];
    btn2.tag = 7;
    [btn2 setTitle:@"检查配置" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(buttonEvents:) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn2];
    
    
    btn2 = [[WADemoButtonMain alloc]init];
    btn2.tag = 8;
    [btn2 setTitle:@"打开配置" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(buttonEvents:) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn2];
    
    
    btn2 = [[WADemoButtonMain alloc]init];
    btn2.tag = 9;
    if (self.openAdStatus) {
        [btn2 setTitle:@"开屏广告:开" forState:UIControlStateNormal];

    }else{
        [btn2 setTitle:@"开屏广告:关" forState:UIControlStateNormal];

    }
    [btn2 addTarget:self action:@selector(buttonEvents:) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn2];
    self.openAdButton= btn2;
    
    
    
    btn2 = [[WADemoButtonMain alloc]init];
    [btn2 setTitle:@"查看广告任务" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(buttonEvents:) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn2];
    
    
    btn2 = [[WADemoButtonMain alloc]init];
    [btn2 setTitle:@"检查任务情况" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(buttonEvents:) forControlEvents:UIControlEventTouchUpInside];
    [btns addObject:btn2];
    
    
    NSMutableArray* btnLayout = [NSMutableArray arrayWithArray:@[@1,@1,@3,@3,@3,@2,@1,@0,@2]];
    //
    self.title = @"Admob";
    self.btnLayout = btnLayout;
    self.btns = btns;
}

- (void)buttonEvents:(WADemoButtonMain *)button
{
    
    NSString *buttonTitle = button.titleLabel.text;
    WALog(@"%@ 被按下", buttonTitle);
    
    if ([buttonTitle isEqualToString:@"检查插页广告"]) {
        // 检测插页广告逻辑
       BOOL openad= [WAAdMobProxy checkInterstitialAdReady];
       [self makeToast:[NSString stringWithFormat:@"检测插页广告:%d",openad]];
        
        
    } else if ([buttonTitle isEqualToString:@"显示插页广告"]) {
        // 展示插页广告逻辑
        [WAAdMobProxy showInterstitialAdWithViewController:[WADemoUtil getCurrentVC] withDelegate:self];
        
    }else if ([buttonTitle isEqualToString:@"横幅是否开启"]) {
        // 横幅是否开启
        BOOL openad=[WAAdMobProxy isOpenBannerAd];
        
        [self makeToast:[NSString stringWithFormat:@"横幅广告是否开启:%d",openad]];
        
        
        
    } else if ([buttonTitle isEqualToString:@"插页是否开启"]) {
        // 插页是否开启
        BOOL openad=[WAAdMobProxy isOpenInterstitialAd];
        
        [self makeToast:[NSString stringWithFormat:@"插页广告是否开启:%d",openad]];
        
        
        
    } else if ([buttonTitle isEqualToString:@"开屏是否开启"]) {
        // 插页是否开启
        BOOL openad=[WAAdMobProxy isOpenAppOpenAd];
        
        [self makeToast:[NSString stringWithFormat:@"开屏广告是否开启:%d",openad]];
        
        
        
    }  else if ([buttonTitle isEqualToString:@"激励是否开启"]) {
        // 插页是否开启
        BOOL openad=[WAAdMobProxy isOpenRewardedWithAdName:self.textField.text];
        
        [self makeToast:[NSString stringWithFormat:@"激励广告是否开启:%d",openad]];
        
        
        
    }else  if ([buttonTitle isEqualToString:@"检查开屏广告"]) {
        // 检测开屏广告逻辑
       BOOL openad= [WAAdMobProxy checkAppOpenAdReady];
      [self makeToast:[NSString stringWithFormat:@"检测开屏广告:%d",openad]];
        
        
    } else if ([buttonTitle isEqualToString:@"显示开屏广告"]) {
        [WAAdMobProxy showAppOpenAdWithViewController:[WADemoUtil getCurrentVC] withDelegate:self];
        
    } else if ([buttonTitle isEqualToString:@"显示激励广告"]) {
        
        NSMutableDictionary *object = [NSMutableDictionary dictionary];
        [object setObject:@"abcdefghiklmn" forKey:@"cpKey"];
        [object setObject:@"AAAA2222BBBB" forKey:@"cpValue"];
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object options:0 error:&error];

        if (!jsonData) {
            NSLog(@"JSON serialization error: %@", error);
            return;
        }

        NSString *extInfo = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"extInfo: %@", extInfo);
        // 展示激励广告逻辑
        [WAAdMobProxy showRewardedAdWithViewController:[WADemoUtil getCurrentVC] adName:self.textField.text extInfo:extInfo delegate:self];

    }else if ([buttonTitle isEqualToString:@"检查配置"]) {

        BOOL openad= [WAAdMobProxy checkUmpOptions];
        [self makeToast:[NSString stringWithFormat:@"检查配置:%d",openad]];

    }else if ([buttonTitle isEqualToString:@"打开配置"]) {
        // 展示激励广告逻辑
        if([WAAdMobProxy checkUmpOptions]){
            
            [WAAdMobProxy showUmpOptionsWithViewController:[WADemoUtil getCurrentVC] consentGatheringComplete:^(NSError * _Nullable error) {
            }];
        }

    }else if(button.tag==9){
        self.openAdStatus=!self.openAdStatus;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool:self.openAdStatus forKey:@"openAdStatus"];
        [defaults synchronize]; // 在 iOS 7 之后，通常不需要手动调用 synchronize 方法
        
        if (self.openAdStatus) {
            [self.openAdButton setTitle:@"开屏广告:开" forState:UIControlStateNormal];

        }else{
            [self.openAdButton setTitle:@"开屏广告:关" forState:UIControlStateNormal];

        }
        


    }else if ([buttonTitle isEqualToString:@"查看广告任务"]) {
        // 获取广告任务列表
        [WAUserProxy fetchPromotionTasksWithCompletion:^(NSArray<NSDictionary *> * _Nullable tasks, NSError * _Nullable error) {
            
            if (error) {
                [self makeToast:error.userInfo[WAErrorDeveloperMessageKey]];

                return;
            }
            if (tasks) {
                NSMutableString *showStr = [[NSMutableString alloc]init];

                if ([tasks count]>0) {
                    for (NSDictionary *dic in tasks) {
                        // 安全获取任务名称
                        NSString *taskName = [dic objectForKey:@"taskName"];
                        if (!taskName || [taskName isKindOfClass:[NSNull class]]) {
                            taskName = @"";
                        }
                        
                        // 安全获取奖励状态
                        NSString *rewardStatus = [dic objectForKey:@"rewardStatus"];
                        if (!rewardStatus || [rewardStatus isKindOfClass:[NSNull class]]) {
                            rewardStatus = @"";
                        }
                        
                        // 安全获取任务状态
                        NSString *taskStatus = [dic objectForKey:@"taskStatus"];
                        if (!taskStatus || [taskStatus isKindOfClass:[NSNull class]]) {
                            taskStatus = @"";
                        }
                        
                        // 拼接任务信息（格式可根据需求调整）
                        [showStr appendFormat:@"任务: %@\n奖励状态: %@\n任务状态: %@\n\n",
                                      taskName, rewardStatus, taskStatus];
                    }
                    [self makeToast:showStr];
                }
     

            }
            
            
            NSLog(@"tasks====%@",tasks);
            
        }];

    }else if ([buttonTitle isEqualToString:@"检查任务情况"]) {
        
        // 检查用户任务完成情况，实际未通知后台接口，通知成功后，再次调用任务列表，查看发放情况
        [WAUserProxy checkPlayerTask:^(NSError * _Nullable error, BOOL success) {
            
            if (error) {
                [self makeToast:error.userInfo[WAErrorDeveloperMessageKey]];

                return;
            }
            
            
            [self makeToast:[NSString stringWithFormat:@"检查任务情况通知结果:%d,再次调用任务列表，查看奖励发放情况",success]];

            
            [WAUserProxy fetchPromotionTasksWithCompletion:^(NSArray<NSDictionary *> * _Nullable tasks, NSError * _Nullable error) {
                
                if (tasks) {
                    NSMutableString *showStr = [[NSMutableString alloc]init];

                    for (NSDictionary *dic in tasks) {
                        // 安全获取任务名称
                        NSString *taskName = [dic objectForKey:@"taskName"];
                        if (!taskName || [taskName isKindOfClass:[NSNull class]]) {
                            taskName = @"";
                        }
                        
                        // 安全获取奖励状态
                        NSString *rewardStatus = [dic objectForKey:@"rewardStatus"];
                        if (!rewardStatus || [rewardStatus isKindOfClass:[NSNull class]]) {
                            rewardStatus = @"";
                        }
                        
                        // 安全获取任务状态
                        NSString *taskStatus = [dic objectForKey:@"taskStatus"];
                        if (!taskStatus || [taskStatus isKindOfClass:[NSNull class]]) {
                            taskStatus = @"";
                        }
                        
                        // 拼接任务信息（格式可根据需求调整）
                        [showStr appendFormat:@"任务: %@\n奖励状态: %@\n任务状态: %@\n\n",
                                      taskName, rewardStatus, taskStatus];
                    }
                    [self makeToast:showStr];

                }
                
                
                NSLog(@"tasks====%@",tasks);
                
            }];
            
            
        }];
    }
    
    

}


-(void)dealloc
{
    [WADemoUtil removeOrientationNotification:self object:nil];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.textField resignFirstResponder];
    return YES;
}              // called when 'return' key pressed. return NO to ignore.



///// Tells the delegate that an impression has been recorded for the ad.
- (void)adDidRecordImpression:(nonnull id<GADFullScreenPresentingAd>)ad {
    WALog(@"adDidRecordImpression");
}

/// Tells the delegate that a click has been recorded for the ad.
- (void)adDidRecordClick:(nonnull id<GADFullScreenPresentingAd>)ad {
    WALog(@"adDidRecordClick");
}

/// Tells the delegate that the ad failed to present full screen content.
- (void)ad:(nonnull id<GADFullScreenPresentingAd>)ad didFailToPresentFullScreenContentWithError:(nonnull NSError *)error {
    WALog(@"didFailToPresentFullScreenContentWithError");
    
//    if ([ad isKindOfClass:[GADRewardedAd class]]) {
//        [self makeToast:[NSString stringWithFormat:@"激励广告加载失败:%@",error.description]];
//    }else if([ad isKindOfClass:[GADInterstitialAd class]]){
//        [self makeToast:[NSString stringWithFormat:@"插页广告加载失败:%@",error.description]];
//    }else if([ad isKindOfClass:[GADAppOpenAd class]]){
//        [self makeToast:[NSString stringWithFormat:@"开屏广告加载失败:%@",error.description]];
//
//    }
}

/// Tells the delegate that the ad will present full screen content.
- (void)adWillPresentFullScreenContent:(nonnull id<GADFullScreenPresentingAd>)ad {
    WALog(@"adWillPresentFullScreenContent");
}

/// Tells the delegate that the ad will dismiss full screen content.
- (void)adWillDismissFullScreenContent:(nonnull id<GADFullScreenPresentingAd>)ad {
    WALog(@"adWillDismissFullScreenContent");
}

/// Tells the delegate that the ad dismissed full screen content.
- (void)adDidDismissFullScreenContent:(nonnull id<GADFullScreenPresentingAd>)ad {
    WALog(@"adDidDismissFullScreenContent");
//    if ([ad isKindOfClass:[GADRewardedAd class]]) {
//        [self makeToast:@"激励广告隐藏"];
//    }else if([ad isKindOfClass:[GADAppOpenAd class]]){
//        [self makeToast:@"开屏广告隐藏"];
//    }else if([ad isKindOfClass:[GADInterstitialAd class]]){
//        [self makeToast:@"插页广告隐藏"];
//    }
}


// 处理通知
- (void)handleUserDidEarnRewardNotification:(NSNotification *)notification {
    NSDictionary *rewardDic = notification.userInfo;
    // 在这里处理奖励逻辑
    NSLog(@"用户获得奖励: %@", rewardDic);
    NSString *rewardMessage = [NSString
                               stringWithFormat:@"type %@ , amount %@, adName %@, extInfo %@",
                               [rewardDic objectForKey:@"type"], [rewardDic objectForKey:@"amount"],[rewardDic objectForKey:@"adName"],[rewardDic objectForKey:@"extInfo"]];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self makeToast:rewardMessage];

    });
    
}

/// 废弃
- (void)userDidEarnReward:(nonnull NSMutableDictionary*)rewardDic{
    
    WALog(@"本地的奖励回掉已执行======%@",rewardDic);

    
    
    NSString *rewardMessage = [NSString
                               stringWithFormat:@"type %@ , amount %@, adName %@, extInfo %@",
                               [rewardDic objectForKey:@"type"], [rewardDic objectForKey:@"amount"],[rewardDic objectForKey:@"adName"],[rewardDic objectForKey:@"extInfo"]];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self makeToast:rewardMessage];

    });

    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
