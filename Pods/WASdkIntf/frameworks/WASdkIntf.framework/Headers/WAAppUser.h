//
//  GHWFriend.h
//  GHWSdkUI
//
//  Created by wuyx on 15/7/1.
//  Copyright (c) 2015年 GHW-T-01. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 @discussion WAFBApplication
 - - -
 */
@interface WAAppUser : NSObject<NSCoding,NSCopying>
/*!
 @abstract ID
 */
@property(nonatomic,copy)NSString* ID;
/*!
 @abstract waUserId
 @discussion 查询游戏内的好友时,waUserId的值是facebook ID对应的ghw UserId.先从facebook查询到好友列表,再用该列表去ghw后台查询对应的waUserId,查询成功则该属性有值,否则为nil.请在使用该属性时做判断
 */
@property(nonatomic,copy)NSString* waUserId;
/*!
 @abstract name
 */
@property(nonatomic,copy)NSString* name;
/*!
 @abstract pictureURL
 */
@property(nonatomic,copy)NSString* pictureURL;
/*!
 @abstract is_silhouette
 */
@property(nonatomic,copy)NSString* is_silhouette;
/*!
 @abstract inviteTime
 */
@property(nonatomic,copy)NSDate* inviteTime;
+(WAAppUser*)parserWithResultDict:(NSDictionary*)resultDict platform:(NSString *const)platform;
+(NSArray*)parserWithMultiResultDict:(NSDictionary*)resultDict platform:(NSString *const)platform;
-(void)encodeWithCoder:(NSCoder *)aCoder;
@end
