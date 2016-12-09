//
//  WAITrack.h
//  WASdkIntfUI
//
//  Created by GHW-T-01 on 16/3/1.
//  Copyright © 2016年 GHW-T-01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WASdkIntf/WASdkIntf.h>
@interface WASdkTrack : WAITrack
@property(copy,nonatomic)NSString *deviceid;
@property(copy,nonatomic)NSString *deviceType;
@property(copy,nonatomic)NSString *deviceBrand;
@property(copy,nonatomic)NSString *idfa;
@property(copy,nonatomic)NSString *model;
@property(copy,nonatomic)NSString *op;
@property(copy,nonatomic)NSString *os;
@property(copy,nonatomic)NSString *tz;
@property(copy,nonatomic)NSString *currencyCode;

@property(copy,nonatomic)NSString *userId;
@property(strong,nonatomic)NSDictionary* mapping;
@property(strong,nonatomic)NSDictionary* trackerConfig;
@property(copy,nonatomic)NSString *url;
+(WASdkTrack*)shareTracker;
+(NSString*)getSessionId;
@end
