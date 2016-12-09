//
//  GHWSDKFBApplication.h
//  GHWSdkUI
//
//  Created by wuyx on 15/9/15.
//  Copyright (c) 2015年 GHW-T-01. All rights reserved.
//

#import <Foundation/Foundation.h>
/*!
 @discussion WAFBApplication
 - - -
 */
@interface WAFBApplication : NSObject<NSCoding,NSCopying>
/*!
 @abstract ID
 */
@property(nonatomic,strong)NSString* ID;
/*!
 @abstract name
 */
@property(nonatomic,strong)NSString* name;
/*!
 @abstract name_space
 */
@property(nonatomic,strong)NSString* name_space;
/*!
 @abstract category
 */
@property(nonatomic,strong)NSString* category;
/*!
 @abstract link
 */
@property(nonatomic,strong)NSString* link;
+(WAFBApplication *)parserWithResultDict:(NSDictionary *)resultDict;
@end
