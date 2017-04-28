//
//  WAPushProxy.h
//  WASdkIntfUI
//
//  Created by hank on 2017/4/1.
//  Copyright © 2017年 GHW-T-01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WAIPush.h"

@interface WAPushProxy : NSObject

// 注册通知
+ (void)application:(UIApplication *)application initPushWithDelegate:(id<UNUserNotificationCenterDelegate>)delegate;

// 调用过用户注册通知方法之后执行
+ (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings;

// 获取deviceToken
+ (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;

// 注册失败
+ (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error;

#pragma mark IOS8 IOS9 Push Notification Receive
// 接收本地通知
+ (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification;
// 接收远程通知
+ (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler;

#pragma mark IOS10 Push Notification Receive
//App处于前台接收通知时
+ (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler;

// 通知的点击事件
+ (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler;

// 程序进入后台
+ (void)applicationDidEnterBackground:(UIApplication *)application;

// 程序将进入前台
+ (void)applicationWillEnterForeground:(UIApplication *)application;

// 程序进入前台
+ (void)applicationDidBecomeActive:(UIApplication *)application;

@end
