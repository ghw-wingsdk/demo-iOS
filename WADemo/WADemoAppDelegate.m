//
//  AppDelegate.m
//  GHWSDKDemo
//
//  Created by wuyx on 16/2/23.
//  Copyright © 2016年 GHW. All rights reserved.
//

#import "WADemoAppDelegate.h"
#import <WASdkIntf/WASdkIntf.h>
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@interface WADemoAppDelegate () <UNUserNotificationCenterDelegate>

@end

@implementation WADemoAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [WACoreProxy setDebugMode:YES];
    [WACoreProxy init];
    [WACoreProxy initAppEventTracker];
    [WAPayProxy init4Iap];
    [WACoreProxy setLevel:10];
	
	

	
    [WACoreProxy setGameUserId:@"server1-role2-59473437"];
    [WACoreProxy setNickName:@"2server1-59473437"];
    [WACoreProxy setServerId:@"server1"];

    [WAPushProxy application:application initPushWithDelegate:self];
    
	
	
	
	WAEvent* event = [[WAEvent alloc]init];
		event.defaultEventName = WAEventLevelAchieved;
		event.defaultValue = 1;
		event.defaultParamValues = @{
									 WAEventParameterNameScore:@100,
									 WAEventParameterNameFighting:@1000
									 };
		event.eventNameDict = @{WA_PLATFORM_APPSFLYER:WAEventLevelAchieved,WA_PLATFORM_CHARTBOOST:WAEventLevelAchieved,WA_PLATFORM_FACEBOOK:@"FacebookLevelAchieved",WA_PLATFORM_WINGA:WAEventLevelAchieved,WA_PLATFORM_FIREBASE:WAEventLevelAchieved};
	event.valueDict = @{WA_PLATFORM_APPSFLYER:@1,WA_PLATFORM_CHARTBOOST:@1,WA_PLATFORM_FACEBOOK:@2,WA_PLATFORM_WINGA:@1, WA_PLATFORM_FIREBASE:@1};
	event.channelSwitcherDict = @{WA_PLATFORM_APPSFLYER:@NO,WA_PLATFORM_FACEBOOK:@YES,WA_PLATFORM_WINGA:@YES,WA_PLATFORM_CHARTBOOST:@YES,WA_PLATFORM_FIREBASE:@YES};
		event.paramValuesDict =
		@{
		  WA_PLATFORM_APPSFLYER:@{
				  WAEventParameterNameScore:@100,
				  WAEventParameterNameFighting:@1000
				  },


		  WA_PLATFORM_FIREBASE:@{
				  WAEventParameterNameScore:@100,
				  WAEventParameterNameFighting:@1000
				  }
		  };
		
		[event trackEvent];
	
	
	
    return [WACoreProxy application:application didFinishLaunchingWithOptions:launchOptions];
    
}


- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    [WACoreProxy application:application didRegisterUserNotificationSettings:notificationSettings];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [WACoreProxy application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    [WACoreProxy application:application didFailToRegisterForRemoteNotificationsWithError:error];
}

#pragma mark IOS8 IOS9 Push Notification Receive
-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    [WACoreProxy application:application didReceiveLocalNotification:notification];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler
{
    [WACoreProxy application:application didReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler];
}

#pragma mark IOS10 Push Notification Receive
//App处于前台接收通知时
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    
    [WACoreProxy userNotificationCenter:center willPresentNotification:notification withCompletionHandler:completionHandler];
}

// 通知的点击事件
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler{
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
    [WACoreProxy applicationDidBecomeActive:application];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
//
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    return [WACoreProxy application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
    return [WACoreProxy application:app openURL:url options:options];
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray * _Nullable))restorationHandler
{
    return [WACoreProxy application:application continueUserActivity:userActivity restorationHandler:restorationHandler];
}

@end
