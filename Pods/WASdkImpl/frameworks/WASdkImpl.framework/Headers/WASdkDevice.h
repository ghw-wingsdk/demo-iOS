//
//  WASDKDevice.h
//  WASDKUI
//
//  Created by wuyx on 15/7/22.
//  Copyright (c) 2015年 GHW-T-01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface WASdkDevice : NSObject
+(UIDevice*)getDevice;

+(NSString*)getSystemName;

+(NSString*)getSystemVersion;

+(NSString*)getName;

+(NSString*)getModel;

+(NSString*)getLocalizedModel;

+(NSUUID*)getIDFV;

+(NSString*)getDeviceType;

+(NSString*)getDeviceBrand;
@end
