//
//  WASDKParamConfigObj.h
//  WASDKUI
//
//  Created by wuyx on 15/11/25.
//  Copyright © 2015年 GHW-T-01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WASdkParamConfigObj : NSObject<NSCoding,NSCopying>
@property(nonatomic)BOOL enableExtend;
@property(nonatomic)BOOL enableHotPatch;
@property(nonatomic,copy)NSString* afadAppKey;
@property(nonatomic,copy)NSString* fbSecretKey;
@property(nonatomic,copy)NSString* rewardType;
@property(nonatomic)float reorderLimitTime;
@property(nonatomic) NSInteger paymentReportTime;
@property(nonatomic) float heartbeatIntervalTime;
@property(nonatomic)int eventCacheNumberLimit;
@property(nonatomic)int eventCacheTimeLimit;
@property(nonatomic,copy)NSString* eventTypeImmediate;
@property(nonatomic,strong)NSNumber* enableNewAccount;
@property(nonatomic,strong)NSNumber* enableChangeAccount;
@property(nonatomic,strong)NSNumber* isTestDevice;
+(WASdkParamConfigObj*)parserWithDict:(NSDictionary*)dict;
@end
