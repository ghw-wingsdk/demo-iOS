//
//  WAUserProxy.h
//  WASdkIntfUI
//
//  Created by GHW-T-01 on 16/3/1.
//  Copyright © 2016年 GHW-T-01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WALoginResult.h"
#import "WABindingResult.h"
#import "WAAccount.h"
#import "WAAppUser.h"
/*!
 @discussion 登录协议
 - - -
 */
@protocol WALoginDelegate <NSObject>

@required
/*!
 @abstract 登录成功
 @param results 登录结果
 */
-(void)loginDidCompleteWithResults:(WALoginResult*)result;
/*!
 @abstract 登录失败
 @param result 登录的用户信息 注:这不是登录结果,由于登录失败所以userId是空的.但如果第三方平台(Facebook,Apple)授权成功,pUserId,pToken,extends不为空,可用于提示用户.
 @param error 错误
 */
-(void)loginDidFailWithError:(NSError*)error andResult:(WALoginResult*)result;
@optional
/*!
 @abstract 用户取消登录
 @param result 登录的账户信息 (注:返回的result只有platform有值)
 */
-(void)loginDidCancel:(WALoginResult*)result;

@end

/*!
 @discussion 账户绑定协议
 - - -
 */
@protocol WAAccountBindingDelegate <NSObject>

@required
/*!
 @abstract 绑定成功
 @param result 绑定的账户信息
 */
-(void)bindingDidCompleteWithResult:(WABindingResult*)result;
/*!
 @abstract 绑定失败
 @param result 绑定的账户信息
 @param error 错误
 */
-(void)bindingDidFailWithError:(NSError*)error andResult:(WABindingResult*)result;
@optional
/*!
 @abstract 绑定取消
 @param result 绑定的账户信息(注:返回的result只有platform有值)
 */
-(void)bindingDidCancel:(WABindingResult*)result;
@end

/*!
 @discussion 登录界面协议
 - - -
 */
@protocol WALoginViewDelegate <NSObject>

@required
/*!
 @abstract 登录成功
 @param result 登录的用户信息
 */
-(void)loginViewDidCompleteWithResult:(WALoginResult*)result;
/*!
 @abstract 登录失败
 @param result 登录的用户信息 注:这不是登录结果,由于登录失败所以userId是空的.但如果第三方平台(Facebook,Apple)授权成功,pUserId,pToken,extends不为空,可用于提示用户.
 @param error 错误
 */
-(void)loginViewDidFailWithError:(NSError*)error andResult:(WALoginResult*)result;
@optional
/*!
 @abstract 用户取消登录
 @param result 登录的用户信息（只有platform非空）.
 */
-(void)loginViewDidCancel:(WALoginResult*)result;
@end

/*!
 @discussion 账号管理界面协议
 - - -
 */
@protocol WAAcctManagerDelegate <NSObject>

@required
/*!
 @abstract 新建账户回调接口
 @param result 新建账户的账户信息
 */
-(void)newAcctDidCompleteWithResult:(WALoginResult*)result;
/*!
 @abstract 切换账户回调接口
 @param result 切换账户的账户信息
 */
-(void)switchAcctDidCompleteWithResult:(WALoginResult*)result;
@end


/*!
 @discussion WAUserProxy 是用户模块的代理类。功能包括设置登录流程、登录、登出、绑定、解绑、查询当前用户绑定的第三方平台账户列表、切换账号、创建账号等等。
 - - -
 */

@interface WAUserProxy : NSObject

/*!
 @discussion 设置登录流程
 @param flowType 常量WA_LOGIN_FLOW_TYPE_DEFAULT是默认模式，表示切换新账户的时候不进行设备绑定操作，下次调用匿名登录还是登录之前的账户。常量WA_LOGIN_FLOW_TYPE_REBIND切换新账户的时候将当前设备的clientId绑定到新账户中，下一次匿名登录的时候将会登录到新账户。
 */
+(void)setLoginFlowType:(int)flowType;

/*!
 @discussion 获取登录流程
 */
+(int)getLoginFlowType;

/*!
 @discussion 登录接口
 @param platform 登录平台：目前的登录平台有Facebook，Apple，GUEST,对应的常量分别是WA_PLATFORM_FACEBOOK，WA_PLATFORM_APPLE，WA_PLATFORM_WINGA。
 @param extInfo 扩展信息
 @param delegate 委托
 */
+(void)loginWithPlatform:(NSString *const)platform extInfo:(NSString*)extInfo delegate:(id<WALoginDelegate>)delegate;
/*!
 @discussion 登出接口
 */
+(void)logout;

/*!
 @discussion 绑定账户接口
 @param platform 绑定平台:目前有Facebook,Apple,对应的常量分别为WA_PLATFORM_FACEBOOK,WA_PLATFORM_APPLE
 @param extInfo 扩展信息
 @param delegate 委托
 */
+(void)bindingAccountWithPlatform:(NSString *const)platform extInfo:(NSString*)extInfo delegate:(id<WAAccountBindingDelegate>)delegate;
/*!
 @discussion 查询绑定的第三方平台账户列表
 @param block 回调
 @error 错误
 @accounts 数组accounts存放着WAAccount类型的对象.
 */
+(void)queryBoundAccountWithCompleteBlock:(void(^)(NSError* error,NSArray<WAAccount *>* accounts))block;
/*!
 @discussion 解绑账号接口
 @param platform 解绑平台(WAAccount中的platform)
 @param pUserId 第三方平台用户id(WAAccount中的pUserId)
 */
+(void)unBindAccountWithPlatform:(NSString *const)platform platformUserId:(NSString*)pUserId completeBlock:(void(^)(NSError* error))completeBlock;
/*!
 @discussion 切换账号接口
 @param platform 切换平台
 @param error 错误
 @param result 登录结果
 */
+(void)switchAccountWithPlatform:(NSString *const)platform completeBlock:(void(^)(NSError* error,WALoginResult* result))completeBlock;

/*!
 @discussion 创建账号接口
 @param error 错误
 @param result 创建结果
 */
+(void)createNewAccountWithCompleteBlock:(void(^)(NSError* error,WALoginResult* result))completeBlock;


/*!
 @abstract 调用此方法打开登录界面
 @param delegate 委托
 @param cacheEnabled 是否缓存登录方式 当该参数为YES，默认以上次登录方式登录，不会弹出登录选择框。
 */
+(void)login:(id<WALoginViewDelegate>)delegate cacheEnabled:(BOOL)cacheEnabled;
/*!
 @abstract 调用此方法隐藏登录界面
 */
+(void)hide;
/*!
 @abstract 清除登录方式的缓存 清除缓存之后会再次弹出登录选择框
 */
+(void)clearLoginCache;
/*!
 @abstract 调用此方法打开账户管理界面
 @param delegate 委托
 */
+(void)openAccountManager:(id<WAAcctManagerDelegate>)delegate;

/*!
 @abstract 获取账户信息
 @param platform 平台
 */
+(WAAppUser*)getAccountInfoWithPlatform:(NSString *const)platform;

//+(NSString*)transferWithPlatform:(NSString *const)platform;

/*!
 @discussion 处理UIApplicationDelegate的方法[-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions]传递过来的参数。
 */
+ (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

/*!
 @discussion 处理UIApplicationDelegate的方法[+ (void)applicationDidBecomeActive:(UIApplication *)application]传递过来的参数。
 */
+ (void)applicationDidBecomeActive:(UIApplication *)application;

/*!
 @discussion 处理UIApplicationDelegate的方法[-(BOOL)application:(UIApplication *)application
 openURL:(NSURL *)url
 sourceApplication:(NSString *)sourceApplication
 annotation:(id)annotation]传递过来的参数。
 */
+(BOOL)application:(UIApplication *)application
           openURL:(NSURL *)url
 sourceApplication:(NSString *)sourceApplication
        annotation:(id)annotation;

/*!
 @discussion （tip:CP无需关注）此方法为成功登录第三方平台之后调用。根据第三方平台的pUserId，pToken，platform构建一个WALoginResult实例作为参数调用此方法。此方法将会调用WindAnalytics的登录接口。
 @param result 登录结果
 @param delegate 委托
 */
+(void)loginWithResult:(WALoginResult*)result delegate:(id<WALoginDelegate>)delegate;

+(void)loginWithResult:(WALoginResult*)result extInfo:(NSString*)extInfo delegate:(id<WALoginDelegate>)delegate;

/*!
 @discussion （tip:CP无需关注）设置当前的登录平台
 */
+(void)setCurrentLoginPlatform:(NSString *const)platform;
/*!
 @discussion （tip:CP无需关注）获取当前的登录平台
 */
+(NSString*)getCurrentLoginPlatform;
/*!
 @discussion （tip:CP无需关注）获取当前的登录结果
 */
+(WALoginResult*)getCurrentLoginResult;

/*!
 @discussion （tip:CP无需关注）获取用户模块组件
 */
+(NSArray*)getUserComponents;
@end
