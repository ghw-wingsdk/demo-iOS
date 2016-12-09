//
//  WASDKCrashInfo.h
//  WASDKUI
//
//  Created by wuyx on 15/12/17.
//  Copyright © 2015年 GHW-T-01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WASdkCrashInfo : NSObject<NSCoding,NSCopying>
@property(nonatomic,copy)NSString* sdkId;
@property(nonatomic,copy)NSString* sdkVer;
@property(nonatomic,copy)NSString* patchId;
@property(nonatomic,copy)NSString* patchVer;
@property(nonatomic,copy)NSString* os;
@property(nonatomic,copy)NSString* osVersion;
@property(nonatomic,copy)NSString* mobileModel;
@property(nonatomic,copy)NSString* packageId;
@property(nonatomic,copy)NSString* packageVerName;
@property(nonatomic,copy)NSString* packageVerCode;
@property(nonatomic,copy)NSString* clientId;
@property(nonatomic,copy)NSString* appId;
@property(nonatomic,copy)NSString* userId;
@property(nonatomic,copy)NSString* crashTimestamp;
@property(nonatomic,copy)NSString* exceptionInfo;
@property(nonatomic,copy)NSString* extInfo;
@end
