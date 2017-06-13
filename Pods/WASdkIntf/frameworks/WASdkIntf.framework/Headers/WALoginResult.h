//
//  GHWLoginResult.h
//  GHWSdk
//
//  Created by wuyx on 15/5/6.
//  Copyright (c) 2015年 GHW-T-01. All rights reserved.
//

#import <Foundation/Foundation.h>
/*!
 @discussion 该类为登录结果
 - - -
 */
@interface WALoginResult : NSObject<NSCoding,NSCopying>
/*!
 @abstract 状态码
 */
@property(copy,nonatomic)NSString *code;
/*!
 @abstract 结果描述
 */
@property(copy,nonatomic)NSString *msg;
/*!
 @abstract 用户Id,（注册）登录成功的时候返回
 */
@property(copy,nonatomic)NSString *userId;
/*!
 @abstract 在线token，（注册）登录成功的时候返回，如果传入的token未过期，直接返回原来的token，否则返回更新后的token
 */
@property(copy,nonatomic)NSString *token;
/*!
 @abstract 用户在第三方平台的Id，GUEST登录时 值与userId一致
 */
@property(copy,nonatomic)NSString *pUserId;
/*!
 @abstract 平台
 */
@property(copy,nonatomic)NSString *platform;
/*!
 @abstract 第三方平台token(当GUEST登录时为空，当Apple登录时,实际上是将extends转化为NSString)
 */
@property(copy,nonatomic)NSString *pToken;
/*!
 @abstract 当APPLE登录时有值,否则为空
 */
@property(strong,nonatomic)NSDictionary *extends;//当APPLE登录时有值,否则为空
/**!
 @abstract 是否绑定手机号
 */
@property BOOL isBindMobile;
/**!
 @abstract 是否绑定手机号 用户状态(有效用户返回)：
 * 0:已实名
 * 1:未实名
 */
@property NSInteger userStatus;
/**!
 @abstract 登录实名验证：
 * 0:不需要实名验证
 * 1:提示用户实名验证，这里返回的token可作为登录及用户实名验证使用
 * 2:强制用户实名验证，此时返回的仅是token是实名验证token
 */
@property NSInteger loginRna;
/**!
 @abstract 支付实名验证：
 * 0:不需要实名验证
 * 1:提示用户实名验证
 * 2:强制用户实名验证
 * 注：当有该字段返回时，token可作为登录及用户实名验证使用
 */
@property NSInteger paymentRna;

-(id)initWithPUserId:(NSString*)userId pToken:(NSString*)token platform:(NSString*)platform;
+(id)loginResultWithPUserId:(NSString*)userId pToken:(NSString*)token platform:(NSString*)platform;
@end
