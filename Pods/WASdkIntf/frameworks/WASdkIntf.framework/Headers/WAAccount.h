//
//  WASDKAccount.h
//  WASDKUI
//
//  Created by wuyx on 15/11/30.
//  Copyright © 2015年 GHW-T-01. All rights reserved.
//

#import <Foundation/Foundation.h>
/*!
 @discussion WAAccount 该类为账户类
 - - -
 */
@interface WAAccount : NSObject
/*!
 @abstract 第三方平台openId
 */
@property(nonatomic,copy)NSString* pUserId;//第三方平台openId
/*!
 @abstract 绑定平台标识 FACEBOOK、APPLE、WINGA
 */
@property(nonatomic,copy)NSString* platform;
+(WAAccount*)parserWithDict:(NSDictionary*)dict;
+(NSArray*)parserWithArray:(NSArray*)arr;
@end
