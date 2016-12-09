//
//  GHWSDKGift.h
//  GHWSdkUI
//
//  Created by wuyx on 15/7/16.
//  Copyright (c) 2015年 GHW-T-01. All rights reserved.
//

#import <Foundation/Foundation.h>
/*!
 @discussion WAFBObject
 - - -
 */
@interface WAFBObject : NSObject<NSCopying>
/*!
 @abstract ID
 */
@property(nonatomic,copy)NSString* ID;
/*!
 @abstract type
 */
@property(nonatomic,copy)NSString* type;
/*!
 @abstract title
 */
@property(nonatomic,copy)NSString* title;
/*!
 @abstract imageUrls
 */
@property(nonatomic,copy)NSString* imageUrls;
/*!
 @abstract created_time
 */
@property(nonatomic,copy)NSString* created_time;
/*!
 @abstract oDescription
 */
@property(nonatomic,copy)NSString* oDescription;
/*!
 @abstract is_scraped
 */
@property(nonatomic)Boolean is_scraped;
/*!
 @abstract data
 */
@property(nonatomic,copy)NSDictionary* data;
+(WAFBObject*)parserWithResultDict:(NSDictionary*)dict;
@end
