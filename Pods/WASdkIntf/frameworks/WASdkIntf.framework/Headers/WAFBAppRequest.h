//
//  GHWSDKAppRequest.h
//  GHWSdkUI
//
//  Created by wuyx on 15/7/17.
//  Copyright (c) 2015年 GHW-T-01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WAAppUser.h"
#import "WAFBObject.h"
#import "WAFBApplication.h"
/*!
 @discussion WAFBApplication
 - - -
 */
@interface WAFBAppRequest : NSObject
/*!
 @abstract ID
 */
@property(nonatomic,copy)NSString* ID;
/*!
 @abstract message
 */
@property(nonatomic,copy)NSString* message;
/*!
 @abstract created_time
 */
@property(nonatomic,copy)NSString* created_time;
/*!
 @abstract action_type
 */
@property(nonatomic,copy)NSString* action_type;
/*!
 @abstract from
 */
@property(nonatomic,copy)WAAppUser* from;
/*!
 @abstract to
 */
@property(nonatomic,copy)WAAppUser* to;
/*!
 @abstract object
 */
@property(nonatomic,copy)WAFBObject* object;
/*!
 @abstract application
 */
@property(nonatomic,copy)WAFBApplication* application;
/*!
 @abstract data
 */
@property(nonatomic,copy)NSDictionary* data;
@end
