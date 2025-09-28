//
//  AppDelegate.m
//  WADemo
//
//  Created by lpw on 2023/5/19.
//

#import "AppDelegate.h"
#import <WASdkIntf/WASdkIntf.h>
#import <WACommon/WAHelper.h>
#import "WADemoUtil.h"

@interface AppDelegate ()<UNUserNotificationCenterDelegate,GADFullScreenContentDelegate>
@end

@implementation AppDelegate




- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    [WAAdMobProxy setTestMode:YES];

    UIViewController *initialViewController;
    [WAAdMobProxy isOpenBannerAdWithCompletion:^(BOOL isOpen, NSError * _Nonnull error) {
        
        NSLog(@"BannerAd检测广告开关，初始化前调用====%d",isOpen);
        
    }];
    
    [WAAdMobProxy isOpenInterstitialAdWithCompletion:^(BOOL isOpen, NSError * _Nonnull error) {
        
        NSLog(@"InterstitialAd检测广告开关，初始化前调用=====%d",isOpen);
        
    }];
    
    [WAAdMobProxy isOpenAppOpenAdWithCompletion:^(BOOL isOpen, NSError * _Nonnull error) {
        
        NSLog(@"AppOpenAd检测广告开关，初始化前调用=====%d",isOpen);
        
    }];

                              
    [WAAdMobProxy isOpenRewardedWithAdName:@"admob1" completion:^(BOOL isOpen, NSError * _Nonnull error) {
        
        NSLog(@"Rewarded-admob1-检测广告开关，初始化前调用=====%d",isOpen);

    }];
    
    [WAAdMobProxy isOpenRewardedWithAdName:@"admob2" completion:^(BOOL isOpen, NSError * _Nonnull error) {
        
        NSLog(@"Rewarded-admob2-检测广告开关，初始化前调用=====%d",isOpen);

    }];
    
    [WACoreProxy setDebugMode:YES];

    [WACoreProxy initWithCompletionHandler:^{

        [WACoreProxy initAppEventTracker];
        [WAPayProxy init4Iap];
        [WACoreProxy setLevel:10];
        NSLog(@"初始化完成====");

//        [WACoreProxy setGameUserId:@"server1-role1-7282489"];
//        [WACoreProxy setNickName:@"青铜server1-7282489"];
//        [WACoreProxy setServerId:@"server1"];
        [WAPushProxy application:application initPushWithDelegate:self];

        [WACoreProxy application:application didFinishLaunchingWithOptions:launchOptions];
        NSLog(@"==WAFinishTransactionTime==%@",[WAHelper loadObjFromKeyChainWithKey:@"WAFinishTransactionTime"]);

    }];
    
    BOOL openAdStatus =[[NSUserDefaults standardUserDefaults] boolForKey:@"openAdStatus"];
    openAdStatus=NO;
    if (openAdStatus) {
        initialViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SplashScreenViewController"];
    } else {
        initialViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ViewController"];
    }
    
    // 设置初始视图控制器
    self.window.rootViewController = initialViewController;
    [self.window makeKeyAndVisible];

    
    return YES;
    
}




- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSLog(@"能够获取到token===============");
    [WACoreProxy application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    [WACoreProxy application:application didFailToRegisterForRemoteNotificationsWithError:error];
}






- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler
{
    [WACoreProxy application:application didReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler];
}



#pragma mark IOS10 or later Push Notification Receive
//App处于前台接收通知时
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    
    [WACoreProxy userNotificationCenter:center willPresentNotification:notification withCompletionHandler:completionHandler];
}

// 通知的点击事件
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler{
    [WACoreProxy userNotificationCenter:center didReceiveNotificationResponse:response withCompletionHandler:completionHandler];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save us er data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [WACoreProxy applicationDidEnterBackground:application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [WACoreProxy applicationWillEnterForeground:application];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    NSLog(@"applicationDidBecomeActive===");
    [WACoreProxy applicationDidBecomeActive:application];
    
    [WAAdMobProxy showInterstitialAdWithViewController:[WADemoUtil getCurrentVC] withDelegate:self];

}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
    return [WACoreProxy application:app openURL:url options:options];
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler
{
    return [WACoreProxy application:application continueUserActivity:userActivity restorationHandler:restorationHandler];
}

/// Tells the delegate that an impression has been recorded for the ad.
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

}


@end
