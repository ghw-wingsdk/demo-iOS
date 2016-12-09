//
//  WAIUser.h
//  WASdkIntfUI
//
//  Created by GHW-T-01 on 16/3/1.
//  Copyright © 2016年 GHW-T-01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WAUserProxy.h"
@interface WAIUser : NSObject
-(void)setLoginFlowType:(int)flowType;
-(int)getLoginFlowType;
-(WAAppUser*)getAccountInfo;
-(void)loginWithExtInfo:(NSString *)extInfo delegate:(id<WALoginDelegate>)delegate;
-(void)logout;
-(void)bindingAccountWithExtInfo:(NSString*)extInfo delegate:(id<WAAccountBindingDelegate>)delegate;
-(void)bindingAccountWithPlatform:(NSString *const)platform bindingResult:(WABindingResult*)bindingResult extInfo:(NSString *)extInfo  delegate:(id<WAAccountBindingDelegate>)delegate;
-(void)queryBoundAccountWithCompleteBlock:(void(^)(NSError* error,NSArray<WAAccount *>* accounts))block;
-(void)unBindAccountWithPlatform:(NSString *const)platform platformUserId:(NSString *)pUserId completeBlock:(void (^)(NSError *))completeBlock;
-(void)switchAccountWithPlatform:(NSString *const)platform completeBlock:(void (^)(NSError *, WALoginResult *))completeBlock;
-(void)createNewAccountWithCompleteBlock:(void(^)(NSError* error,WALoginResult* result))completeBlock;
-(void)login:(id<WALoginViewDelegate>)delegate cacheEnabled:(BOOL)cacheEnabled;
-(void)hide;
-(void)clearLoginCache;
-(void)openAccountManager:(id<WAAcctManagerDelegate>)delegate;

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

-(void)applicationDidBecomeActive:(UIApplication *)application;

-(BOOL)application:(UIApplication *)application
           openURL:(NSURL *)url
 sourceApplication:(NSString *)sourceApplication
        annotation:(id)annotation;

-(void)loginWithResult:(WALoginResult*)result delegate:(id<WALoginDelegate>)delegate;
-(void)loginWithResult:(WALoginResult*)result extInfo:(NSString*)extInfo delegate:(id<WALoginDelegate>)delegate;

-(void)setCurrentLoginPlatform:(NSString *const)platform;
-(NSString*)getCurrentLoginPlatform;
-(WALoginResult*)getCurrentLoginResult;

-(void)didUserLogin:(void(^)(NSError* error,BOOL didLogin))block;
@end
